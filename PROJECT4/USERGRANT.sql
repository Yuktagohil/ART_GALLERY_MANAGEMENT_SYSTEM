SET SERVEROUTPUT ON;

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE gallery_admin';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE artist';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE customer';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP USER g_admin CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP USER g_artist CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP USER g_customer CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

CREATE ROLE gallery_admin IDENTIFIED BY April2023;
CREATE ROLE artist IDENTIFIED BY April2023; 
CREATE ROLE customer IDENTIFIED BY April2023;

GRANT CREATE SESSION TO gallery_admin, artist, customer;

GRANT CREATE VIEW TO gallery_admin, artist, customer;

CREATE USER g_admin IDENTIFIED BY Adminartgallery004; 
CREATE USER g_artist IDENTIFIED BY Artistartgallery004; 
CREATE USER g_customer IDENTIFIED BY Customerartgallery004; 

GRANT CREATE SESSION TO g_admin;
GRANT CREATE SESSION TO g_artist;
GRANT CREATE SESSION TO g_customer;

GRANT gallery_admin TO g_admin;
GRANT artist TO g_artist;
GRANT customer TO g_customer;

grant connect to g_admin;
grant resource to g_admin;
alter user g_admin quota 500M on data;

grant execute on ADMIN_PACKAGE to gallery_admin;
grant execute on ARTIST_PACKAGES to artist;
grant execute on CUSTOMER_PACKAGES to customer;
