CREATE OR REPLACE PROCEDURE INSERT_CONTACT(
    p_userid IN contact.userid%TYPE,
    p_contactnumber IN contact.contactnumber%TYPE,
    p_addressline1 IN contact.addressline1%TYPE,
    p_addressline2 IN contact.addressline2%TYPE,
    p_city IN contact.city%TYPE,
    p_state IN contact.state%TYPE,
    p_country IN contact.country%TYPE,
    p_zipcode IN contact.zipcode%TYPE
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM users WHERE userid = p_userid;
    
    IF v_count = 0 THEN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('No such userid exists');
    ELSE
        INSERT INTO contact(contactid, userid, contactnumber, addressline1, addressline2, city, state, country, zipcode)
        VALUES (contact_seq.NEXTVAL, p_userid, p_contactnumber, p_addressline1, p_addressline2, p_city, p_state, p_country, p_zipcode);
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Successfully inserted into contact table');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_CONTACT(
    p_contactid IN contact.contactid%TYPE,
    p_userid IN contact.userid%TYPE,
    p_contactnumber IN contact.contactnumber%TYPE,
    p_addressline1 IN contact.addressline1%TYPE,
    p_addressline2 IN contact.addressline2%TYPE,
    p_city IN contact.city%TYPE,
    p_state IN contact.state%TYPE,
    p_country IN contact.country%TYPE,
    p_zipcode IN contact.zipcode%TYPE
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM contact WHERE contactid = p_contactid AND userid = p_userid;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such contactid for userid exists');
    ELSE
        UPDATE contact
        SET contactnumber = p_contactnumber,
            addressline1 = p_addressline1,
            addressline2 = p_addressline2,
            city = p_city,
            state = p_state,
            country = p_country,
            zipcode = p_zipcode
        WHERE contactid = p_contactid AND userid = p_userid;
         COMMIT;
        DBMS_OUTPUT.PUT_LINE('Successfully updated in contact table');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_CONTACT(
    p_contactid IN contact.contactid%TYPE,
    p_userid IN contact.userid%TYPE
)
AS
    v_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_count FROM contact WHERE contactid = p_contactid AND userid = p_userid;
    
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such contactid for userid exists');
    ELSE
        DELETE FROM contact WHERE contactid = p_contactid AND userid = p_userid;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('Successfully deleted from contact table');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE VIEW_CONTACTS
IS
BEGIN
FOR rec IN (SELECT * FROM CONTACT)
LOOP
DBMS_OUTPUT.PUT_LINE('CONTACT ID: ' || rec.CONTACTID ||
', USER ID: ' || rec.USERID ||
', CONTACT NUMBER: ' || rec.CONTACTNUMBER ||
', ADDRESS LINE 1: ' || rec.ADDRESSLINE1 ||
', ADDRESS LINE 2: ' || rec.ADDRESSLINE2 ||
', CITY: ' || rec.CITY ||
', STATE: ' || rec.STATE ||
', COUNTRY: ' || rec.COUNTRY ||
', ZIPCODE: ' || rec.ZIPCODE);
END LOOP;
DBMS_OUTPUT.PUT_LINE('Contacts retrieved successfully.');
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

