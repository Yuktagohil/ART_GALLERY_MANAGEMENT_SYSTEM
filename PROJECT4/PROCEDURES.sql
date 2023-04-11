--procedure to manage artwork
CREATE OR REPLACE PROCEDURE manage_artwork (
p_artwork_id IN NUMBER,
p_art_category_id IN NUMBER,
p_user_id IN NUMBER,
p_exhibition_id IN NUMBER,
p_order_items_id IN NUMBER,
p_name IN VARCHAR2,
p_description IN VARCHAR2,
p_amount IN NUMBER,
p_status IN VARCHAR2,
p_artwork_image IN BLOB
)
AS
BEGIN
IF p_artwork_id IS NULL THEN
-- Insert new artwork
INSERT INTO ARTWORK (ArtworkID, ArtCategoryID, UserID, ExhibitionID, OrderItemsID, Name, Description, Amount, Status, ArtworkImage)
VALUES (artwork_seq.NEXTVAL, p_art_category_id, p_user_id, p_exhibition_id, p_order_items_id, p_name, p_description, p_amount, p_status, p_artwork_image);
ELSE
-- Update existing artwork
UPDATE ARTWORK
SET ArtCategoryID = p_art_category_id,
UserID = p_user_id,
ExhibitionID = p_exhibition_id,
OrderItemsID = p_order_items_id,
Name = p_name,
Description = p_description,
Amount = p_amount,
Status = p_status,
ArtworkImage = p_artwork_image
WHERE ArtworkID = p_artwork_id;
END IF;
END;
/

--procedure to manage users
CREATE OR REPLACE PROCEDURE manage_users (
    p_user_id IN USERS.USERID%TYPE,
    p_role_id IN USERS.ROLEID%TYPE DEFAULT NULL,
    p_email_id IN USERS.EMAILID%TYPE DEFAULT NULL,
    p_user_name IN USERS.USERNAME%TYPE DEFAULT NULL,
    p_password IN USERS.PASSWORD%TYPE DEFAULT NULL,
    p_first_name IN USERS.FIRSTNAME%TYPE DEFAULT NULL,
    p_last_name IN USERS.LastName%TYPE DEFAULT NULL,
    p_speciality IN USERS.SPECIALITY%TYPE DEFAULT NULL,
    p_nationality IN USERS.NATIONALITY%TYPE DEFAULT NULL,
    p_contact_id IN CONTACT.CONTACTID%TYPE DEFAULT NULL,
    p_contact_number IN CONTACT.CONTACTNUMBER%TYPE DEFAULT NULL,
    p_address_line1 IN CONTACT.ADDRESSLINE1%TYPE DEFAULT NULL,
    p_address_line2 IN CONTACT.ADDRESSLINE2%TYPE DEFAULT NULL,
    p_city IN CONTACT.CITY%TYPE DEFAULT NULL,
    p_state IN CONTACT.STATE%TYPE DEFAULT NULL,
    p_country IN CONTACT.COUNTRY%TYPE DEFAULT NULL,
    p_zipcode IN CONTACT.ZIPCODE%TYPE DEFAULT NULL,
    p_action IN VARCHAR2,
    p_msg OUT VARCHAR2
)
IS
    a_user_id NUMBER(5);
    v_user_id NUMBER(5);
    v_email_exists NUMBER(1) := 0;
