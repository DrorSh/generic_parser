

CREATE MATERIALIZED VIEW author_aggregation
AS
 select wos_standard, first_name, last_name, display_name, orcid_id, r_id, dais_id,
       array_agg(id) as summary_ids,
       array_agg(seq_no) as seq_nos,
       array_agg(role) as roles
from wos_summary_names sumNames
  group by wos_standard, first_name, last_name, display_name, orcid_id, r_id, dais_id
WITH NO DATA;

CREATE MATERIALIZED VIEW references_by_article
AS
select wr.id, array_agg(wr.ref_id) as ref_ids,
       array_agg(case when ws.pubyear is not null then ws.pubyear else wr.year end) as ref_years
from wos_references wr left outer join wos_summary ws on wr.ref_id=ws.id
group by wr.id
WITH NO DATA;


CREATE MATERIALIZED VIEW citations_by_article
AS
select wr.ref_id, array_agg(wr.id) as citations, array_agg(ws.pubyear)
from wos_references wr left outer join wos_summary ws on wr.id=ws.id
  group by wr.ref_id
WITH NO DATA;


CREATE MATERIALIZED VIEW subject_paper_aggregation
AS
select subject, ascatype, array_agg(id) as article_ids
from wos_subjects group by subject, ascatype
WITH NO DATA;

CREATE MATERIALIZED VIEW subjects_aggregation
AS
select trad.id, trad_subjects, ext_subject from
  (select subj1.id, array_agg(subj1.subject) as trad_subjects
from wos_subjects subj1 where subj1.ascatype='traditional'
group by subj1.id) as trad left outer join (select subj1.id, array_agg(subj1.subject) as ext_subject
from wos_subjects subj1 where subj1.ascatype='extended'
group by subj1.id) as ext on trad.id=ext.id
WITH NO DATA;


CREATE MATERIALIZED VIEW titles_journal_aggregation
AS
select title as journal_title , array_agg(id) as article_ids
from wos_titles
where title_type='source'
group by title
WITH NO DATA;


CREATE MATERIALIZED VIEW journals_author_aggregation
AS
select sum1.wos_standard, sum1.first_name, sum1.last_name, sum1.display_name, sum1.orcid_id, sum1.r_id, sum1.dais_id,
       titl1.title,
       array_agg(sum1.id) as summary_ids
from wos_summary_names sum1 inner join wos_titles titl1 on titl1.title_type='source' and sum1.id=titl1.id
group by wos_standard, first_name, last_name, display_name, orcid_id, r_id, dais_id, title
WITH NO DATA;

CREATE MATERIALIZED VIEW article_author_aggregation
AS
SELECT id,
    array_agg( ARRAY[wos_standard, first_name, last_name, display_name, orcid_id, r_id, dais_id])
   FROM wos_summary_names
  GROUP BY id
WITH NO DATA;

refresh materialized view citations_by_article;
refresh materialized view references_by_article;
refresh materialized view subjects_aggregation;
refresh materialized view author_aggregation;
refresh materialized view subject_paper_aggregation;
refresh materialized view article_author_aggregation;
refresh materialized view titles_journal_aggregation;
refresh materialized view journals_author_aggregation;


create index citOfIDidx on citations_by_article (id);
create index citByIDidx on references_by_article (id);
create index subjIDidx on subjects_aggregation (id);
create index authFirstLastidx on author_aggregation (last_name, first_name);
create index authDisplayidx on author_aggregation (display_name);
create index authWOStandardidx on author_aggregation (wos_standard);
create index authOrdcididx on author_aggregation (orcid_id);
create index authDaisidx on author_aggregation (dais_id);
create index authRidx on author_aggregation (r_id);
create index titleIdx on titles_journal_aggregation (journal_title);
create index authTitlFirstLastidx on journals_author_aggregation (last_name, first_name);
create index authTitlFirstidx on journals_author_aggregation (first_name);
create index authTitlLastidx on journals_author_aggregation (last_name);
create index authTitlDisplayidx on journals_author_aggregation (display_name);
create index authTitlWOStandardidx on journals_author_aggregation (wos_standard);
create index authTitlOrdcididx on journals_author_aggregation (orcid_id);
create index authTitlDaisidx on journals_author_aggregation (dais_id);
create index authTitlRidx on journals_author_aggregation (r_id);
create index authTitlTitleidx on journals_author_aggregation (title);
create index authTitlTitlFirstLastidx on journals_author_aggregation (last_name, first_name, title);
create index authTitlTitlFirstidx on journals_author_aggregation (last_name, title);
create index authTitlTitlLastidx on journals_author_aggregation (first_name, title);
create index authTitlTitlDisplayidx on journals_author_aggregation (display_name, title);
create index authTitlTitlWOStandardidx on journals_author_aggregation (wos_standard, title);
create index authTitlTitlOrdcididx on journals_author_aggregation (orcid_id, title);
create index authTitlTitlDaisidx on journals_author_aggregation (dais_id, title);
create index authTitlTitlRidx on journals_author_aggregation (r_id, title);
create index idArtAuthIDidx on article_author_aggregation (id);
create index subjSubjAggIdx on subject_paper_aggregation (subject);


