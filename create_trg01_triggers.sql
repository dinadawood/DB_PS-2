Whenever oserror exit 9;
Whenever sqlerror exit sql.sqlcode;

set appinfo on
select 'Begin Executing ' || sys_context('USERENV', 'MODULE') MSG  from dual;

declare
cursor c_table is
select * from user_tables;

v_sql varchar2(2000);

begin
    for r_table in c_table
    loop    
    v_sql := 'CREATE OR REPLACE TRIGGER trg01_' || r_table.table_name || ' BEFORE ';
    v_sql := v_sql || ' INSERT OR UPDATE ON ' || r_table.table_name;
    v_sql := v_sql || ' FOR EACH ROW ';
    v_sql := v_sql || ' BEGIN ';
    v_sql := v_sql || ' IF inserting THEN ';
    v_sql := v_sql || ' :new.' || r_table.table_name || '_crtd_id := user; ';
    v_sql := v_sql || ' :new.' || r_table.table_name || '_crtd_dt := sysdate; ';
    v_sql := v_sql || ' END IF; ';

    v_sql := v_sql || ' :new.' || r_table.table_name || '_updt_id := user; ';
    v_sql := v_sql || ' :new.' || r_table.table_name || '_updt_dt := sysdate; ';
    v_sql := v_sql || ' END; ';

    execute immediate v_sql;
    end loop;

end;
/