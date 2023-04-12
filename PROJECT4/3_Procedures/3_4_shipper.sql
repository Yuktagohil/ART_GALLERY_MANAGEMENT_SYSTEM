create or replace PROCEDURE INSERT_SHIPPER(COMPANYNAME in VARCHAR ,CONTACTNUMBER in VARCHAR ,EMAILID in VARCHAR) AS
BEGIN
dbms_output.put_line('----------------------------------------------------------'); 
insert into SHIPPER( 
    SHIPPERID,  
    COMPANYNAME, 
    CONTACTNUMBER, 
    EMAILID
)  
    values  
    ( 
    shipper_seq.NEXTVAL,  
    COMPANYNAME, 
    CONTACTNUMBER, 
    EMAILID
); 

dbms_output.put_line('Row inserted into SHIPPER Table'); 
dbms_output.put_line('----------------------------------------------------------'); 
commit; 
exception 
when dup_val_on_index then 
dbms_output.put_line('Duplicate Value Found in SHIPPER! Insert Different Value'); 
when others then 
dbms_output.put_line('Error while inserting data into SHIPPER Table'); 
rollback; 
dbms_output.put_line('The error encountered is: '); 
dbms_output.put_line(dbms_utility.format_error_stack); 
dbms_output.put_line('----------------------------------------------------------'); 
END INSERT_SHIPPER; 
/
create or replace PROCEDURE UPDATE_SHIPPER(SHIPPERID in INTEGER, COMPANYNAME in VARCHAR ,CONTACTNUMBER in VARCHAR ,EMAILID in VARCHAR) AS
BEGIN
dbms_output.put_line('----------------------------------------------------------'); 
update SHIPPER
    set  
    COMPANYNAME = UPDATE_SHIPPER.COMPANYNAME, 
    CONTACTNUMBER = UPDATE_SHIPPER.CONTACTNUMBER, 
    EMAILID = UPDATE_SHIPPER.EMAILID
 where SHIPPERID = UPDATE_SHIPPER.SHIPPERID; 

dbms_output.put_line('Row inserted into SHIPPER Table'); 
dbms_output.put_line('----------------------------------------------------------'); 
commit; 
exception 
when dup_val_on_index then 
dbms_output.put_line('Duplicate Value Found in SHIPPER! Insert Different Value'); 
when others then 
dbms_output.put_line('Error while inserting data into SHIPPER Table'); 
rollback; 
dbms_output.put_line('The error encountered is: '); 
dbms_output.put_line(dbms_utility.format_error_stack); 
dbms_output.put_line('----------------------------------------------------------'); 
END UPDATE_SHIPPER; 
/
CREATE OR REPLACE PROCEDURE DELETE_SHIPPER (
    SHIPPERID IN INTEGER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    DELETE FROM SHIPPER WHERE SHIPPERID = DELETE_SHIPPER.SHIPPERID;
    DBMS_OUTPUT.PUT_LINE('Row deleted from ARTWORK Table');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error while deleting data from ARTWORK Table');
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('The error encountered is: ');
        DBMS_OUTPUT.PUT_LINE(DBMS_UTILITY.FORMAT_ERROR_STACK);
        DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
END DELETE_SHIPPER;
/

CREATE OR REPLACE PROCEDURE VIEW_SHIPPERS
IS
BEGIN
  FOR rec IN (SELECT * FROM SHIPPER)
  LOOP
    DBMS_OUTPUT.PUT_LINE('SHIPPER ID: ' || rec.SHIPPERID || ', COMPANY NAME: ' || rec.COMPANYNAME || ', CONTACT NUMBER: ' || rec.CONTACTNUMBER || ', EMAIL ID: ' || rec.EMAILID);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Shippers retrieved successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


