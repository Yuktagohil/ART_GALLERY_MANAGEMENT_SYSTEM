SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE artist CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE customer CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

CREATE ROLE artist IDENTIFIED BY artist004; 
CREATE ROLE customer IDENTIFIED BY customer004;

GRANT CREATE SESSION TO artist, customer;

BEGIN
EXECUTE IMMEDIATE 'DROP USER arst CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP USER cust CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

CREATE USER arst IDENTIFIED BY November2022; 
GRANT CREATE SESSION TO arst;
grant artist TO arst;

CREATE USER cust IDENTIFIED BY November2022; 
GRANT CREATE SESSION TO cust;
GRANT customer TO cust;

