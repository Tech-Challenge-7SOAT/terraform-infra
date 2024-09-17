
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

SET default_tablespace = '';

SET default_table_access_method = heap;

CREATE TABLE public.tb_customers (
    id bigint NOT NULL,
    cpf character varying(255) NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    email character varying(255) NOT NULL,
    first_name character varying(255) NOT NULL,
    last_name character varying(255) NOT NULL,
    phone_number character varying(255) NOT NULL
);

ALTER TABLE public.tb_customers OWNER TO root;

CREATE SEQUENCE public.tb_customers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tb_customers_id_seq OWNER TO root;

ALTER SEQUENCE public.tb_customers_id_seq OWNED BY public.tb_customers.id;

CREATE TABLE public.tb_order_products (
    id bigint NOT NULL,
    quantity integer NOT NULL,
    order_id bigint NOT NULL,
    product_id bigint NOT NULL
);

ALTER TABLE public.tb_order_products OWNER TO root;

CREATE SEQUENCE public.tb_order_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tb_order_products_id_seq OWNER TO root;

ALTER SEQUENCE public.tb_order_products_id_seq OWNED BY public.tb_order_products.id;

CREATE TABLE public.tb_orders (
    id bigint NOT NULL,
    created_at timestamp(6) without time zone,
    is_payed boolean,
    status character varying(255) NOT NULL,
    time_to_prepare integer DEFAULT 0 NOT NULL,
    total_amount double precision NOT NULL,
    updated_at timestamp(6) without time zone,
    customer_id bigint NOT NULL,
    CONSTRAINT tb_orders_status_check CHECK (((status)::text = ANY ((ARRAY['PRONTO'::character varying, 'EM_PREPARACAO'::character varying, 'RECEBIDO'::character varying, 'FINALIZADO'::character varying, 'PENDENTE'::character varying, 'PAGAMENTO_RECUSADO'::character varying])::text[])))
);

ALTER TABLE public.tb_orders OWNER TO root;

CREATE SEQUENCE public.tb_orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tb_orders_id_seq OWNER TO root;

ALTER SEQUENCE public.tb_orders_id_seq OWNED BY public.tb_orders.id;

CREATE TABLE public.tb_products (
    id bigint NOT NULL,
    category character varying(255) NOT NULL,
    created_at timestamp(6) without time zone,
    deleted_at timestamp(6) without time zone,
    description character varying(255) NOT NULL,
    is_active boolean NOT NULL,
    name character varying(255) NOT NULL,
    price double precision NOT NULL,
    time_to_prepare integer NOT NULL,
    updated_at timestamp(6) without time zone,
    CONSTRAINT tb_products_category_check CHECK (((category)::text = ANY ((ARRAY['LANCHE'::character varying, 'ACOMPANHAMENTO'::character varying, 'BEBIDA'::character varying, 'SOBREMESA'::character varying])::text[])))
);

ALTER TABLE public.tb_products OWNER TO root;

CREATE SEQUENCE public.tb_products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

ALTER SEQUENCE public.tb_products_id_seq OWNER TO root;

ALTER SEQUENCE public.tb_products_id_seq OWNED BY public.tb_products.id;

ALTER TABLE ONLY public.tb_customers ALTER COLUMN id SET DEFAULT nextval('public.tb_customers_id_seq'::regclass);

ALTER TABLE ONLY public.tb_order_products ALTER COLUMN id SET DEFAULT nextval('public.tb_order_products_id_seq'::regclass);

ALTER TABLE ONLY public.tb_orders ALTER COLUMN id SET DEFAULT nextval('public.tb_orders_id_seq'::regclass);

ALTER TABLE ONLY public.tb_products ALTER COLUMN id SET DEFAULT nextval('public.tb_products_id_seq'::regclass);

ALTER TABLE ONLY public.tb_customers
    ADD CONSTRAINT tb_customers_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tb_order_products
    ADD CONSTRAINT tb_order_products_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tb_orders
    ADD CONSTRAINT tb_orders_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tb_products
    ADD CONSTRAINT tb_products_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public.tb_orders
    ADD CONSTRAINT fkh2fkdgk95w34034m63eqqcuye FOREIGN KEY (customer_id) REFERENCES public.tb_customers(id);

ALTER TABLE ONLY public.tb_order_products
    ADD CONSTRAINT fkh2nfmqkpyum2b6mf0wudrjau6 FOREIGN KEY (product_id) REFERENCES public.tb_products(id);

ALTER TABLE ONLY public.tb_order_products
    ADD CONSTRAINT fkpkx8qdfesux5ngobmyocuewx0 FOREIGN KEY (order_id) REFERENCES public.tb_orders(id);