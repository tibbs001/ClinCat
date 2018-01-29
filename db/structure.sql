--
-- PostgreSQL database dump
--

-- Dumped from database version 10.1
-- Dumped by pg_dump version 10.1

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
-- Name: analyzed_free_text_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE analyzed_free_text_terms (
    id integer NOT NULL,
    identifier character varying,
    term character varying,
    downcase_term character varying,
    year character varying,
    note character varying
);


--
-- Name: analyzed_free_text_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE analyzed_free_text_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analyzed_free_text_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE analyzed_free_text_terms_id_seq OWNED BY analyzed_free_text_terms.id;


--
-- Name: analyzed_mesh_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE analyzed_mesh_terms (
    id integer NOT NULL,
    qualifier character varying,
    identifier character varying,
    term character varying,
    former_term character varying,
    downcase_term character varying,
    year character varying,
    note character varying
);


--
-- Name: analyzed_mesh_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE analyzed_mesh_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: analyzed_mesh_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE analyzed_mesh_terms_id_seq OWNED BY analyzed_mesh_terms.id;


--
-- Name: categorized_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE categorized_terms (
    id integer NOT NULL,
    identifier character varying,
    term_type character varying,
    category character varying,
    year character varying
);


--
-- Name: categorized_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE categorized_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categorized_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE categorized_terms_id_seq OWNED BY categorized_terms.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: y2010_mesh_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE y2010_mesh_terms (
    id integer NOT NULL,
    qualifier character varying,
    tree_number character varying,
    description character varying,
    mesh_term character varying,
    downcase_mesh_term character varying
);


--
-- Name: y2010_mesh_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE y2010_mesh_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: y2010_mesh_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE y2010_mesh_terms_id_seq OWNED BY y2010_mesh_terms.id;


--
-- Name: y2016_mesh_headings; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE y2016_mesh_headings (
    id integer NOT NULL,
    qualifier character varying,
    heading character varying,
    subcategory character varying
);


--
-- Name: y2016_mesh_headings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE y2016_mesh_headings_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: y2016_mesh_headings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE y2016_mesh_headings_id_seq OWNED BY y2016_mesh_headings.id;


--
-- Name: y2016_mesh_terms; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE y2016_mesh_terms (
    id integer NOT NULL,
    qualifier character varying,
    tree_number character varying,
    description character varying,
    mesh_term character varying,
    downcase_mesh_term character varying
);


--
-- Name: y2016_mesh_terms_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE y2016_mesh_terms_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: y2016_mesh_terms_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE y2016_mesh_terms_id_seq OWNED BY y2016_mesh_terms.id;


--
-- Name: analyzed_free_text_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY analyzed_free_text_terms ALTER COLUMN id SET DEFAULT nextval('analyzed_free_text_terms_id_seq'::regclass);


--
-- Name: analyzed_mesh_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY analyzed_mesh_terms ALTER COLUMN id SET DEFAULT nextval('analyzed_mesh_terms_id_seq'::regclass);


--
-- Name: categorized_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY categorized_terms ALTER COLUMN id SET DEFAULT nextval('categorized_terms_id_seq'::regclass);


--
-- Name: y2010_mesh_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2010_mesh_terms ALTER COLUMN id SET DEFAULT nextval('y2010_mesh_terms_id_seq'::regclass);


--
-- Name: y2016_mesh_headings id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2016_mesh_headings ALTER COLUMN id SET DEFAULT nextval('y2016_mesh_headings_id_seq'::regclass);


--
-- Name: y2016_mesh_terms id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2016_mesh_terms ALTER COLUMN id SET DEFAULT nextval('y2016_mesh_terms_id_seq'::regclass);


--
-- Name: analyzed_free_text_terms analyzed_free_text_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY analyzed_free_text_terms
    ADD CONSTRAINT analyzed_free_text_terms_pkey PRIMARY KEY (id);


--
-- Name: analyzed_mesh_terms analyzed_mesh_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY analyzed_mesh_terms
    ADD CONSTRAINT analyzed_mesh_terms_pkey PRIMARY KEY (id);


