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
--testcase1: artworkid 3 status is available
DECLARE
  v_result VARCHAR(50);
BEGIN
  v_result := purchase_artwork(p_UserID => 3, p_ArtworkID => 3);
  DBMS_OUTPUT.PUT_LINE('Purchase result: ' || v_result);
END;
/
--expected output: Your order is placed.(In artwork table, the status of artworkid 3 will be updated as 'Sold'

--testcase2: artworkid 2 status is sold
DECLARE
  v_result VARCHAR(50);
BEGIN
  v_result := purchase_artwork(p_UserID => 3, p_ArtworkID => 2);
  DBMS_OUTPUT.PUT_LINE('Purchase result: ' || v_result);
END;
/
--expected output: The artwork is not available for purchase



--test case for function check_online_exhibition_status
DECLARE
    v_exhibition_status VARCHAR2(100);
BEGIN
    v_exhibition_status := check_online_exhibition_status(2);
    DBMS_OUTPUT.PUT_LINE(v_exhibition_status);
END;
/

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