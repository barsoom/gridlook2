--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.4
-- Dumped by pg_dump version 9.5.4

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: events; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE events (
    id integer NOT NULL,
    email character varying(255),
    name character varying(255),
    category text,
    data text,
    happened_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    unique_args text,
    mailer_action character varying(255)
)
WITH (autovacuum_enabled='true', autovacuum_vacuum_scale_factor='0.01', autovacuum_analyze_scale_factor='0.005');


--
-- Name: events_data; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE events_data (
    id integer NOT NULL,
    total_events integer
);


--
-- Name: events_data_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_data_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_data_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_data_id_seq OWNED BY events_data.id;


--
-- Name: events_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE events_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: events_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE events_id_seq OWNED BY events.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events ALTER COLUMN id SET DEFAULT nextval('events_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY events_data ALTER COLUMN id SET DEFAULT nextval('events_data_id_seq'::regclass);


--
-- Name: events_data_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events_data
    ADD CONSTRAINT events_data_pkey PRIMARY KEY (id);


--
-- Name: events_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY events
    ADD CONSTRAINT events_pkey PRIMARY KEY (id);


--
-- Name: index_events_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_email ON events USING btree (email);


--
-- Name: index_events_on_happened_at_and_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_happened_at_and_id ON events USING btree (happened_at, id);


--
-- Name: index_events_on_mailer_action_and_happened_at_and_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_mailer_action_and_happened_at_and_id ON events USING btree (mailer_action, happened_at, id);


--
-- Name: index_events_on_name; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_events_on_name ON events USING btree (name);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

INSERT INTO "schema_migrations" (version) VALUES (20130317175842), (20130320083748), (20130320091131), (20130320094652), (20130423112658), (20130624173016), (20130624183059), (20130625110032), (20130629203432), (20140314222224), (20140603114446), (20140710091549), (20140822081758), (20140825062349);

