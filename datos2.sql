CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
  NEW.updated_at = NOW();
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TABLE public.contracts
(
    id integer NOT NULL,
    contract_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT contracts_pkey PRIMARY KEY (id)
);

CREATE TRIGGER trigger_update_updated_at_public.contracts BEFORE UPDATE ON "public.contracts" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


CREATE TABLE public.employees
(
    id integer NOT NULL,
    photo bytea NOT NULL,
    name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    last_name character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_card integer NOT NULL,
    incom_at timestamp with time zone NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone,
    state_id integer NOT NULL,
    contract_id integer NOT NULL,
    CONSTRAINT employees_pkey PRIMARY KEY (id)
);

CREATE TRIGGER trigger_update_updated_at_public.employees BEFORE UPDATE ON "public.employees" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


CREATE TABLE public.files
(
    id integer NOT NULL,
    user_id integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp without time zone,
    key_aws integer NOT NULL,
    CONSTRAINT files_pkey PRIMARY KEY (id)
);

CREATE TRIGGER trigger_update_updated_at_public.files BEFORE UPDATE ON "public.files" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();

CREATE TABLE public.states
(
    id integer NOT NULL DEFAULT nextval('state_id_seq'::regclass),
    state_type character varying(50) COLLATE pg_catalog."default" NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone,
    CONSTRAINT state_pkey PRIMARY KEY (id)
);

CREATE TRIGGER trigger_update_updated_at_public.states BEFORE UPDATE ON "public.states" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


ALTER TABLE public.employees
    ADD CONSTRAINT contract_fk FOREIGN KEY (contract_id)
    REFERENCES public.contracts (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE public.employees
    ADD CONSTRAINT state_fk FOREIGN KEY (state_id)
    REFERENCES public.states (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;


ALTER TABLE public.files
    ADD CONSTRAINT files_user_id_fkey FOREIGN KEY (user_id)
    REFERENCES public.employees (id) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION
    NOT VALID;

END;