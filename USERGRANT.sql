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


BEGIN
EXECUTE IMMEDIATE 'DROP USER DBAdmin CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

Create user DBAdmin identified by DmddProject4;

grant connect to DBAdmin;

grant resource to DBAdmin;

alter user DBAdmin quota 500M on data;

grant create view to DBAdmin;