--
-- Name: categorized_terms categorized_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY categorized_terms
    ADD CONSTRAINT categorized_terms_pkey PRIMARY KEY (id);


--
-- Name: y2010_mesh_terms y2010_mesh_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2010_mesh_terms
    ADD CONSTRAINT y2010_mesh_terms_pkey PRIMARY KEY (id);


--
-- Name: y2016_mesh_headings y2016_mesh_headings_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2016_mesh_headings
    ADD CONSTRAINT y2016_mesh_headings_pkey PRIMARY KEY (id);


--
-- Name: y2016_mesh_terms y2016_mesh_terms_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY y2016_mesh_terms
    ADD CONSTRAINT y2016_mesh_terms_pkey PRIMARY KEY (id);


--
-- Name: index_analyzed_free_text_terms_on_downcase_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_free_text_terms_on_downcase_term ON analyzed_free_text_terms USING btree (downcase_term);


--
-- Name: index_analyzed_free_text_terms_on_note; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_free_text_terms_on_note ON analyzed_free_text_terms USING btree (note);


--
-- Name: index_analyzed_free_text_terms_on_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_free_text_terms_on_term ON analyzed_free_text_terms USING btree (term);


--
-- Name: index_analyzed_free_text_terms_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_free_text_terms_on_year ON analyzed_free_text_terms USING btree (year);


--
-- Name: index_analyzed_mesh_terms_on_downcase_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_mesh_terms_on_downcase_term ON analyzed_mesh_terms USING btree (downcase_term);


--
-- Name: index_analyzed_mesh_terms_on_note; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_mesh_terms_on_note ON analyzed_mesh_terms USING btree (note);


--
-- Name: index_analyzed_mesh_terms_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_mesh_terms_on_qualifier ON analyzed_mesh_terms USING btree (qualifier);


--
-- Name: index_analyzed_mesh_terms_on_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_mesh_terms_on_term ON analyzed_mesh_terms USING btree (term);


--
-- Name: index_analyzed_mesh_terms_on_year; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_analyzed_mesh_terms_on_year ON analyzed_mesh_terms USING btree (year);


--
-- Name: index_categorized_terms_on_category; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categorized_terms_on_category ON categorized_terms USING btree (category);


--
-- Name: index_categorized_terms_on_identifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categorized_terms_on_identifier ON categorized_terms USING btree (identifier);


--
-- Name: index_categorized_terms_on_term_type; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_categorized_terms_on_term_type ON categorized_terms USING btree (term_type);


--
-- Name: index_y2010_mesh_terms_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2010_mesh_terms_on_description ON y2010_mesh_terms USING btree (description);


--
-- Name: index_y2010_mesh_terms_on_downcase_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2010_mesh_terms_on_downcase_mesh_term ON y2010_mesh_terms USING btree (downcase_mesh_term);


--
-- Name: index_y2010_mesh_terms_on_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2010_mesh_terms_on_mesh_term ON y2010_mesh_terms USING btree (mesh_term);


--
-- Name: index_y2010_mesh_terms_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2010_mesh_terms_on_qualifier ON y2010_mesh_terms USING btree (qualifier);


--
-- Name: index_y2016_mesh_headings_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2016_mesh_headings_on_qualifier ON y2016_mesh_headings USING btree (qualifier);


--
-- Name: index_y2016_mesh_terms_on_description; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2016_mesh_terms_on_description ON y2016_mesh_terms USING btree (description);


--
-- Name: index_y2016_mesh_terms_on_downcase_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2016_mesh_terms_on_downcase_mesh_term ON y2016_mesh_terms USING btree (downcase_mesh_term);


--
-- Name: index_y2016_mesh_terms_on_mesh_term; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2016_mesh_terms_on_mesh_term ON y2016_mesh_terms USING btree (mesh_term);


--
-- Name: index_y2016_mesh_terms_on_qualifier; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_y2016_mesh_terms_on_qualifier ON y2016_mesh_terms USING btree (qualifier);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20170411000122');

INSERT INTO schema_migrations (version) VALUES ('20170719000122');

