CREATE OR REPLACE FUNCTION add_company
(
    _title_company Text,
    _address Text DEFAULT NULL,
    _ogrn Text DEFAULT NULL,
    _inn Text DEFAULT NULL,
    _bank_details Text DEFAULT NULL,
    _telephone Text DEFAULT NULL
)
RETURNS company.id_company%type AS $$
DECLARE
    id_new_company company.id_company%type;
BEGIN
    INSERT INTO
        company(title_company, address, ogrn, inn, bank_details, telephone)
    VALUES
        (_title_company, _address, _ogrn, _inn, _bank_details, _telephone)
    RETURNING
        id_company INTO id_new_company;
    
    RETURN id_new_company;
END;
$$ LANGUAGE plpgsql;



--
-- EXAMPLE
--

-- CREATE OR REPLACE FUNCTION insertFormalParam(_propertyName TEXT, _value TEXT, _parameterDataTypeName TEXT) RETURNS void AS $$
--     BEGIN
--         INSERT INTO formalparameter (propertyId, value, parameterDataTypeId)
--         VALUES (
--             (SELECT propertyId from property where propertyname = _propertyName),
--             _value,
--             (SELECT parameterDataTypeId from parameterdatatype where name = _parameterDataTypeName)
--         );
--     END;
-- $$ LANGUAGE plpgsql;




-- CREATE FUNCTION strainStamp() RETURNS trigger AS $$
--     BEGIN
--         NEW.dateadded := current_timestamp;
--         RETURN NEW;
--     END;
-- $$ LANGUAGE plpgsql;

-- CREATE TRIGGER strainStamp BEFORE INSERT strain
--     FOR EACH ROW EXECUTE PROCEDURE strainStamp();