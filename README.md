# Note about project

This is a small modification of the CNS-IU generic parser project which aims to make it easier for people who have access to Clarivate XML WoS files to turn them into a working PostgreSQL database. Below you will find the read me information from the original CNS-IU project. First there will be an explanation of the steps to use my modified version. The code for splitting files is a variation of code found [on Stack Overflow](https://stackoverflow.com/questions/1145286/change-python-file-in-place)

#How to Use this fork

What follows are the set up steps to create a copy of the WOS database from the XML files. In order to complete the steps you will need to have downloaded the XML files and this fork of IU CNS "generic\_parser-master"  Git Hub repository to a shared directory, which also contains copies of the following files I created: "wos_schmea_final.sql", "wos\_constraints_primary_keys.sql", "wos\_generator\_script.py", "wos_constraints\_foreign_keys.sql", and "wos_materialized_views.sql".

##Create the Database
The first step in the process of generating the database is to create the database in a PostgreSQL instance. For this I used the data model and SQL code generated by Indiana University's CNS which they made public. Specifically I copy and pasted the code from the file "wos\_schmea\_final.sql" into my SQL development environment and executed all statements. The code only generates the tables, it does not create primary keys, indexes, or foreign key relationships with the exception of a primary key on the id column of wos\_summaries. Then due to the issues of duplicate entries mentioned above I also run the code from "wos\_constraints\_primary\_keys.sql" to generate the primary keys for the rest of the tables. This will make sure no duplicate rows are added, but it will also noticeably slow down insertion of data into the database. I made this choice as I learned during my initial attempt at building the database that cleaning it up after the fact is a much larger headache than having it be slower during its creation, and the time addition should be similar to the amount of time to clean up and generate those primary key relationships post-initial build. 

##Run Generator Script

The next step is to edit the "wos_generator_script.py" and replace the string "path='/pathToDirectory/withTheGenericParserMasterFolderAndXMLFilesFolderInIt'" with the actual path to where you stored the repository files and all instances of "/xmlStoragePath/" with the name of the folder, or folder tree, which stores the XML in the same directory the path variable describes. Once those are changed 

###File Split
After some trial and error I determined the most complete solution to the problem of generating batch SQL files of a small enough size to not overload memory was to split the original XML files. The reason I settled on this solution as opposed to splitting the SQL files as I did in my initial build comes as dealing with smaller XML files allows for more efficient parsing. The script which splits these files chunks out the XML into 25 MB files of WOS records from back to front. In order to make sure they remain in a meaningful order each chunk is named with the original file name and a numerical string starting at 999999999999 and decreasing by one with each new chunk.

###XML Parsing
This step again utilizes code developed by IU's CNS. The script was developed to be run in the command line, but I call it using the Subprocess library using the call {code call here}. This script output text files with batch SQL insert commands. The files average around 30-40MB MB which should not cause memory issues. This is a processor and time sensitive step which took over a week on a powerful desktop computer.

###Inserting SQL
The final section of the script utilizes the Psycopg2 Python library to insert the SQL generated during parsing. As there are no foreign key relationships yet established in the database the order of insertion is not of importance, and therefore I used Multiprocessing so multiple batches of SQL can be inserted at once. When a batch SQL file has been succesfully added to the databse the script moves it to a folder in the same directory named "done".

###Error Handling
As was evidenced in the initial build the XML files do contain duplicate data. By establishing the primary keys on all the tables does prevent duplicate rows from being added to tables, but this will cause all of the SQL in that batch to fail to be inserted. Since the batch SQL files are only moved to the "done" folder after a successful insertion, those which fail are all still in the "generic_parser-master/output" folder. In order to make sure the non-duplicate sections of those files are inserted into the database the script will do a series of 4 file splits and inserts. First run the SQL files will be split into 15 MB chunks then 7.5 MB then 3.5 MB and finally 750 KB. Any files left in the "generic_parser-master/output" folder at that point will be parsed SQL statement by SQL statement and inserted individually. Once this is done all the data from the XML files should be in the database. 

##Additional Options

What follow are additional things you can add to make the database more robust and to allow for faster queries in some cases. They are not required for the database to function, but if the time is available they are quite useful additions. The database can be queried while these option are being added, but updates, inserts, and deletions on the tables being indexed or having foreign key relationships established will cause major errors.

###Cleaning out the bonus Data
During the creation of the database there will be data added to some of the tables which is not related to a full record. This data will make it impossible to establish foreign keys as there will be no entry in the referenced table for the data. In order to clean this data out of the database (most of it is refering to publications newer than the XML records, e.g. 2018 publications when the XML records only cover publications up to 2017) run the sql statements in the file "wos_data_cleaning.sql". Once these are done the foreign keys can be established.


###Establish Indexes and Foreign Keys
In order to speed up queries I created a series of indexes which can be created, "wos_indexes.sql", and you can also establish the foreign key relationships defined by IU CNS, "wos_constraints_foreign_keys.sql". Both can be run by pasting the code from the files into a SQL development environment and then executing the statements. The indexes and foreign key relationships take a long time to finish, but they can be run in the background while the database is being used. 

###Create Materialized Views
This final step is very similar to the previous one, except there is only a single file of SQL code to be executed, "wos_materialized_views.sql". In the file there is SQL which will create a series of materialized views optimized for bibliometrics research. Each of the views is created without any data. In order to populate the views all one needs to do is run "refresh materialized view <name_of_view>". It is worth nothing though that unless you are conducting bibliometrics research on the database these views may or may not be useful.



# GENERIC XML PARSER

The generic XML parser is designed to process XML records into SQL script that can then be uploaded into a relational database. The parser converts XML into a series of insert statements based on a configuration file that specifies the tables and columns that are desired by the user.

Created at the [Cyberinfrastructure for Network Science Center at Indiana University](https://cns.iu.edu)

**Contributors:**

- [Robert Light](https://github.com/lightr)
- [Daniel Halsey](https://github.com/dakmh)
- [Bruce Herr](https://github.com/bherr2) (maintainer)

## CHANGELOG

See [CHANGELOG](CHANGELOG.md)

## Example Project

See the [simple example](examples/simple) for a simple layout and example project. The [parse.sh](examples/simple/parse.sh) file shows how to run the parser on the command line with all the necessary options for that example.

## CONFIGURATION OPTIONS

There are a number of configuration options that will need to be set in order to run the parser.

### Input Settings

One of these must be set to indicate which files to process.

**-f --file:** Defines a single file to parse.

**-d --directory:** Defines a directory to parse. All files ending in ".xml" within this directory will be parsed. Subdirectories will NOT be parsed.

### Output Settings

**-o --output:** Defines the output directory to place files in.

### Configuration File Settings

**-c --config:** Defines the configuration file with the map from XML to schema. This must be present. Details on the construction of this file are below.

**-t --template:** This defines a template file which can be used to create wrappers around the insert statements. This is optional. Details on the construction of this file are below.

**-l --file_number:** This defines a CSV file with a mapping from file name to file number. This is optional. File numbers are often helpful for maintaining the most current version of a record. Details on the construction of this file are below.

### XML Configuration Settings

These settings define the basic information that the parser needs to define records.

**-p --parent:** The name of the parent tag of the collection of records to be processed. In many cases, this is the root tag of the entire file, though if only a portion of the file is being processed, this can be defined as a path. (for example: "GreaterFile/CitationSet"). If each file consists of only a single record, this can be the same as the record tag below, but is required.

**-r --record:** The name of the root tag that indicates each specific record to be parsed. "MedlineCitation", "ClinicalTrial", etc. All data contained within this tag and its children will be presumed to be part of the same document. These must be direct children of the parent tag/path. This setting is required.

**-i --identifier:** The name of the tag whose value provides the unique identifier for the record. If this is a child of the record tag, the name of the tag is sufficient. Otherwise, give the path beyond the record tag. This setting is required.

Example:

```xml
<MedlineCitationSet>
 <MedlineCitation>
  …
  <Identifiers>
   <PMID>12345</PMID>
   …
  </Identifiers>
  …
 </MedlineCitation>
 <MedlineCitation>
  …
  <Identifiers>
   <PMID>11111</PMID>
   …
  </Identifiers>
  …
 </MedlineCitation>
 …
</MedlineCitationSet>
```

For this set:

-p would be MedlineCitationSet

-r would be MedlineCitation

-i would be Identifiers/PMID

### Other settings

**-n --namespace:** This setting can be used if the XML has a defined namespace. Currently XML with only one namespace can be managed by the parser. This setting is optional.

**-s --single_trans:** If True, this setting will place a wrapper around each file creating a single transaction for that file. This may help performance in some settings where statements are otherwise automatically committed. This cannot be used if the template includes a transaction statement.

## BUILDING THE CONFIGURATION FILES

### Schema Configuration

The Schema Configuration file tells the parser what sort of database to build out of the XML.

Consider the following example XML that we want to convert into a database:

```xml
<People>
 <Person name="Joe">
  <Emp_Id>12435</Emp_Id>
  <State>Indiana</State>
  <Color>Red</Color>
  <Car color="Blue">Ford</Car>
  <Car color="White">Nissan</Car>
 </Person>
 <Person name="Amy">
  <Emp_Id>12435</Emp_Id>
 …and many more people after that
</People>
```

where we know that every person has a unique Emp_Id.

Ideally, a schema should be designed from a DTD or XSD that clearly defines every acceptable tag within the XML schema, but we will assume that the data you see here is a complete record.

With this in mind, we design a database schema and create the empty database on our DB server.

Now we need to know our settings. The parent is the `<People>` tag. This is the collection of records. The record tag is `<Person>`. The person is our record of interest and everything within that tag refers to the same person. The identifier tag is `<Emp_Id>`. Our list might include a dozen Joe's, but only one 12345.

Now we need a configuration file to tell the parser where to put each element of the XML. Here's what that looks like

```xml
<People>
 <Person table="employee_list" file_number="employee_list:file_number" name="employee_list:name">
  <Emp_Id></Emp_Id>
  <State>employee_list:state</State>
  <Color>employee_list:color</Color>
  <Car table="emp_cars" ctr_id="emp_cars:car_ctr" color="emp_cars:color">emp_cars:car</Car>
 </Person>
</People>
```

`<People>` is our root. We don't have to do anything with it.  It defines the section of the file that we're interested in. If there was more to this XML file outside of `<People>…</People>`, it would be ignored. Starting with person, we define the table that matches to the record. This first table, which we name "employee_list" will be central to the database. We also being assigning columns with the name attribute, which we assign to "employee_list:name". We can assign any attribute to a column on a table that has been defined by that tag or one of its ancestors.

We can do the same with values or the values of children. We assign the value of State to "employee_list:state". Note that this requires some knowledge of the data. If we tried to do the same thing for Car, we're have a big problem, since there is more than one value to write.

The Car tag is part of a one-to-many relationship, so it requires a new table. We define this by creating a new table attribute, giving the name of the new table "emp_cars", but we also need a counter, which we define with the ctr_id "emp_cars:car_ctr"

Every new table after the first one MUST have a ctr_id defined. The identifier serves as the counter for the first table. All other counters will be sequential, counting up from 1 within their context. In other words, if Amy has cars, they'll start counting from 1 for her.

Now, each instance of the `<Car>` tag will create a new row in the emp_cars table. Within that tag, we can assign attributes and values to that row, so we assign the color attribute and the value to columns in the emp_cars table.

There is one more special attribute in the config file, the file_number. This allows the user to insert a file_number into a table, using the File Number Index explained below. This can be very helpful in dealing with records that may be overwritten later in a collection.

Note that we don't do anything with Emp_Id. Since we named it the identifier, it automatically gets added to every table as the id column. We could reassign it to a second column within the table if we wanted, but that would be redundant.

Here is the output when the XML for Joe above is run through the config file.

```sql
INSERT INTO `employee_list` (`id`, `file_number`, `name`, `state`, `color`) VALUES (12345, 15, 'Joe', 'Indiana', 'Red');
INSERT INTO `emp_cars` (`id`, `car_ctr`, `car`, `color`) VALUES (12345, 1, 'Ford', 'Blue');
INSERT INTO `emp_cars` (`id`, `car_ctr`, `car`, `color`) VALUES (12345, 2, 'Nissan', 'White');
```

### Template File

The template file is designed to give a wrapper for the INSERT statements generated by the parser. This template is applied once per record.

The template recognizes three variables for insertion into the template.

**$data** – The series of INSERT statements generated for that record. It is best to always put this on its own line in the template file.

**$file_number** – The file number gathered from the File Number Index.

**$id** – The identifier for the record.

So a simple template designed to only keep the most current version of a record may look like this:

```sql
USE employee_db;

BEGIN

DELETE FROM `employee_list` WHERE `id` = $id AND file_number <= $file_number;

$data

COMMIT;
```

Applying this to our output from above, we might get this:

```sql
USE employee_db;

BEGIN

DELETE FROM `employee_list` WHERE `id` = 12345 AND file_number <= 15;

INSERT INTO `employee_list` (`id`, `file_number`, `name`, `state`, `color`) VALUES (12345, 15, 'Joe', 'Indiana', 'Red');

INSERT INTO `emp_cars` (`id`, `car_ctr`, `car`, `color`) VALUES (12345, 1, 'Ford', 'Blue');

INSERT INTO `emp_cars` (`id`, `car_ctr`, `car`, `color`) VALUES (12345, 2, 'Nissan', 'White');

COMMIT;
```

Assuming that primary and foreign keys are set up within the database and are set to cascade on deletion, then this script should do the following:

If there were no older data: Write the new data.

If there were older data: Delete that and then write in the new data.

If there were NEWER data: Fail on the first insert and rollback, leaving the more current data intact.

Exact syntax will vary by DBMS.

### File Number Index

This is the most straightforward of the files to build. It is a simple csv file of the format:

```csv
name,file_number
filename1,number
filename2,number
…
```

Numbers do not need to be sequential or even unique, to allow maximum flexibility for the user's purposes. The header is not required.
