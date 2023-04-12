--TESTCASES FOR PROCEDURE MANAGE USERS
-- Test case 1: Adding a new user
DECLARE
    v_msg VARCHAR2(100);
BEGIN
    manage_users(
        p_user_id => NULL,
        p_role_id => 1,
        p_email_id => 'johndoe@example.com',
        p_user_name => 'johndoe',
        p_password => 'password123',
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_speciality => 'Web Development',
        p_nationality => 'USA',
        p_contact_id => NULL,
        p_contact_number => '5501751234',
        p_address_line1 => '123 Main St.',
        p_address_line2 => 'Apt. 4B',
        p_city => 'Anytown',
        p_state => 'CA',
        p_country => 'USA',
        p_zipcode => '12345',
        p_action => 'ADD',
        p_msg => v_msg
    );
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/


-- Test case 2: Adding a new user
DECLARE
    v_msg VARCHAR2(100);
BEGIN
    manage_users(
        p_user_id => NULL,
        p_role_id => 3,
        p_email_id => 'testuser@example.com',
        p_user_name => 'testuser',
        p_password => 'password123',
        p_first_name => 'test',
        p_last_name => 'user',
        p_speciality => NULL,
        p_nationality => NULL,
        p_contact_id => NULL,
        p_contact_number => '5757979234',
        p_address_line1 => '123 Main St.',
        p_address_line2 => 'Apt. 4B',
        p_city => 'testtown',
        p_state => 'CA',
        p_country => 'USA',
        p_zipcode => '12345',
        p_action => 'ADD',
        p_msg => v_msg
    );
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/

--test case 3: Update an existing user
DECLARE
    v_msg VARCHAR2(100);
BEGIN
    manage_users(
        p_user_id => NULL,
        p_role_id => 2,
        p_email_id => 'johndoe@example.com',
        p_user_name => 'johndoebbb',
        p_password => 'password123',
        p_first_name => 'John',
        p_last_name => 'Doe',
        p_speciality => 'Web Development',
        p_nationality => 'USA',
        p_contact_id => NULL,
        p_contact_number => '5501751234',
        p_address_line1 => '123 Main St.',
        p_address_line2 => 'Apt. 4B',
        p_city => 'New Anytown',
        p_state => 'CA',
        p_country => 'USA',
        p_zipcode => '12345',
        p_action => 'UPDATE',
        p_msg => v_msg
    );
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/


--test case 4: Delete a user
DECLARE
    v_msg VARCHAR2(100);
BEGIN
    manage_users(
        p_user_id => 33,
        p_role_id => NULL,
        p_email_id => NULL,
        p_user_name => NULL,
        p_password => NULL,
        p_first_name => NULL,
        p_last_name => NULL,
        p_speciality => NULL,
        p_nationality => NULL,
        p_contact_id => NULL,
        p_contact_number => NULL,
        p_address_line1 => NULL,
        p_address_line2 => NULL,
        p_city => NULL,
        p_state => NULL,
        p_country => NULL,
        p_zipcode => NULL,
        p_action => 'DELETE',
        p_msg => v_msg
    );
    DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/


--TESTCASES FOR FUNCTION TO PURCHASE ARTWORK AND UPDATED ARTWORK STATUS
--testcase1: artworkid 22 status is available
DECLARE
    v_purchase_artwork VARCHAR2(100);
BEGIN
    v_purchase_artwork := purchase_artwork(11, 22);
    DBMS_OUTPUT.PUT_LINE(v_purchase_artwork);
END;
/

--testcase2: artworkid 30 status is sold
DECLARE
    v_purchase_artwork VARCHAR2(100);
BEGIN
    v_purchase_artwork := purchase_artwork(11, 30);
    DBMS_OUTPUT.PUT_LINE(v_purchase_artwork);
END;
/

--test case for function check_online_exhibition_status
DECLARE
    v_exhibition_status VARCHAR2(100);
BEGIN
    v_exhibition_status := check_online_exhibition_status(2);
    DBMS_OUTPUT.PUT_LINE(v_exhibition_status);
END;
/


--TEST CASES FOR MANAGE ARTWORK PROCEDURE
--Test case 1: 
--adding artwork with artwork id as null
BEGIN
   manage_artwork(
      p_artwork_id => NULL,
      p_art_category_id => 1,
      p_user_id => 1,
      p_exhibition_id => 2,
      p_order_items_id => NULL,
      p_name => 'Test Artwork',
      p_description => 'This is a test artwork.',
      p_amount => 100,
      p_status => 'Available',
      p_artwork_image => utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'),
      p_action => 'ADD'
   );
END;
/
--Test case 2: 
--updating existing artwork
BEGIN
   manage_artwork(
      p_artwork_id => 1,
      p_art_category_id => 2,
      p_user_id => 2,
      p_exhibition_id => 2,
      p_order_items_id => 2,
      p_name => 'Updated Test Artwork',
      p_description => 'This is an updated test artwork.',
      p_amount => 200,
      p_status => 'Sold',
      p_artwork_image => utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'),
      p_action => 'UPDATE'
   );
