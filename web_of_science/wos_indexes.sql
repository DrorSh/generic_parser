CREATE  INDEX summemail_key_idx ON public.wos_summary_names_email_addr (id, name_id, email_id);

CREATE  INDEX confikey_idx ON public.wos_conf_info (id, conf_record_id, info_id);

CREATE  INDEX conftkey_idx ON public.wos_conf_title (id, conf_record_id, title_id);

CREATE  INDEX confdkey_idx ON public.wos_conf_date  (id, conf_record_id, date_id);

CREATE  INDEX conflkey_idx ON public.wos_conf_location  (id, conf_record_id, location_id);

CREATE  INDEX confskey_idx ON public.wos_conf_sponsor  (id, conf_record_id, sponsor_id);

CREATE  INDEX pubnmakey_idx ON public.wos_publisher_names  (id, publisher_id, name_id);

CREATE  INDEX refkey_idx ON public.wos_references  (id, ref_ctr);

CREATE  INDEX addnamekey_idx ON public.wos_address_names  (id, addr_id, name_id);

CREATE  INDEX addemailkey_idx ON public.wos_address_names_email_addr  (id, addr_id, name_id, email_id);

CREATE  INDEX addzipkey_idx ON public.wos_address_zip (id, addr_id, zip_id);

CREATE  INDEX addorgkey_idx ON public.wos_address_organizations  (id, addr_id, org_id);

CREATE  INDEX addsuborgkey_idx ON public.wos_address_suborganizations  (id, addr_id, suborg_id);

CREATE  INDEX grantidkey_idx ON public.wos_grant_ids (id, grant_id, id_id);

CREATE  INDEX abparakey_idx ON public.wos_abstract_paragraphs (id, abstract_id, paragraph_id);

CREATE  INDEX readdnamekey_idx ON public.wos_reprint_address_names (id, addr_id, name_id);

CREATE  INDEX readdemailkey_idx ON public.wos_reprint_address_names_email_addr (id, addr_id, name_id, email_id);

CREATE  INDEX readdzipkey_idx ON public.wos_reprint_address_zip (id, addr_id, zip_id);

CREATE  INDEX readdorgkey_idx ON public.wos_reprint_address_organizations  (id, addr_id, org_id);

CREATE  INDEX readdsuborgkey_idx ON public.wos_reprint_address_suborganizations (id, addr_id, suborg_id);
        




CREATE  INDEX summ_id_idx ON public.wos_summary (id);
CREATE  INDEX summ_pubyear_idx ON public.wos_summary (pubyear);
 
CREATE  INDEX page_id_idx ON public.wos_page (id);

CREATE  INDEX titles_id_idx ON public.wos_titles (id); 
CREATE  INDEX titles_title_idx ON public.wos_titles (title) INCLUDE (title_type); 

CREATE  INDEX summname_id_idx ONfpublic.wos_summary_names (id);
CREATE  INDEX summname_name_idx ON public.wos_summary_names (last_name, first_name);
CREATE  INDEX summname_rid_idx ON public.wos_summary_names (r_id);
CREATE  INDEX summname_ridtr_idx ON public.wos_summary_names (r_id_tr);
CREATE  INDEX summname_orcidid_idx ON public.wos_summary_names (orcid_id);
CREATE  INDEX summname_orcididtr_idx ON public.wos_summary_names (orcid_id_tr);
CREATE  INDEX summname_daisid_idx ON public.wos_summary_names (dais_id);
CREATE  INDEX summname_daisidtr_idx ON public.wos_summary_names (dais_id_tr);

CREATE  INDEX summemail_id_idx ON public.wos_summary_names_email_addr (id); 

CREATE  INDEX doct_id_idx ON public.wos_doctypes (id); 

CREATE  INDEX normdoct_id_idx ON public.wos_normalized_doctypes (id); 

CREATE  INDEX lang_id_idx ON public.wos_languages  (id);

CREATE  INDEX normlang_id_idx ON public.wos_normalized_languages (id); 

CREATE  INDEX conf_id_idx ON public.wos_conference  (id);

