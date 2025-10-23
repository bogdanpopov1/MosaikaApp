--
-- PostgreSQL database dump
--

\restrict tewrURuInPTeiTY7VRFpx3W5hCABOJjGMXKkqYNulDBIeRrj4BmriazSgC79Rs5

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-10-23 14:40:04

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE IF EXISTS mosaika_db;
--
-- TOC entry 4979 (class 1262 OID 41667)
-- Name: mosaika_db; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE mosaika_db WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'Russian_Russia.1251';


ALTER DATABASE mosaika_db OWNER TO postgres;

\unrestrict tewrURuInPTeiTY7VRFpx3W5hCABOJjGMXKkqYNulDBIeRrj4BmriazSgC79Rs5
\connect mosaika_db
\restrict tewrURuInPTeiTY7VRFpx3W5hCABOJjGMXKkqYNulDBIeRrj4BmriazSgC79Rs5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 226 (class 1259 OID 41857)
-- Name: material; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.material (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    materialtypeid integer,
    unitid integer,
    quantityinstock integer NOT NULL,
    minquantity integer NOT NULL,
    quantityinpackage integer NOT NULL,
    unitprice numeric(10,2) NOT NULL
);


ALTER TABLE public.material OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 41856)
-- Name: material_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.material_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.material_id_seq OWNER TO postgres;

--
-- TOC entry 4980 (class 0 OID 0)
-- Dependencies: 225
-- Name: material_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.material_id_seq OWNED BY public.material.id;


--
-- TOC entry 231 (class 1259 OID 41907)
-- Name: materialsupplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materialsupplier (
    materialid integer NOT NULL,
    supplierid integer NOT NULL
);


ALTER TABLE public.materialsupplier OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 41830)
-- Name: materialtype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.materialtype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    losspercentage numeric(5,2) NOT NULL
);


ALTER TABLE public.materialtype OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 41829)
-- Name: materialtype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.materialtype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.materialtype_id_seq OWNER TO postgres;

--
-- TOC entry 4981 (class 0 OID 0)
-- Dependencies: 219
-- Name: materialtype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.materialtype_id_seq OWNED BY public.materialtype.id;


--
-- TOC entry 230 (class 1259 OID 41892)
-- Name: product; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.product (
    id integer NOT NULL,
    article character varying(50) NOT NULL,
    name character varying(255) NOT NULL,
    producttypeid integer,
    mincostforpartner numeric(10,2) NOT NULL,
    rollwidth numeric(10,2)
);


ALTER TABLE public.product OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 41891)
-- Name: product_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.product_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.product_id_seq OWNER TO postgres;

--
-- TOC entry 4982 (class 0 OID 0)
-- Dependencies: 229
-- Name: product_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.product_id_seq OWNED BY public.product.id;


--
-- TOC entry 232 (class 1259 OID 41922)
-- Name: productmaterial; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.productmaterial (
    productid integer NOT NULL,
    materialid integer NOT NULL,
    quantity integer NOT NULL
);


ALTER TABLE public.productmaterial OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 41848)
-- Name: producttype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.producttype (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    coefficient numeric(10,2) NOT NULL
);


ALTER TABLE public.producttype OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 41847)
-- Name: producttype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.producttype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.producttype_id_seq OWNER TO postgres;

--
-- TOC entry 4983 (class 0 OID 0)
-- Dependencies: 223
-- Name: producttype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.producttype_id_seq OWNED BY public.producttype.id;


--
-- TOC entry 228 (class 1259 OID 41876)
-- Name: supplier; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.supplier (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    suppliertypeid integer,
    inn character varying(12) NOT NULL,
    rating integer NOT NULL,
    startdate date NOT NULL
);


ALTER TABLE public.supplier OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 41875)
-- Name: supplier_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.supplier_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.supplier_id_seq OWNER TO postgres;

--
-- TOC entry 4984 (class 0 OID 0)
-- Dependencies: 227
-- Name: supplier_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.supplier_id_seq OWNED BY public.supplier.id;


--
-- TOC entry 222 (class 1259 OID 41839)
-- Name: suppliertype; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.suppliertype (
    id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.suppliertype OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 41838)
-- Name: suppliertype_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.suppliertype_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.suppliertype_id_seq OWNER TO postgres;

--
-- TOC entry 4985 (class 0 OID 0)
-- Dependencies: 221
-- Name: suppliertype_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.suppliertype_id_seq OWNED BY public.suppliertype.id;


--
-- TOC entry 218 (class 1259 OID 41821)
-- Name: unit; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.unit (
    id integer NOT NULL,
    name character varying(10) NOT NULL
);


ALTER TABLE public.unit OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 41820)
-- Name: unit_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.unit_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.unit_id_seq OWNER TO postgres;

--
-- TOC entry 4986 (class 0 OID 0)
-- Dependencies: 217
-- Name: unit_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.unit_id_seq OWNED BY public.unit.id;


