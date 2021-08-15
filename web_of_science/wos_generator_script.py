import subprocess
import os
import stat
from multiprocessing import pool, cpu_count
import shutil
import datetime
import psycopg2

path='/home/drorsh/Projects/Experiments/wosParser'

def splitFiles(x):
    if not x.endswith('.xml'):
        return
    print(str(x) + ' split start at ' + str(datetime.datetime.now()))
    d=0
    c=999999999999
    BUF_SIZE = 4096
    size = os.stat(path + '/wosRaw/'+x)[stat.ST_SIZE]
    chunk_size = 25000000
    if not os.path.exists(path + '/wosRaw/split'):
        os.makedirs(path + '/wosRaw/split')

    xmlFile = open(path + '/wosRaw/'+x, "r+")

    while size > chunk_size:
        xmlFile.seek(-min(size, chunk_size), 2)
        notRoot=1
        d=0
        while notRoot==1:
            e=xmlFile.readline()
            f=e
            if e[0:6].lower()=='</rec>':
                notRoot=0
        oldPos = xmlFile.tell()
        with open(path+"/wosRaw/split/{}{}.xml".format(x,c), "w") as out:
            b = xmlFile.read(BUF_SIZE)
            out.write("""<?xml version="1.0" encoding="UTF-8"?> 
             <!-- Copyright (c) 2017 Clarivate Analytics Web of Science  -->
            <records xmlns="http://scientific.thomsonreuters.com/schema/wok5.4/public/FullRecord">\n""")


            while len(b) > 0:
                out.write(b)
                b = xmlFile.read(BUF_SIZE)
            if d!=0:
                out.write("""</records>
                                </xml>""")
            else:
                d=1
        xmlFile.truncate(oldPos)
        size = os.stat(path + '/wosRaw/'+x)[stat.ST_SIZE]
        c -= 1
    print(str(x) + ' split end at ' + str(datetime.datetime.now()))


def iterateInsert(fileName):
    if fileName.endswith('.txt'):
        conn = psycopg2.connect("dbname=postgres user=postgres host=localhost port=5432 password=password")
        print ("Start time for %s: %s") % (fileName, datetime.datetime.now())
        with open(path + '/output/' + fileName, 'r') as f:
            sqlRead = f.read()
            if sqlRead.find('COMMIT;') == sqlRead.rfind('COMMIT;'):
                if sqlRead.find('COMMIT;') == -1:
                    sqlRead += 'COMMIT;'
            elif sqlRead.find('COMMIT;') == -1:
                sqlRead += 'COMMIT;'
            else:
                sqlRead = sqlRead[:-7]
            if sqlRead.find('BEGIN;') == sqlRead.rfind('BEGIN;'):
                if sqlRead.find('BEGIN;') == -1:
                    sqlRead = 'BEGIN;' + sqlRead
            elif sqlRead.find('BEGIN;') == -1:
                sqlRead = 'BEGIN;' + sqlRead
            else:
                sqlRead = sqlRead[7:]
            try:
                cur = conn.cursor()
                cur.execute(sqlRead)
                conn.commit()
                cur.close()
                print(str(fileName))
                with open(path + '/output/done/done.txt', 'a+') as file:
                    file.write(str(fileName) + '\n')
                shutil.move(path + '/output/' + fileName,
                            path + '/output/done/' + fileName)
            except Exception as e:
                with open(path + '/output/done/errors{}.txt'.format(runNumber), 'a+') as errors:
                    errors.write(str(e) + '\n\n')
                    errors.write(fileName + '\n\n\n')
        conn.close()
        print ("End time for %s: %s") % (fileName, datetime.datetime.now())

def errorSplit(fileName):
    if fileName.endswith('.txt'):
        c = 9999999999
        print(str(fileName))
        BUF_SIZE = 4096
        size = os.stat(path + '/output/' + fileName)[stat.ST_SIZE]
        chunk_size = chunkVersion
        if size<chunk_size+50000:
            return

        xmlFile = open(path + '/output/' + fileName, "r+")

        while size > chunk_size:
            xmlFile.seek(-min(size, chunk_size), 2)
            notRoot = 1
            d = 0
            while notRoot == 1:
                e = xmlFile.readline()
                f = e
                if e[-3:].strip().lower() == ');':
                    notRoot = 0
            oldPos = xmlFile.tell()
            with open(path + '/output/{}_{}.txt'.format(fileName, c), "w") as out:
                b = xmlFile.read(BUF_SIZE)
                out.write("BEGIN;")
                out.write("\n")

                while len(b) > 0:
                    out.write(b)
                    b = xmlFile.read(BUF_SIZE)
                out.write("COMMIT;")
            xmlFile.truncate(oldPos)
            size = os.stat(path + '/output/' + fileName)[stat.ST_SIZE]
            c -= 1




