--
-- PostgreSQL database dump
--

-- Dumped from database version 9.6.2
-- Dumped by pg_dump version 9.6.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: annotation_labels; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE annotation_labels (
    id integer NOT NULL,
    label character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: annotation_labels_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE annotation_labels_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annotation_labels_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE annotation_labels_id_seq OWNED BY annotation_labels.id;


--
-- Name: annotations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE annotations (
    id integer NOT NULL,
    nct_id character varying,
    label character varying,
    description text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: annotations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE annotations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: annotations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE annotations_id_seq OWNED BY annotations.id;


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categories (
    id integer NOT NULL,
    name character varying
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categories_id_seq OWNED BY categories.id;


--
-- Name: mesh_headings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mesh_headings (
    id integer NOT NULL,
    qualifier character varying,
    heading character varying,
    subcategory character varying
);


--
-- Name: mesh_headings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mesh_headings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mesh_headings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mesh_headings_id_seq OWNED BY mesh_headings.id;


--
-- Name: mesh_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE mesh_terms (
    id integer NOT NULL,
    qualifier character varying,
    tree_number character varying,
    description character varying,
    mesh_term character varying,
    downcase_mesh_term character varying
);


--
-- Name: mesh_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mesh_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mesh_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mesh_terms_id_seq OWNED BY mesh_terms.id;


--
-- Name: old_categorized_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE old_categorized_terms (
    id integer NOT NULL,
    old_id integer,
    tree_number character varying,
    clinical_category character varying,
    term_type character varying
);


--
-- Name: old_categorized_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE old_categorized_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: old_categorized_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE old_categorized_terms_id_seq OWNED BY old_categorized_terms.id;


--
-- Name: old_free_text_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE old_free_text_terms (
    id integer NOT NULL,
    old_id integer,
    free_text_term character varying,
    downcase_free_text_term character varying
);


--
-- Name: old_free_text_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE old_free_text_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: old_free_text_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE old_free_text_terms_id_seq OWNED BY old_free_text_terms.id;


--
-- Name: old_mesh_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE old_mesh_terms (
    id integer NOT NULL,
    qualifier character varying,
    tree_number character varying,
    description character varying,
    mesh_term character varying,
    downcase_mesh_term character varying
);


--
-- Name: old_mesh_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE old_mesh_terms_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: old_mesh_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE old_mesh_terms_id_seq OWNED BY old_mesh_terms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: tags; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE tags (
    id integer NOT NULL,
    nct_id character varying,
    value character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: tags_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tags_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tags_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tags_id_seq OWNED BY tags.id;


--
-- Name: user_session_studies; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE user_session_studies (
    id integer NOT NULL,
    nct_id character varying,
    serialized_study text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_id integer
);


--
-- Name: user_session_studies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE user_session_studies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: user_session_studies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE user_session_studies_id_seq OWNED BY user_session_studies.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip character varying,
    last_sign_in_ip character varying,
    first_name character varying,
    last_name character varying,
    default_query_string character varying
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: annotation_labels id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY annotation_labels ALTER COLUMN id SET DEFAULT nextval('annotation_labels_id_seq'::regclass);


--
-- Name: annotations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY annotations ALTER COLUMN id SET DEFAULT nextval('annotations_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories ALTER COLUMN id SET DEFAULT nextval('categories_id_seq'::regclass);


--
-- Name: mesh_headings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mesh_headings ALTER COLUMN id SET DEFAULT nextval('mesh_headings_id_seq'::regclass);


--
-- Name: mesh_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mesh_terms ALTER COLUMN id SET DEFAULT nextval('mesh_terms_id_seq'::regclass);


--
-- Name: old_categorized_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_categorized_terms ALTER COLUMN id SET DEFAULT nextval('old_categorized_terms_id_seq'::regclass);


--
-- Name: old_free_text_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_free_text_terms ALTER COLUMN id SET DEFAULT nextval('old_free_text_terms_id_seq'::regclass);


--
-- Name: old_mesh_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_mesh_terms ALTER COLUMN id SET DEFAULT nextval('old_mesh_terms_id_seq'::regclass);


--
-- Name: tags id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags ALTER COLUMN id SET DEFAULT nextval('tags_id_seq'::regclass);


--
-- Name: user_session_studies id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session_studies ALTER COLUMN id SET DEFAULT nextval('user_session_studies_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: annotation_labels annotation_labels_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY annotation_labels
    ADD CONSTRAINT annotation_labels_pkey PRIMARY KEY (id);


--
-- Name: annotations annotations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY annotations
    ADD CONSTRAINT annotations_pkey PRIMARY KEY (id);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: mesh_headings mesh_headings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mesh_headings
    ADD CONSTRAINT mesh_headings_pkey PRIMARY KEY (id);


--
-- Name: mesh_terms mesh_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY mesh_terms
    ADD CONSTRAINT mesh_terms_pkey PRIMARY KEY (id);


--
-- Name: old_categorized_terms old_categorized_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_categorized_terms
    ADD CONSTRAINT old_categorized_terms_pkey PRIMARY KEY (id);


--
-- Name: old_free_text_terms old_free_text_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_free_text_terms
    ADD CONSTRAINT old_free_text_terms_pkey PRIMARY KEY (id);


--
-- Name: old_mesh_terms old_mesh_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY old_mesh_terms
    ADD CONSTRAINT old_mesh_terms_pkey PRIMARY KEY (id);


--
-- Name: tags tags_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY tags
    ADD CONSTRAINT tags_pkey PRIMARY KEY (id);


--
-- Name: user_session_studies user_session_studies_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY user_session_studies
    ADD CONSTRAINT user_session_studies_pkey PRIMARY KEY (id);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_mesh_headings_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mesh_headings_on_qualifier ON mesh_headings USING btree (qualifier);


--
-- Name: index_mesh_terms_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mesh_terms_on_description ON mesh_terms USING btree (description);


--
-- Name: index_mesh_terms_on_downcase_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mesh_terms_on_downcase_mesh_term ON mesh_terms USING btree (downcase_mesh_term);


--
-- Name: index_mesh_terms_on_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mesh_terms_on_mesh_term ON mesh_terms USING btree (mesh_term);


--
-- Name: index_mesh_terms_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_mesh_terms_on_qualifier ON mesh_terms USING btree (qualifier);


--
-- Name: index_old_categorized_terms_on_clinical_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_categorized_terms_on_clinical_category ON old_categorized_terms USING btree (clinical_category);


--
-- Name: index_old_categorized_terms_on_term_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_categorized_terms_on_term_type ON old_categorized_terms USING btree (term_type);


--
-- Name: index_old_categorized_terms_on_tree_number; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_categorized_terms_on_tree_number ON old_categorized_terms USING btree (tree_number);


--
-- Name: index_old_free_text_terms_on_downcase_free_text_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_free_text_terms_on_downcase_free_text_term ON old_free_text_terms USING btree (downcase_free_text_term);


--
-- Name: index_old_free_text_terms_on_free_text_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_free_text_terms_on_free_text_term ON old_free_text_terms USING btree (free_text_term);


--
-- Name: index_old_mesh_terms_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_mesh_terms_on_description ON old_mesh_terms USING btree (description);


--
-- Name: index_old_mesh_terms_on_downcase_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_mesh_terms_on_downcase_mesh_term ON old_mesh_terms USING btree (downcase_mesh_term);


--
-- Name: index_old_mesh_terms_on_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_mesh_terms_on_mesh_term ON old_mesh_terms USING btree (mesh_term);


--
-- Name: index_old_mesh_terms_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_old_mesh_terms_on_qualifier ON old_mesh_terms USING btree (qualifier);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: user_session_studies_nct_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_session_studies_nct_id ON user_session_studies USING btree (nct_id);


--
-- Name: user_session_studies_user_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX user_session_studies_user_id ON user_session_studies USING btree (user_id);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160214191640');

INSERT INTO schema_migrations (version) VALUES ('20161025140835');

INSERT INTO schema_migrations (version) VALUES ('20161025205437');

INSERT INTO schema_migrations (version) VALUES ('20161121022548');

INSERT INTO schema_migrations (version) VALUES ('20170318222715');

INSERT INTO schema_migrations (version) VALUES ('20170411000122');

INSERT INTO schema_migrations (version) VALUES ('20170719000122');

