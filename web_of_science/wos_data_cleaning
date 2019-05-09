delete from public.wos_page a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_titles a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_summary_names a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_keywords_plus a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_book_notes a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_book_desc a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_dynamic_identifiers a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_contributors a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_doctypes a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_normalized_doctypes a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_languages a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_normalized_languages a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_conference a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_publisher a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_edition a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_references a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_addresses a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_headings a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_subheadings a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_subjects a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_grants a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_keywords a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_abstracts a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_reviewed_languages a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_reviewed_authors a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_reprint_addresses a
            where not exists (select 1 from wos_summary ws where ws.id=a.id);

delete from  public.wos_summary_names_email_addr a
 
where not exists (select 1 from wos_summary_names ws where ws.id=a.id and ws.name_id=a.name_id);

delete from  public.wos_conf_info a
            where not exists (select 1 from public.wos_conference wc where wc.id=a.id and wc.conf_record_id=a.conf_record_id);

delete from  public.wos_conf_title a 
            where not exists (select 1 from public.wos_conference wc where wc.id=a.id and wc.conf_record_id=a.conf_record_id);

delete from  public.wos_conf_date a 
            where not exists (select 1 from public.wos_conference wc where wc.id=a.id and wc.conf_record_id=a.conf_record_id);

delete from  public.wos_conf_location a
            where not exists (select 1 from public.wos_conference wc where wc.id=a.id and wc.conf_record_id=a.conf_record_id);

delete from  public.wos_conf_sponsor a            
            where not exists (select 1 from public.wos_conference wc where wc.id=a.id and wc.conf_record_id=a.conf_record_id);

delete from  public.wos_publisher_names a
            where not exists (select 1 from public.wos_publisher wc where wc.id=a.id and wc.publisher_id=a.publisher_id);

delete from  public.wos_address_names a 
            where not exists (select 1 from public.wos_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_address_names_email_addr a 
            where not exists (select 1 from public.wos_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id and wc.name_id=a.name_id);

delete from  public.wos_address_zip a 
            where not exists (select 1 from public.wos_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_address_organizations a 
            where not exists (select 1 from public.wos_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_address_suborganizations a 
            where not exists (select 1 from public.wos_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_grant_ids a 
            where not exists (select 1 from public.wos_grants wc where wc.id=a.id and wc.grant_id=a.grant_id);

delete from  public.wos_abstract_paragraphs a 
            where not exists (select 1 from public.wos_abstracts wc where wc.id=a.id and wc.abstract_id=a.abstract_id);

delete from  public.wos_reprint_address_names a 
            where not exists (select 1 from public.wos_reprint_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_reprint_address_names_email_addr a 
            where not exists (select 1 from public.wos_reprint_address_names wc where wc.id=a.id and wc.addr_id=a.addr_id and wc.name_id=a.name_id);

delete from  public.wos_reprint_address_zip a 
            where not exists (select 1 from public.wos_reprint_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_reprint_address_organizations a 
            where not exists (select 1 from public.wos_reprint_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);

delete from  public.wos_reprint_address_suborganizations a 
            where not exists (select 1 from public.wos_reprint_addresses wc where wc.id=a.id and wc.addr_id=a.addr_id);