CREATE  INDEX confinfo_id_idx ON public.wos_conf_info  (id);

CREATE  INDEX conftitle_id_idx ON public.wos_conf_title  (id);

CREATE  INDEX confdate_id_idx ON public.wos_conf_date  (id);

CREATE  INDEX confloc_id_idx ON public.wos_conf_location  (id);

CREATE  INDEX confsponsor_id_idx ON public.wos_conf_sponsor  (id);

CREATE  INDEX pub_id_idx ON public.wos_publisher  (id);

CREATE  INDEX pubname_id_idx ON public.wos_publisher_names  (id);

CREATE  INDEX ed_id_idx ON public.wos_edition  (id);

CREATE  INDEX ref_id_idx ON public.wos_references  (id);
CREATE  INDEX ref_refid_idx ON public.wos_references  (ref_id);
CREATE  INDEX ref_doi_idx ON public.wos_references  (doi);
CREATE  INDEX ref_citedauthor_idx ON public.wos_references  (cited_author);
CREATE  INDEX ref_year_idx ON public.wos_references  (year);

CREATE  INDEX add_id_idx ON public.wos_addresses  (id);

CREATE  INDEX addname_id_idx ON public.wos_address_names  (id);

CREATE  INDEX addemail_id_idx ON public.wos_address_names_email_addr  (id);

CREATE  INDEX addzip_id_idx ON public.wos_address_zip  (id);

CREATE  INDEX orgadd_id_idx ON public.wos_address_organizations  (id);

CREATE  INDEX suborgadd_id_idx ON public.wos_address_suborganizations  (id);

CREATE  INDEX headings_id_idx ON public.wos_headings  (id);
CREATE  INDEX headings_headingid_idx ON public.wos_headings  (heading_id);

CREATE  INDEX subhead_id_idx ON public.wos_subheadings  (id);
CREATE  INDEX subhead_subheadingid_idx ON public.wos_subheadings  (subheading_id);

CREATE  INDEX subj_id_idx ON public.wos_subjects  (id);
CREATE  INDEX subj_subjectid_idx ON public.wos_subjects  (subject_id);

CREATE  INDEX grants_id_idx ON public.wos_grants  (id);
CREATE  INDEX grants_grantid_idx ON public.wos_grants  (grant_id);

CREATE  INDEX grantid_id_idx ON public.wos_grant_ids  (id);
CREATE  INDEX grantid_grantid_idx ON public.wos_grant_ids  (grant_id);

CREATE  INDEX key_id_idx ON public.wos_keywords  (id);

CREATE  INDEX ab_id_idx ON public.wos_abstracts  (id);

CREATE  INDEX abpara_id_idx ON public.wos_abstract_paragraphs  (id);

CREATE  INDEX reviewlang_id_idx ON public.wos_reviewed_languages  (id);

CREATE  INDEX reviewauth_id_idx ON public.wos_reviewed_authors  (id);

CREATE  INDEX readd_id_idx ON public.wos_reprint_addresses (id);

CREATE  INDEX renames_id_idx ON public.wos_reprint_address_names  (id);

CREATE  INDEX reemail_id_idx ON public.wos_reprint_address_names_email_addr  (id);

CREATE  INDEX rezip_id_idx ON public.wos_reprint_address_zip  (id);

CREATE  INDEX reorg_id_idx ON public.wos_reprint_address_organizations  (id);

CREATE  INDEX resub_id_idx ON public.wos_reprint_address_suborganizations  (id);

CREATE  INDEX keyplus_id_idx ON public.wos_keywords_plus  (id);

CREATE  INDEX booknotes_id_idx ON public.wos_book_notes  (id);

CREATE  INDEX bookdesc_id_idx ON public.wos_book_desc  (id);

CREATE  INDEX dynid_id_idx ON public.wos_dynamic_identifiers  (id);
CREATE  INDEX dynid_idvals_idx ON public.wos_dynamic_identifiers  (dynamic_id, identifier_value);


CREATE  INDEX contr_id_idx ON public.wos_contributors  (id);
 
 
 