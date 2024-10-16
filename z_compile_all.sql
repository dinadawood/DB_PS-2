BEGIN
    dbms_utility.compile_schema(schema => user, compile_all => true, reuse_settings => true);
END;
/