END;
/
--Test case 3: 
--updating non existing artwork
BEGIN
   manage_artwork(
      p_artwork_id => 1000,
      p_art_category_id => 2,
      p_user_id => 2,
      p_exhibition_id => 2,
      p_order_items_id => 2,
      p_name => 'Updated Test Artwork',
      p_description => 'This is an updated test artwork.',
      p_amount => 200,
      p_status => 'Sold',
      p_artwork_image => utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'),
      p_action => 'UPDATE'
   );
END;
/
--Test case 4: 
--deleting existing artwork id
BEGIN
   manage_artwork(
      p_artwork_id => 1,
      p_art_category_id => NULL,
      p_user_id => NULL,
      p_exhibition_id => NULL,
      p_order_items_id => NULL,
      p_name => NULL,
      p_description => NULL,
      p_amount => NULL,
      p_status => NULL,
      p_artwork_image => NULL,
      p_action => 'DELETE'
   );
END;
/
--Test case 5: 
--deleting nonexisting artwork
BEGIN
   manage_artwork(
      p_artwork_id => 1000,
      p_art_category_id => NULL,
      p_user_id => NULL,
      p_exhibition_id => NULL,
      p_order_items_id => NULL,
      p_name => NULL,
      p_description => NULL,
      p_amount => NULL,
      p_status => NULL,
      p_artwork_image => NULL,
      p_action => 'DELETE'
   );
END;
/
--Test case 6: 
--cannot insert NULL values
BEGIN
   manage_artwork(
      p_artwork_id => NULL,
      p_art_category_id => NULL,
      p_user_id => 1,
      p_exhibition_id => 2,
      p_order_items_id => NULL,
      p_name => 'Test Artwork',
      p_description => 'This is a test artwork.',
      p_amount => 100,
      p_status => 'Available',
      p_artwork_image => utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'),
      p_action => 'ADD'
   );
END;
/

--test case to calculate total amount
DECLARE
    v_total_amount VARCHAR2(100);
BEGIN
    v_total_amount := CALCULATE_TOTALAMOUNT(5);
    DBMS_OUTPUT.PUT_LINE('Total Amount:' || v_total_amount);
END;
/
--TEST CASES FOR MANAGE ORDERS PROCEDURES
--Test case 1: Add a new order
-- Adding a new order
BEGIN
  manage_orders(
    p_order_id => NULL,
    p_user_id => 5,
    p_shipper_id => 7,
    p_transaction_id => 654762839876,
    p_transaction_method => 'Credit Card',
    p_transaction_status => 'Complete',
    p_order_status => 'Confirmed',
    p_shipping_status => 'Transit',
    p_shipping_address => '123 Main street',
    p_order_date_time => TO_DATE('2023-04-12 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_total_amount => 559.00,
    p_action => 'ADD'
  );
END;
/
--Test case 2: 
--updating existing order
BEGIN
  manage_orders(
    p_order_id => 11,
    p_user_id => 5,
    p_shipper_id => 6,
    p_transaction_id => 654762839876,
    p_transaction_method => 'Credit Card',
    p_transaction_status => 'Complete',
    p_order_status => 'Confirmed',
    p_shipping_status => 'Shipped',
    p_shipping_address => '123 Main street',
    p_order_date_time => TO_DATE('2023-04-12 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_total_amount => 559.00,
    p_action => 'UPDATE'
  );
END;
/
--Test case 3: 
--updating non-existing order
BEGIN
  manage_orders(
    p_order_id => 100,
    p_user_id => 5,
    p_shipper_id => 6,
    p_transaction_id => 654762839876,
    p_transaction_method => 'Credit Card',
    p_transaction_status => 'Complete',
    p_order_status => 'Confirmed',
    p_shipping_status => 'Shipped',
    p_shipping_address => '123 Main street',
    p_order_date_time => TO_DATE('2023-04-12 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_total_amount => 559.00,
    p_action => 'UPDATE'
  );
END;
/
--Test case 4: 
--deleting an existing order
BEGIN
    manage_orders(
        p_order_id => 18,
        p_user_id => NULL,
        p_shipper_id => NULL,
        p_transaction_id => NULL,
        p_transaction_method => NULL,
        p_transaction_status => NULL,
        p_order_status => NULL,
        p_shipping_status => NULL,
        p_shipping_address => NULL,
        p_order_date_time => NULL,
        p_total_amount => NULL,
        p_action => 'DELETE'
    );
END;
/

--Test  case 6:
--trying to add null values error
BEGIN
  manage_orders(
    p_order_id => NULL,
    p_user_id => 5,
    p_shipper_id => NULL,
    p_transaction_id => 654762839876,
    p_transaction_method => 'Credit Card',
    p_transaction_status => 'Complete',
    p_order_status => 'Confirmed',
    p_shipping_status => 'Transit',
    p_shipping_address => '123 Main street',
    p_order_date_time => TO_DATE('2023-04-12 10:30:00', 'YYYY-MM-DD HH24:MI:SS'),
    p_total_amount => 559.00,
    p_action => 'ADD'
  );
END;
/