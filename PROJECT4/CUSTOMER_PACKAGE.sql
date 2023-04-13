-- Package to handle customer-related operations
CREATE OR REPLACE PACKAGE CUSTOMER_PKG AS
-- Procedure to update customer details
PROCEDURE UPDATE_CUSTOMER_DETAILS(
    p_user_id IN USERS.USERID%TYPE DEFAULT NULL,
    p_role_id IN USERS.ROLEID%TYPE DEFAULT NULL,
    p_email_id IN USERS.EMAILID%TYPE DEFAULT NULL,
    p_user_name IN USERS.USERNAME%TYPE DEFAULT NULL,
    p_password IN USERS.PASSWORD%TYPE DEFAULT NULL,
    p_first_name IN USERS.FIRSTNAME%TYPE DEFAULT NULL,
    p_last_name IN USERS.LastName%TYPE DEFAULT NULL,
    p_speciality IN USERS.SPECIALITY%TYPE DEFAULT NULL,
    p_nationality IN USERS.NATIONALITY%TYPE DEFAULT NULL,
    p_contact_number IN CONTACT.CONTACTNUMBER%TYPE DEFAULT NULL,
    p_address_line1 IN CONTACT.ADDRESSLINE1%TYPE DEFAULT NULL,
    p_address_line2 IN CONTACT.ADDRESSLINE2%TYPE DEFAULT NULL,
    p_city IN CONTACT.CITY%TYPE DEFAULT NULL,
    p_state IN CONTACT.STATE%TYPE DEFAULT NULL,
    p_country IN CONTACT.COUNTRY%TYPE DEFAULT NULL,
    p_zipcode IN CONTACT.ZIPCODE%TYPE DEFAULT NULL,
    p_msg OUT VARCHAR2
);

-- Procedure to place an order
PROCEDURE CUSTOMER_PLACE_ORDER(
    o_order_id IN ORDERS.ORDERID%TYPE DEFAULT NULL,
    o_user_id IN ORDERS.UserID%TYPE,
    o_msg OUT VARCHAR2
    );
END CUSTOMER_PKG;
/


CREATE OR REPLACE PACKAGE BODY CUSTOMER_PKG AS
-- Procedure to update customer details
    PROCEDURE UPDATE_CUSTOMER_DETAILS(
        p_user_id IN USERS.USERID%TYPE DEFAULT NULL,
        p_role_id IN USERS.ROLEID%TYPE DEFAULT NULL,
        p_email_id IN USERS.EMAILID%TYPE DEFAULT NULL,
        p_user_name IN USERS.USERNAME%TYPE DEFAULT NULL,
        p_password IN USERS.PASSWORD%TYPE DEFAULT NULL,
        p_first_name IN USERS.FIRSTNAME%TYPE DEFAULT NULL,
        p_last_name IN USERS.LastName%TYPE DEFAULT NULL,
        p_speciality IN USERS.SPECIALITY%TYPE DEFAULT NULL,
        p_nationality IN USERS.NATIONALITY%TYPE DEFAULT NULL,
        p_contact_number IN CONTACT.CONTACTNUMBER%TYPE DEFAULT NULL,
        p_address_line1 IN CONTACT.ADDRESSLINE1%TYPE DEFAULT NULL,
        p_address_line2 IN CONTACT.ADDRESSLINE2%TYPE DEFAULT NULL,
        p_city IN CONTACT.CITY%TYPE DEFAULT NULL,
        p_state IN CONTACT.STATE%TYPE DEFAULT NULL,
        p_country IN CONTACT.COUNTRY%TYPE DEFAULT NULL,
        p_zipcode IN CONTACT.ZIPCODE%TYPE DEFAULT NULL,
        p_msg OUT VARCHAR2
    ) IS
        v_user_id USERS.USERID%TYPE;
        v_contact_id CONTACT.CONTACTID%TYPE;
    BEGIN
            IF p_user_id IS NULL THEN
                SELECT UserID INTO v_user_id FROM USERS WHERE EmailID = p_email_id;    
            ELSE
                v_user_id := p_user_id;
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
            
            SELECT CONTACTID INTO v_contact_id FROM CONTACT WHERE UserID = v_user_id;
            -- Update user and contact information
            UPDATE USERS SET RoleID = p_role_id, UserName = p_user_name, Password = p_password, FirstName = p_first_name, LastName = p_last_name, Speciality = p_speciality, Nationality = p_nationality
            WHERE UserID = v_user_id and EmailID = p_email_id;
    
            UPDATE CONTACT SET ContactID = v_contact_id, ContactNumber = p_contact_number, AddressLine1 = p_address_line1, AddressLine2 = p_address_line2, City = p_city, State = p_state, Country = p_country, ZipCode = p_zipcode
            WHERE UserID = v_user_id;
        
        commit;
        p_msg := 'User updated successfully';
    END UPDATE_CUSTOMER_DETAILS;
    
