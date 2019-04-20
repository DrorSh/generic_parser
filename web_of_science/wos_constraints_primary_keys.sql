ALTER TABLE ONLY public.wos_page
        ADD CONSTRAINT unique_page_summary UNIQUE (id, page_id);

ALTER TABLE ONLY public.wos_titles
        ADD CONSTRAINT unique_titles_summary UNIQUE (id, title_id);

ALTER TABLE ONLY public.wos_summary_names
        ADD CONSTRAINT unique_summary_names UNIQUE (id, name_id);

ALTER TABLE ONLY public.wos_summary_names_email_addr
        ADD CONSTRAINT unique_summary_names_email_addr UNIQUE (id, name_id, email_id);

ALTER TABLE ONLY public.wos_doctypes
        ADD CONSTRAINT unique_doctypes UNIQUE (id, doctype_id);

ALTER TABLE ONLY public.wos_normalized_doctypes
        ADD CONSTRAINT unique_normalized_doctypes UNIQUE (id, doctype_id);

ALTER TABLE ONLY public.wos_languages
        ADD CONSTRAINT unique_languages UNIQUE (id, language_id);

ALTER TABLE ONLY public.wos_normalized_languages
        ADD CONSTRAINT unique_normalized_languages UNIQUE (id, language_id);

ALTER TABLE ONLY public.wos_conference
        ADD CONSTRAINT unique_conference UNIQUE (id, conf_record_id);

ALTER TABLE ONLY public.wos_conf_info
        ADD CONSTRAINT unique_conf_info UNIQUE (id, conf_record_id, info_id);

ALTER TABLE ONLY public.wos_conf_title
        ADD CONSTRAINT unique_conf_title UNIQUE (id, conf_record_id, title_id);

ALTER TABLE ONLY public.wos_conf_date
        ADD CONSTRAINT unique_conf_date UNIQUE (id, conf_record_id, date_id);

ALTER TABLE ONLY public.wos_conf_location
        ADD CONSTRAINT unique_conf_location UNIQUE (id, conf_record_id, location_id);

ALTER TABLE ONLY public.wos_conf_sponsor
        ADD CONSTRAINT unique_conf_sponsor UNIQUE (id, conf_record_id, sponsor_id);

ALTER TABLE ONLY public.wos_publisher
        ADD CONSTRAINT unique_publisher UNIQUE (id, publisher_id);

ALTER TABLE ONLY public.wos_publisher_names
        ADD CONSTRAINT unique_publisher_names UNIQUE (id, publisher_id, name_id);

ALTER TABLE ONLY public.wos_edition
        ADD CONSTRAINT unique_edition UNIQUE (id, edition_ctr);

ALTER TABLE ONLY public.wos_references
        ADD CONSTRAINT unique_references UNIQUE (id, ref_ctr);

ALTER TABLE ONLY public.wos_addresses
        ADD CONSTRAINT unique_addresses UNIQUE (id, addr_id);

ALTER TABLE ONLY public.wos_address_names
        ADD CONSTRAINT unique_address_names UNIQUE (id, addr_id, name_id);

ALTER TABLE ONLY public.wos_address_names_email_addr
        ADD CONSTRAINT unique_address_names_email_addr UNIQUE (id, addr_id, name_id, email_id);

ALTER TABLE ONLY public.wos_address_zip
        ADD CONSTRAINT unique_address_zip UNIQUE (id, addr_id, zip_id);

ALTER TABLE ONLY public.wos_address_organizations
        ADD CONSTRAINT unique_address_organizations UNIQUE (id, addr_id, org_id);

ALTER TABLE ONLY public.wos_address_suborganizations
        ADD CONSTRAINT unique_address_suborganizations UNIQUE (id, addr_id, suborg_id);

ALTER TABLE ONLY public.wos_headings
        ADD CONSTRAINT unique_headings UNIQUE (id, heading_id);

ALTER TABLE ONLY public.wos_subheadings
        ADD CONSTRAINT unique_subheadings UNIQUE (id, subheading_id);

ALTER TABLE ONLY public.wos_subjects
        ADD CONSTRAINT unique_subjects UNIQUE (id, subject_id);

ALTER TABLE ONLY public.wos_grants
        ADD CONSTRAINT unique_grants UNIQUE (id, grant_id);

ALTER TABLE ONLY public.wos_grant_ids
        ADD CONSTRAINT unique_grant_ids UNIQUE(id, grant_id, id_id);

ALTER TABLE ONLY public.wos_keywords
        ADD CONSTRAINT unique_keywords UNIQUE (id, keyword_id);

ALTER TABLE ONLY public.wos_abstracts
        ADD CONSTRAINT unique_abstracts UNIQUE (id, abstract_id);

ALTER TABLE ONLY public.wos_abstract_paragraphs
        ADD CONSTRAINT unique_abstract_paragraphs UNIQUE(id, abstract_id, paragraph_id);

ALTER TABLE ONLY public.wos_reviewed_languages
        ADD CONSTRAINT unique_reviewed_languages UNIQUE (id, language_id);

ALTER TABLE ONLY public.wos_reviewed_authors
        ADD CONSTRAINT unique_reviewed_authors UNIQUE (id, author_id);

ALTER TABLE ONLY public.wos_reprint_addresses
        ADD CONSTRAINT unique_reprint_addresses UNIQUE (id, addr_id);

ALTER TABLE ONLY public.wos_reprint_address_names
        ADD CONSTRAINT unique_reprint_address_names UNIQUE (id, addr_id, name_id);

ALTER TABLE ONLY public.wos_reprint_address_names_email_addr
        ADD CONSTRAINT unique_reprint_address_names_email_addr UNIQUE (id, addr_id, name_id, email_id);

ALTER TABLE ONLY public.wos_reprint_address_zip
        ADD CONSTRAINT unique_reprint_address_zip UNIQUE (id, addr_id, zip_id);

ALTER TABLE ONLY public.wos_reprint_address_organizations
        ADD CONSTRAINT unique_reprint_address_organizations UNIQUE (id, addr_id, org_id);

ALTER TABLE ONLY public.wos_reprint_address_suborganizations
        ADD CONSTRAINT unique_reprint_address_suborganizations UNIQUE (id, addr_id, suborg_id);

ALTER TABLE ONLY public.wos_keywords_plus
        ADD CONSTRAINT unique_keywords_plus UNIQUE (id, keyword_id);

ALTER TABLE ONLY public.wos_book_notes
        ADD CONSTRAINT unique_book_notes UNIQUE (id, note_id);

ALTER TABLE ONLY public.wos_book_desc
        ADD CONSTRAINT unique_book_desc UNIQUE (id, desc_id);

ALTER TABLE ONLY public.wos_dynamic_identifiers
        ADD CONSTRAINT unique_dynamic_identifiers UNIQUE (id, dynamic_id);

ALTER TABLE ONLY public.wos_contributors
        ADD CONSTRAINT unique_contributors UNIQUE (id, contrib_id);
