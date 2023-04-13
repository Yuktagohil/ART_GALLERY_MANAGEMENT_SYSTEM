BEGIN
EXECUTE IMMEDIATE 'DROP USER art_gallery_admin CASCADE';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE GALLERY_ADMIN';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 
BEGIN
EXECUTE IMMEDIATE 'DROP ROLE ARTIST';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

BEGIN
EXECUTE IMMEDIATE 'DROP ROLE CUSTOMER';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/ 

CREATE USER art_gallery_admin IDENTIFIED BY Adminartgallery004 QUOTA 200M ON DATA;

GRANT CONNECT TO art_gallery_admin WITH ADMIN OPTION;
GRANT RESOURCE TO art_gallery_admin WITH ADMIN OPTION;
GRANT CREATE VIEW TO art_gallery_admin WITH ADMIN OPTION;
GRANT CREATE PROCEDURE TO art_gallery_admin WITH ADMIN OPTION;
GRANT CREATE USER TO art_gallery_admin;
GRANT DROP USER TO art_gallery_admin;
GRANT CREATE SEQUENCE TO art_gallery_admin;
GRANT CREATE TABLE TO art_gallery_admin;
GRANT CREATE USER TO art_gallery_admin;


CREATE ROLE GALLERY_ADMIN IDENTIFIED BY April2023;
GRANT CREATE SESSION TO GALLERY_ADMIN;
GRANT CREATE VIEW TO GALLERY_ADMIN;
grant GALLERY_ADMIN to ART_GALLERY_ADMIN;


CREATE  ROLE ARTIST IDENTIFIED BY April2023; 
CREATE ROLE CUSTOMER IDENTIFIED BY April2023;
GRANT CREATE SESSION TO ARTIST, CUSTOMER;
GRANT CREATE VIEW TO ARTIST, CUSTOMER;
grant ARTIST to ART_GALLERY_ARTIST;
grant CUSTOMER to ART_GALLERY_CUSTOMER;
GRANT CREATE ROLE TO art_gallery_admin;
GRANT CREATE SESSION TO art_gallery_admin;
GRANT CREATE VIEW TO art_gallery_admin;