BEGIN
    IF (p_action = 'ADD') THEN
        -- Check for duplicate email
        SELECT COUNT(*) INTO v_email_exists FROM USERS WHERE EmailID = p_email_id;
        IF v_email_exists > 0 THEN
            p_msg := 'Email already exists';
            RETURN;
        END IF;
        IF LENGTH(p_contact_number) != 10 THEN
            p_msg := 'Mobile Number should be 10 digits';
            RETURN;
        END IF;
        IF p_role_id IS NULL THEN
            p_msg := 'Role cannot be null';
            RETURN;
        END IF;
        IF p_email_id IS NULL THEN
            p_msg := 'Email id cannot be null';
            RETURN;
        END IF;
        IF p_user_name IS NULL THEN
            p_msg := 'Username cannot be null';
            RETURN;
        END IF;
        IF p_password IS NULL THEN
            p_msg := 'Password cannot be null';
            RETURN;
        END IF;
        IF p_first_name IS NULL THEN
            p_msg := 'Firstname cannot be null';
            RETURN;
        END IF;
        IF p_last_name IS NULL THEN
            p_msg := 'Lastname cannot be null';
            RETURN;
        END IF;
        IF p_contact_id IS NOT NULL THEN
            p_msg := 'Contact id should be null for add action';
            RETURN;
        END IF;
        IF p_contact_number IS NULL THEN
            p_msg := 'Mobile Number cannot be null';
            RETURN;
        END IF;
        IF p_address_line1 IS NULL THEN
            p_msg := 'Address line 1  cannot be null';
            RETURN;
        END IF;
        IF p_address_line2 IS NULL THEN
            p_msg := 'Address line 2 cannot be null';
            RETURN;
        END IF;
        IF p_city IS NULL THEN
            p_msg := 'City cannot be null';
            RETURN;
        END IF;
        IF p_state IS NULL THEN
            p_msg := 'State cannot be null';
            RETURN;
        END IF;
        IF p_country IS NULL THEN
            p_msg := 'Country cannot be null';
            RETURN;
        END IF;
        IF p_zipcode IS NULL THEN
            p_msg := 'Zipcode cannot be null';
            RETURN;
        END IF;
        
        
        -- Generate new user ID if not provided
        IF p_user_id IS NULL THEN
            SELECT MAX(UserID) + 1 INTO v_user_id FROM USERS;
        ELSE
            v_user_id := p_user_id;
        END IF;

        -- Insert new user and contact information
        INSERT INTO USERS (UserID, RoleID, EmailID, UserName, Password, FirstName, LastName, Speciality, Nationality)
        VALUES (users_seq.NEXTVAL, p_role_id, p_email_id, p_user_name, p_password, p_first_name, p_last_name, p_speciality, p_nationality);

        INSERT INTO CONTACT (ContactID, UserID, ContactNumber, AddressLine1, AddressLine2, City, State, Country, ZipCode)
        VALUES (contact_seq.NEXTVAL, users_seq.CURRVAL, p_contact_number, p_address_line1, p_address_line2, p_city, p_state, p_country, p_zipcode);

        p_msg := 'User added successfully';
        
    ELSIF (p_action = 'UPDATE') THEN
        IF p_user_id IS NULL THEN
            SELECT UserID INTO a_user_id FROM USERS WHERE EmailID = p_email_id;
            
        END IF;
        IF p_contact_id IS NOT NULL THEN
            p_msg := 'Contact id should be null for update action';
            RETURN;
        END IF;
       
        -- Update user and contact information
        UPDATE USERS SET RoleID = p_role_id, UserName = p_user_name, Password = p_password, FirstName = p_first_name, LastName = p_last_name, Speciality = p_speciality, Nationality = p_nationality
        WHERE UserID = a_user_id and  EmailID = p_email_id;

        UPDATE CONTACT SET ContactID = contact_seq.NEXTVAL, ContactNumber = p_contact_number, AddressLine1 = p_address_line1, AddressLine2 = p_address_line2, City = p_city, State = p_state, Country = p_country, ZipCode = p_zipcode
        WHERE UserID = a_user_id;

        p_msg := 'User updated successfully';
ELSIF (p_action = 'DELETE') THEN
    IF p_user_id IS NULL THEN
            p_msg := 'User id cannot be null';
            RETURN;
        END IF;
    
    DELETE FROM CONTACT WHERE UserID = p_user_id;
    DELETE FROM USERS WHERE UserID = p_user_id;
    p_msg := 'User deleted successfully';
ELSE
    p_msg := 'Invalid action';
END IF;
END;
/

