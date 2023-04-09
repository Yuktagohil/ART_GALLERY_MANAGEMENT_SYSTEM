SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP USER urbandusters CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

Create user urbandusters identified by DmddProject3;

grant connect to urbandusters;

grant resource to urbandusters;

alter user urbandusters quota 100M on data;

grant create view to urbandusters;