PROCEDURE CUSTOMER_PLACE_ORDER(
    o_order_id IN ORDERS.ORDERID%TYPE DEFAULT NULL,
    o_user_id IN ORDERS.UserID%TYPE,
    o_msg OUT VARCHAR2
) IS
    v_transaction_method ORDERS.TransactionMethod%TYPE;
    v_transaction_id ORDERS.TransactionID%TYPE;
    v_transaction_status ORDERS.TransactionID%TYPE := 'Processing';
    v_shipping_status ORDERS.ShippingStatus%TYPE := 'Preparing to be Shipped';
    v_order_status ORDERS.OrderStatus%TYPE := 'Confirmed';
    v_shipping_address varchar(500);
    v_total_amount ORDERS.TotalAmount%TYPE;
BEGIN
    IF o_order_id IS NOT NULL THEN
            o_msg := 'Order id should be null for update action';
            RETURN;
    END IF;
    select dbms_random.value(100000000000, 999999999999) into v_transaction_id  from dual;
    
      SELECT CASE ROUND(DBMS_RANDOM.VALUE(1,4))
               WHEN 1 THEN 'net banking' 
               WHEN 2 THEN 'wire transfer' 
               WHEN 3 THEN 'credit card' 
               WHEN 4 THEN 'debit card' 
             END
      INTO v_transaction_method FROM DUAL;
      SELECT (ADDRESSLINE1 || ADDRESSLINE2 || CITY || STATE || COUNTRY || ZIPCODE) INTO v_shipping_address from CONTACT WHERE USERID= o_user_id;
      SELECT calculate_totalamount(o_order_id) INTO v_total_amount FROM DUAL;
          INSERT INTO ORDERS (ORDERID, USERID, SHIPPERID, TRANSACTIONID, TRANSACTIONMETHOD, TRANSACTIONSTATUS, ORDERSTATUS, SHIPPINGSTATUS, SHIPPINGADDRESS, ORDERDATETIME, TOTALAMOUNT)
            VALUES (orders_seq.NEXTVAL, o_user_id, 1, v_transaction_id, v_transaction_method, v_transaction_status, v_order_status, v_shipping_status, v_shipping_address, SYSDATE, v_total_amount);

        COMMIT;
    o_msg := 'Order placed successfully';
END CUSTOMER_PLACE_ORDER;
END CUSTOMER_PKG;
/

--test case : Update an existing user
DECLARE
    v_msg VARCHAR2(100);
BEGIN
    CUSTOMER_PKG.UPDATE_CUSTOMER_DETAILS(
        p_user_id => NULL,
        p_role_id => 2,
        p_email_id => 'lock.simone@artgallery.com',
        p_user_name => 'johndoebbb',
        p_password => 'password123',
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_speciality => 'Web Development',
        p_nationality => 'USA',
        p_contact_number => '5553551234',
        p_address_line1 => '123 Main St.',
        p_address_line2 => 'Apt. 4B',
        p_city => 'New Anytown',
        p_state => 'CA',
        p_country => 'USA',
        p_zipcode => '12345',
        p_msg => v_msg
    );
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/