def finalErrorFix(fileName):
    if fileName.endswith('.txt') or fileName.endswith('.sql'):
        with open(path + '/output/' + fileName, 'r') as f:
            conn = psycopg2.connect("dbname=postgres user=postgres host=localhost port=5432 password=password")
            print(fileName)
            lastLine = ''
            for line in f:
                if line.strip() != '' and line.strip() != "BEGIN;" and line.strip() != "COMMIT;":
                    if line.strip().endswith(';'):
                        if lastLine != '':
                            sqlLine = lastLine + line.strip()
                            lastLine = ''
                        else:
                            sqlLine = line.strip()
                        try:
                            cur = conn.cursor()
                            cur.execute(sqlLine)
                            conn.commit()
                            cur.close()
                        except Exception as e:
                            with open(path + '/output/done/errors{}.txt'.format(runNumber), 'a+') \
                                    as errors:
                                errors.write(str(e) + '\n\n')
                                errors.write(fileName + '\n\n\n')
                    else:
                        lastLine += line.strip()
        with open(path + '/output/done/done2.txt', 'a+') as file:
            file.write(str(fileName) + '\n')
        shutil.move(path + '/output/' + fileName,
                    path + '/output/done/' + fileName)



filesToSplit=os.listdir(path + '/wosRaw/')
print(filesToSplit)
procCount = cpu_count()
pol = pool.Pool(procCount)
pol.map(splitFiles, filesToSplit)
pol.close()

for y in os.listdir(path + '/wosRaw/'):
    if y.endswith('.xml'):
        shutil.move(path + '/wosRaw/'+str(y),
                    path + '/wosRaw/split/'+str(y))


callString='python2 /home/drorsh/Projects/Experiments/wosParser/generic_parser.py -d /home/drorsh/Projects/Experiments/wosParser/wosRaw/split -p records ' \
           '-r REC -i UID -n {http://scientific.thomsonreuters.com/schema/wok5.4/public/FullRecord} -o  ' \
           '/home/drorsh/Projects/Experiments/wosParser/output -c /home/drorsh/Projects/Experiments/wosParser/config/wos_config.xml ' \
           '-t /home/drorsh/Projects/Experiments/wosParser/config/wos_template.sql ' \
           '-m Postgres -s True'
subprocess.call(callString, shell=True)




chunkVersion=15000000
errorFilesToSplit=os.listdir(path + '/output/')
pol = pool.Pool(procCount)
pol.map(errorSplit, errorFilesToSplit)
pol.close()
runNumber=1
fileNameList=os.listdir(path + '/output/')
procCount = cpu_count()
pol = pool.Pool(procCount)
pol.map(iterateInsert, fileNameList)
pol.close()

runNumber=2
chunkVersion=7500000
errorFilesToSplit=os.listdir(path + '/output/')
pol1 = pool.Pool(procCount)
pol1.map(errorSplit, errorFilesToSplit)
pol1.close()
fileNameList2=os.listdir(path + '/output/')
pol2 = pool.Pool(procCount)
pol2.map(iterateInsert, fileNameList2)
pol2.close()

runNumber=3
chunkVersion=3500000
errorFilesToSplit=os.listdir(path + '/output/')
pol3 = pool.Pool(procCount)
pol3.map(errorSplit, errorFilesToSplit)
pol3.close()
fileNameList2=os.listdir(path + '/output/')
pol4 = pool.Pool(procCount)
pol4.map(iterateInsert, fileNameList2)
pol4.close()

runNumber=4
chunkVersion=750000
errorFilesToSplit=os.listdir(path + '/output/')
pol5 = pool.Pool(procCount)
pol5.map(errorSplit, errorFilesToSplit)
pol5.close()
fileNameList2=os.listdir(path + '/output/')
pol6 = pool.Pool(procCount)
pol6.map(iterateInsert, fileNameList2)
pol6.close()

runNumber=5
fileNameList3=os.listdir(path + '/output/')
pol7 = pool.Pool(procCount)
pol7.map(finalErrorFix, fileNameList3)
pol7.close()

