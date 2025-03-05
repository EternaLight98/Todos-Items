CREATE OR REPLACE FUNCTION trigger_set_timestamp()
RETURNS TRIGGER AS $$
BEGIN
NEW.updated_at = NOW();
RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TABLE states (
    id serial primary key,
    state_type varchar(50) not null,
    created_at timestamp not null default now(),
    updated_at timestamp
);

CREATE TRIGGER trigger_update_updated_at_states BEFORE UPDATE ON "states" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


CREATE TABLE files (
    id serial primary key,
    user_id int not null,
    created_at timestamp not null default now(),
    updated_at timestamp,
    key_aws int not null,
    foreign key (user_id) references employees(id)
);

CREATE TRIGGER trigger_update_updated_at_files BEFORE UPDATE ON "files" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


CREATE TABLE contracts (
    id serial primary key,
    contract_type varchar(50) not null,
    created_at timestamp not null default now(),
    updated_at timestamp,
);

CREATE TRIGGER trigger_update_updated_at_contracts BEFORE UPDATE ON "contracts" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();


CREATE TABLE employees (
    id serial primary key,
    photo bytea not null,
    name varchar(50) not null,
    last_name varchar(50) not null,
    id_card int not null,
    incom_at timestamp not null default now(),
    created_at timestamp not null default now(),
    updated_at timestamp,
    state_id int not null,
    contract_id int not null,
    foreign key (state_id) references states(id),
    foreign key (contract_id) references contracts(id)
);

CREATE TRIGGER trigger_update_updated_at_employees BEFORE UPDATE ON "employees" FOR EACH ROW EXECUTE FUNCTION trigger_set_timestamp();
