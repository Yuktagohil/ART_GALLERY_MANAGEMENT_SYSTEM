SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE admin CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

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

CREATE ROLE admin IDENTIFIED BY April2023; 
CREATE ROLE artist IDENTIFIED BY April2023; 
CREATE ROLE customer IDENTIFIED BY April2023;

GRANT CREATE SESSION TO admin, artist, customer;

BEGIN
EXECUTE IMMEDIATE 'DROP USER admn CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

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

CREATE USER admn IDENTIFIED BY admin004; 
GRANT CREATE SESSION TO admn;
GRANT admin TO admn;

CREATE USER arst IDENTIFIED BY artist004; 
GRANT CREATE SESSION TO arst;
GRANT artist TO arst;

CREATE USER cust IDENTIFIED BY customer004; 
GRANT CREATE SESSION TO cust;
GRANT customer TO cust;
