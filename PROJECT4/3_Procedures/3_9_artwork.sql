create or replace PROCEDURE INSERT_ARTWORK(UserID in INTEGER ,ArtCategoryID in INTEGER ,ExhibitionID in INTEGER , OrderItemsID  in INTEGER ,NAME in VARCHAR ,Description in VARCHAR, Amount in NUMBER ,Status in VARCHAR ,ArtworkImage  in BLOB) AS 
BEGIN 
dbms_output.put_line('----------------------------------------------------------'); 
insert into artwork( 
    ArtworkID,  
    UserID, 
    ArtCategoryID, 
    ExhibitionID,  
    OrderItemsID, 
    Name, 
    Description,  
    Amount, 
    Status, 
    ArtworkImage)  

    values  
    ( 
    artwork_seq.NEXTVAL,  
    UserID, 
    ArtCategoryID, 
    ExhibitionID,  
    OrderItemsID, 
    Name, 
    Description,  
    Amount, 
    Status, 
    ArtworkImage 
); 

dbms_output.put_line('Row inserted into ARTWORK Table'); 
dbms_output.put_line('----------------------------------------------------------'); 
commit; 
exception 
when dup_val_on_index then 
dbms_output.put_line('Duplicate Value Found in ARTWORK! Insert Different Value'); 
when others then 
dbms_output.put_line('Error while inserting data into ARTWORK Table'); 
rollback; 
dbms_output.put_line('The error encountered is: '); 
dbms_output.put_line(dbms_utility.format_error_stack); 
dbms_output.put_line('----------------------------------------------------------'); 
END INSERT_ARTWORK; 
/

create or replace PROCEDURE UPDATE_ARTWORK(
    ArtworkID in INTEGER, 
    UserID in INTEGER,
    ArtCategoryID in INTEGER,
    ExhibitionID in INTEGER,
    OrderItemsID in INTEGER,
    NAME in VARCHAR,
    Description in VARCHAR,
    Amount in NUMBER,
    Status in VARCHAR,
    ArtworkImage in BLOB
) AS 
BEGIN 
    dbms_output.put_line('----------------------------------------------------------'); 
    update artwork 
set 
    UserID = UPDATE_ARTWORK.UserID,
    ArtCategoryID = UPDATE_ARTWORK.ArtCategoryID,
    ExhibitionID = UPDATE_ARTWORK.ExhibitionID,
    OrderItemsID = UPDATE_ARTWORK.OrderItemsID,
    Name = UPDATE_ARTWORK.NAME,
    Description = UPDATE_ARTWORK.Description,
    Amount = UPDATE_ARTWORK.Amount,
    Status = UPDATE_ARTWORK.Status,
    ArtworkImage = UPDATE_ARTWORK.ArtworkImage
where
    ArtworkID = UPDATE_ARTWORK.ArtworkID;

    dbms_output.put_line('Row updated in ARTWORK Table'); 
    dbms_output.put_line('----------------------------------------------------------'); 
    commit; 
exception 
    when dup_val_on_index then 
        dbms_output.put_line('Duplicate Value Found in ARTWORK! Insert Different Value'); 
    when others then 
        dbms_output.put_line('Error while updating data in ARTWORK Table'); 
        rollback; 
        dbms_output.put_line('The error encountered is: '); 
        dbms_output.put_line(dbms_utility.format_error_stack); 
        dbms_output.put_line('----------------------------------------------------------'); 
END UPDATE_ARTWORK; 
/

CREATE OR REPLACE PROCEDURE DELETE_ARTWORK (
    ArtworkID IN INTEGER
) AS
BEGIN
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    DELETE FROM artwork WHERE ArtworkID = DELETE_ARTWORK.ArtworkID;
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
END DELETE_ARTWORK;
/


CREATE OR REPLACE PROCEDURE VIEW_ARTWORKS
IS
  v_artworkimage varchar2(32767); -- declare a variable to hold the BLOB converted to a string
BEGIN
  FOR rec IN (SELECT * FROM ARTWORK)
  LOOP
    -- convert the BLOB to a string representation using UTL_RAW.CAST_TO_VARCHAR2
    v_artworkimage := UTL_RAW.CAST_TO_VARCHAR2(rec.ARTWORKIMAGE);
    DBMS_OUTPUT.PUT_LINE('ARTWORK ID: ' || rec.ARTWORKID || ', User ID: ' || rec.USERID || ', ARTCATEGORY ID: ' || rec.ARTCATEGORYID || ', EXHIBITION ID: ' || rec.EXHIBITIONID || ', ORDERITEMSID: ' || rec.ORDERITEMSID || ', NAME: ' || rec.NAME || ', DESCRIPTION: ' || rec.DESCRIPTION || ', AMOUNT: ' || TO_CHAR(rec.AMOUNT) || ', STATUS: ' || rec.STATUS || ', ARTWORKIMAGE: ' || v_artworkimage );
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Artworks retrieved successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


