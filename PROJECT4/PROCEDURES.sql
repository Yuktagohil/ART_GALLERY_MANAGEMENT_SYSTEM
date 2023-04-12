BEGIN
EXECUTE IMMEDIATE 'DROP PROCEDURE manage_artwork';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP PROCEDURE manage_users';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/

BEGIN
EXECUTE IMMEDIATE 'DROP PROCEDURE manage_orders';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/



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
p_artwork_image IN BLOB,
p_action IN VARCHAR2
)
AS
BEGIN
IF p_action = 'ADD' THEN
-- Insert new artwork
INSERT INTO ARTWORK (ArtworkID, ArtCategoryID, UserID, ExhibitionID, OrderItemsID, Name, Description, Amount, Status, ArtworkImage)
VALUES (artwork_seq.NEXTVAL, p_art_category_id, p_user_id, p_exhibition_id, p_order_items_id, p_name, p_description, p_amount, p_status, p_artwork_image);
DBMS_OUTPUT.PUT_LINE('Artwork added successfully.');
ELSIF p_action = 'UPDATE' THEN
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
  IF SQL%ROWCOUNT = 0 THEN
     DBMS_OUTPUT.PUT_LINE('Artwork not found.');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Artwork updated successfully.');
  END IF;
ELSIF p_action = 'DELETE' THEN
-- Delete artwork
DELETE FROM ARTWORK
WHERE ArtworkID = p_artwork_id;
  IF SQL%ROWCOUNT = 0 THEN
     DBMS_OUTPUT.PUT_LINE('Artwork not found.');
  ELSE
     DBMS_OUTPUT.PUT_LINE('Artwork deleted successfully.');
  END IF;
ELSE
DBMS_OUTPUT.PUT_LINE('Invalid action specified.');
END IF;
EXCEPTION
WHEN OTHERS THEN
DBMS_OUTPUT.PUT_LINE('An error occurred: ' || SQLERRM);
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

--procedure to manage orders
CREATE OR REPLACE PROCEDURE manage_orders(
    p_order_id IN NUMBER,
    p_user_id IN NUMBER,
    p_shipper_id IN NUMBER,
    p_transaction_id IN NUMBER,
    p_transaction_method IN VARCHAR2,
    p_transaction_status IN VARCHAR2,
    p_order_status IN VARCHAR2,
    p_shipping_status IN VARCHAR2,
    p_shipping_address IN VARCHAR2,
    p_order_date_time IN DATE,
    p_total_amount IN NUMBER,
    p_action IN VARCHAR2
)
IS
    v_order_count NUMBER;
BEGIN
    SELECT COUNT(*) INTO v_order_count FROM ORDERS WHERE OrderID = p_order_id;
    
    IF (p_action = 'ADD') THEN
        INSERT INTO ORDERS(
            OrderID, UserID, ShipperID, TransactionID, TransactionMethod, TransactionStatus,
            OrderStatus, ShippingStatus, ShippingAddress, OrderDateTime, TotalAmount
        )
        VALUES (
            orders_seq.NEXTVAL, p_user_id, p_shipper_id, p_transaction_id, p_transaction_method, p_transaction_status,
            p_order_status, p_shipping_status, p_shipping_address, p_order_date_time, p_total_amount
        );
        DBMS_OUTPUT.PUT_LINE('Order ADDED successfully');
    ELSIF (p_action = 'UPDATE') THEN
        IF v_order_count > 0 THEN
            UPDATE ORDERS
            SET
                UserID = p_user_id,
                ShipperID = p_shipper_id,
                TransactionID = p_transaction_id,
                TransactionMethod = p_transaction_method,
                TransactionStatus = p_transaction_status,
                OrderStatus = p_order_status,
                ShippingStatus = p_shipping_status,
                ShippingAddress = p_shipping_address,
                OrderDateTime = p_order_date_time,
                TotalAmount = p_total_amount
            WHERE OrderID = p_order_id;
            DBMS_OUTPUT.PUT_LINE('Order UPDATED successfully');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Error: Order not found');
        END IF;
    ELSIF (p_action = 'DELETE') THEN
        DELETE FROM ORDERS WHERE OrderID = p_order_id;
        DBMS_OUTPUT.PUT_LINE('Order DELETED successfully');
    END IF;
    
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error while ' || p_action || 'ing order: ' || SQLERRM);
END;
/