--
-- TOC entry 4784 (class 2604 OID 41860)
-- Name: material id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material ALTER COLUMN id SET DEFAULT nextval('public.material_id_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 41833)
-- Name: materialtype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialtype ALTER COLUMN id SET DEFAULT nextval('public.materialtype_id_seq'::regclass);


--
-- TOC entry 4786 (class 2604 OID 41895)
-- Name: product id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product ALTER COLUMN id SET DEFAULT nextval('public.product_id_seq'::regclass);


--
-- TOC entry 4783 (class 2604 OID 41851)
-- Name: producttype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producttype ALTER COLUMN id SET DEFAULT nextval('public.producttype_id_seq'::regclass);


--
-- TOC entry 4785 (class 2604 OID 41879)
-- Name: supplier id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier ALTER COLUMN id SET DEFAULT nextval('public.supplier_id_seq'::regclass);


--
-- TOC entry 4782 (class 2604 OID 41842)
-- Name: suppliertype id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliertype ALTER COLUMN id SET DEFAULT nextval('public.suppliertype_id_seq'::regclass);


--
-- TOC entry 4780 (class 2604 OID 41824)
-- Name: unit id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit ALTER COLUMN id SET DEFAULT nextval('public.unit_id_seq'::regclass);


--
-- TOC entry 4804 (class 2606 OID 41864)
-- Name: material material_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_name_key UNIQUE (name);


--
-- TOC entry 4806 (class 2606 OID 41862)
-- Name: material material_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 41911)
-- Name: materialsupplier materialsupplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialsupplier
    ADD CONSTRAINT materialsupplier_pkey PRIMARY KEY (materialid, supplierid);


--
-- TOC entry 4792 (class 2606 OID 41837)
-- Name: materialtype materialtype_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialtype
    ADD CONSTRAINT materialtype_name_key UNIQUE (name);


--
-- TOC entry 4794 (class 2606 OID 41835)
-- Name: materialtype materialtype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialtype
    ADD CONSTRAINT materialtype_pkey PRIMARY KEY (id);


--
-- TOC entry 4814 (class 2606 OID 41901)
-- Name: product product_article_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_article_key UNIQUE (article);


--
-- TOC entry 4816 (class 2606 OID 41899)
-- Name: product product_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_pkey PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 41926)
-- Name: productmaterial productmaterial_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productmaterial
    ADD CONSTRAINT productmaterial_pkey PRIMARY KEY (productid, materialid);


--
-- TOC entry 4800 (class 2606 OID 41855)
-- Name: producttype producttype_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producttype
    ADD CONSTRAINT producttype_name_key UNIQUE (name);


--
-- TOC entry 4802 (class 2606 OID 41853)
-- Name: producttype producttype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.producttype
    ADD CONSTRAINT producttype_pkey PRIMARY KEY (id);


--
-- TOC entry 4808 (class 2606 OID 41885)
-- Name: supplier supplier_inn_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_inn_key UNIQUE (inn);


--
-- TOC entry 4810 (class 2606 OID 41883)
-- Name: supplier supplier_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_name_key UNIQUE (name);


--
-- TOC entry 4812 (class 2606 OID 41881)
-- Name: supplier supplier_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_pkey PRIMARY KEY (id);


--
-- TOC entry 4796 (class 2606 OID 41846)
-- Name: suppliertype suppliertype_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliertype
    ADD CONSTRAINT suppliertype_name_key UNIQUE (name);


--
-- TOC entry 4798 (class 2606 OID 41844)
-- Name: suppliertype suppliertype_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.suppliertype
    ADD CONSTRAINT suppliertype_pkey PRIMARY KEY (id);


--
-- TOC entry 4788 (class 2606 OID 41828)
-- Name: unit unit_name_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_name_key UNIQUE (name);


--
-- TOC entry 4790 (class 2606 OID 41826)
-- Name: unit unit_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.unit
    ADD CONSTRAINT unit_pkey PRIMARY KEY (id);


--
-- TOC entry 4821 (class 2606 OID 41865)
-- Name: material material_materialtypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_materialtypeid_fkey FOREIGN KEY (materialtypeid) REFERENCES public.materialtype(id) ON DELETE SET NULL;


--
-- TOC entry 4822 (class 2606 OID 41870)
-- Name: material material_unitid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.material
    ADD CONSTRAINT material_unitid_fkey FOREIGN KEY (unitid) REFERENCES public.unit(id) ON DELETE RESTRICT;


--
-- TOC entry 4825 (class 2606 OID 41912)
-- Name: materialsupplier materialsupplier_materialid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialsupplier
    ADD CONSTRAINT materialsupplier_materialid_fkey FOREIGN KEY (materialid) REFERENCES public.material(id) ON DELETE CASCADE;


--
-- TOC entry 4826 (class 2606 OID 41917)
-- Name: materialsupplier materialsupplier_supplierid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.materialsupplier
    ADD CONSTRAINT materialsupplier_supplierid_fkey FOREIGN KEY (supplierid) REFERENCES public.supplier(id) ON DELETE CASCADE;


--
-- TOC entry 4824 (class 2606 OID 41902)
-- Name: product product_producttypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.product
    ADD CONSTRAINT product_producttypeid_fkey FOREIGN KEY (producttypeid) REFERENCES public.producttype(id) ON DELETE SET NULL;


--
-- TOC entry 4827 (class 2606 OID 41932)
-- Name: productmaterial productmaterial_materialid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productmaterial
    ADD CONSTRAINT productmaterial_materialid_fkey FOREIGN KEY (materialid) REFERENCES public.material(id) ON DELETE CASCADE;


--
-- TOC entry 4828 (class 2606 OID 41927)
-- Name: productmaterial productmaterial_productid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.productmaterial
    ADD CONSTRAINT productmaterial_productid_fkey FOREIGN KEY (productid) REFERENCES public.product(id) ON DELETE CASCADE;


--
-- TOC entry 4823 (class 2606 OID 41886)
-- Name: supplier supplier_suppliertypeid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.supplier
    ADD CONSTRAINT supplier_suppliertypeid_fkey FOREIGN KEY (suppliertypeid) REFERENCES public.suppliertype(id) ON DELETE SET NULL;


-- Completed on 2025-10-23 14:40:04

--
-- PostgreSQL database dump complete
--

\unrestrict tewrURuInPTeiTY7VRFpx3W5hCABOJjGMXKkqYNulDBIeRrj4BmriazSgC79Rs5

