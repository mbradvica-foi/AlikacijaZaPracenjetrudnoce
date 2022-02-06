--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1
-- Dumped by pg_dump version 14.1

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: birth(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.birth() RETURNS trigger
    LANGUAGE plpgsql
    AS $$declare 
c_id int;
user_id_d int;
birth_date_d date;
BEGIN
SELECT id FROM conception_info into c_id WHERE birth_date < now();
select user_id from conception_info into user_id_d where id = c_id;
select birth_date from conception_info into birth_date_d where id = c_id;

IF c_id != '0' THEN
INSERT INTO kids(user_id,birth_date) values(user_id_d, birth_date_d);
END IF;
return null;
END;
$$;


ALTER FUNCTION public.birth() OWNER TO postgres;

--
-- Name: check_appointment(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.check_appointment() RETURNS trigger
    LANGUAGE plpgsql
    AS $$declare postoji BOOLEAN;
BEGIN
postoji := EXISTS(
SELECT id FROM appointment WHERE new.datetime = datetime);
IF NOT postoji THEN
RETURN NEW;
ELSE
RAISE EXCEPTION 'Zauzet termin!';
END IF;
END;
$$;


ALTER FUNCTION public.check_appointment() OWNER TO postgres;

--
-- Name: get_birth_date1(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.get_birth_date1() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
c_id int;
conception date;
BEGIN
select max(c.id) from conception_info c into c_id;
if c_id > 0  THEN
	select conception_date from conception_info c into conception where c.id = c_id;
end if;

if conception != '1990-11-11' THEN
	update conception_info c set birth_date = conception + interval '9 months' where c.id = c_id;
end if;
RETURN NULL;
END;
$$;


ALTER FUNCTION public.get_birth_date1() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: appointment; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.appointment (
    id integer NOT NULL,
    doctor_id integer NOT NULL,
    user_id integer NOT NULL,
    datetime character(255) NOT NULL,
    confirmed integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.appointment OWNER TO postgres;

--
-- Name: appointment_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.appointment_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.appointment_id_seq OWNER TO postgres;

--
-- Name: appointment_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.appointment_id_seq OWNED BY public.appointment.id;


--
-- Name: conception_info; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conception_info (
    id integer NOT NULL,
    conception_date date NOT NULL,
    birth_date date DEFAULT '1999-12-12'::date,
    user_id integer NOT NULL
);


ALTER TABLE public.conception_info OWNER TO postgres;

--
-- Name: conceptin_info_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.conceptin_info_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.conceptin_info_id_seq OWNER TO postgres;

--
-- Name: conceptin_info_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.conceptin_info_id_seq OWNED BY public.conception_info.id;


--
-- Name: doctor; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doctor (
    id integer NOT NULL,
    name character(255) NOT NULL,
    surname character(255) NOT NULL,
    begin_time character(255) NOT NULL,
    end_time character(255) NOT NULL,
    day_of_week integer NOT NULL,
    facility_id integer NOT NULL
);


ALTER TABLE public.doctor OWNER TO postgres;

--
-- Name: doctor_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.doctor_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.doctor_id_seq OWNER TO postgres;

--
-- Name: doctor_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.doctor_id_seq OWNED BY public.doctor.id;


--
-- Name: facility; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.facility (
    id integer NOT NULL,
    name character(255) NOT NULL
);


ALTER TABLE public.facility OWNER TO postgres;

--
-- Name: facility_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.facility_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.facility_id_seq OWNER TO postgres;

--
-- Name: facility_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.facility_id_seq OWNED BY public.facility.id;


--
-- Name: kids; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.kids (
    id integer NOT NULL,
    name character(255),
    user_id integer NOT NULL,
    weight character(255),
    height character(255),
    birth_date character(255)
);


ALTER TABLE public.kids OWNER TO postgres;

--
-- Name: kids_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.kids_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.kids_id_seq OWNER TO postgres;

--
-- Name: kids_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.kids_id_seq OWNED BY public.kids.id;


--
-- Name: roles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.roles (
    id integer NOT NULL,
    name character(255) NOT NULL
);


ALTER TABLE public.roles OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.roles_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.roles_id_seq OWNER TO postgres;

--
-- Name: roles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.roles_id_seq OWNED BY public.roles.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id integer NOT NULL,
    name character(45) NOT NULL,
    surname character(45) NOT NULL,
    email character(45) NOT NULL,
    password character(45) NOT NULL,
    role_id integer NOT NULL,
    info integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.users OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.user_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.user_id_seq OWNER TO postgres;

--
-- Name: user_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.user_id_seq OWNED BY public.users.id;


--
-- Name: appointment id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment ALTER COLUMN id SET DEFAULT nextval('public.appointment_id_seq'::regclass);


--
-- Name: conception_info id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conception_info ALTER COLUMN id SET DEFAULT nextval('public.conceptin_info_id_seq'::regclass);


--
-- Name: doctor id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor ALTER COLUMN id SET DEFAULT nextval('public.doctor_id_seq'::regclass);


--
-- Name: facility id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility ALTER COLUMN id SET DEFAULT nextval('public.facility_id_seq'::regclass);


--
-- Name: kids id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kids ALTER COLUMN id SET DEFAULT nextval('public.kids_id_seq'::regclass);


--
-- Name: roles id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles ALTER COLUMN id SET DEFAULT nextval('public.roles_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.user_id_seq'::regclass);


--
-- Data for Name: appointment; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.appointment (id, doctor_id, user_id, datetime, confirmed) FROM stdin;
3	1	1	2021-12-31T18:10                                                                                                                                                                                                                                               	0
4	1	1	2021-12-31T18:23                                                                                                                                                                                                                                               	0
5	4	1	2021-12-26T10:26                                                                                                                                                                                                                                               	0
\.


--
-- Data for Name: conception_info; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conception_info (id, conception_date, birth_date, user_id) FROM stdin;
23	2021-10-03	2021-12-23	1
24	2022-01-31	2022-10-31	3
\.


--
-- Data for Name: doctor; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doctor (id, name, surname, begin_time, end_time, day_of_week, facility_id) FROM stdin;
1	Ivanko                                                                                                                                                                                                                                                         	Ivanković                                                                                                                                                                                                                                                      	08:00                                                                                                                                                                                                                                                          	16:00                                                                                                                                                                                                                                                          	0	1
2	Marko                                                                                                                                                                                                                                                          	Markić                                                                                                                                                                                                                                                         	16:00                                                                                                                                                                                                                                                          	22:00                                                                                                                                                                                                                                                          	0	2
3	Pero                                                                                                                                                                                                                                                           	Perić                                                                                                                                                                                                                                                          	16:00                                                                                                                                                                                                                                                          	22:00                                                                                                                                                                                                                                                          	0	1
4	Ana                                                                                                                                                                                                                                                            	Anić                                                                                                                                                                                                                                                           	08:00                                                                                                                                                                                                                                                          	16:00                                                                                                                                                                                                                                                          	0	2
\.


--
-- Data for Name: facility; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.facility (id, name) FROM stdin;
1	Poliklinika Adarta                                                                                                                                                                                                                                             
2	Poliklinika Sveti Nikola                                                                                                                                                                                                                                       
\.


--
-- Data for Name: kids; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.kids (id, name, user_id, weight, height, birth_date) FROM stdin;
1	Robert                                                                                                                                                                                                                                                         	1	3.30 kg                                                                                                                                                                                                                                                        	70 cm                                                                                                                                                                                                                                                          	2021-12-23                                                                                                                                                                                                                                                     
\.


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.roles (id, name) FROM stdin;
1	Admin                                                                                                                                                                                                                                                          
2	Korisnik                                                                                                                                                                                                                                                       
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.users (id, name, surname, email, password, role_id, info) FROM stdin;
2	Iva                                          	Kordić                                       	ivako@gmail.com                              	mirelamiki                                   	2	0
1	Mirela                                       	Bradvica                                     	mbradvica@gmail.com                          	mirelamiki                                   	1	1
3	Vinko                                        	Cvitković                                    	123@gmail.com                                	321                                          	2	1
\.


--
-- Name: appointment_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.appointment_id_seq', 10, true);


--
-- Name: conceptin_info_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.conceptin_info_id_seq', 24, true);


--
-- Name: doctor_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.doctor_id_seq', 4, true);


--
-- Name: facility_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.facility_id_seq', 2, true);


--
-- Name: kids_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.kids_id_seq', 3, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.roles_id_seq', 2, true);


--
-- Name: user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.user_id_seq', 3, true);


--
-- Name: appointment appointment_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.appointment
    ADD CONSTRAINT appointment_pkey PRIMARY KEY (id);


--
-- Name: conception_info conceptin_info_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conception_info
    ADD CONSTRAINT conceptin_info_pkey PRIMARY KEY (id);


--
-- Name: doctor doctor_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doctor
    ADD CONSTRAINT doctor_pkey PRIMARY KEY (id);


--
-- Name: facility facility_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.facility
    ADD CONSTRAINT facility_pkey PRIMARY KEY (id);


--
-- Name: kids kids_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.kids
    ADD CONSTRAINT kids_pkey PRIMARY KEY (id);


--
-- Name: roles roles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.roles
    ADD CONSTRAINT roles_pkey PRIMARY KEY (id);


--
-- Name: users user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);


--
-- Name: appointment birth_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER birth_trigger BEFORE INSERT ON public.appointment FOR EACH ROW EXECUTE FUNCTION public.birth();


--
-- Name: appointment exist; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER exist BEFORE INSERT ON public.appointment FOR EACH ROW EXECUTE FUNCTION public.check_appointment();


--
-- Name: conception_info update_birth_date1; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_birth_date1 AFTER INSERT ON public.conception_info FOR EACH ROW EXECUTE FUNCTION public.get_birth_date1();


--
-- PostgreSQL database dump complete
--

