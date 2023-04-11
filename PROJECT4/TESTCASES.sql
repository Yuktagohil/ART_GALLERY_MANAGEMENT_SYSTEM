--TESTCASES FOR FUNCTION TO MANAGE USERS
--test case 1: Add a new user
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := manage_users(
        p_role_id => 1,
        p_email_id => 'testuser@example.com',
        p_username => 'testuser',
        p_password => 'password',
        p_firstname => 'Test',
        p_lastname => 'User',
        p_speciality => 'Painting',
        p_nationality => 'US',
        p_contact_number => '1234567890',
        p_address_line1 => '123 Main St',
        p_address_line2 => 'Apt 5009',
        p_city => 'Anytown',
        p_state => 'CA',
        p_country => 'USA',
        p_zipcode => 12345,
        p_action => 'ADD'
    );
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
-- Expected output: User added successfully

--test case 2: Update an existing user
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := manage_users(
        p_user_id => 31,
        p_role_id => 2,
        p_email_id => 'updateduser@example.com',
        p_username => 'updateduser',
        p_password => 'newpassword',
        p_firstname => 'Updated',
        p_lastname => 'User',
        p_speciality => 'Sculpture',
        p_nationality => 'CA',
        p_contact_number => '0987654321',
        p_address_line1 => '456 Elm St',
        p_address_line2 => 'Apt 5009',
        p_city => 'Othertown',
        p_state => 'NY',
        p_country => 'USA',
        p_zipcode => 54321,
        p_action => 'UPDATE'
    );
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
-- Expected output: User updated successfully


--test case 3: Delete a user
DECLARE
  v_msg VARCHAR2(200);
BEGIN
  -- delete contact records first
  DELETE FROM CONTACT WHERE UserID = 31;
  
  -- then delete user record
  v_msg := manage_users(31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'DELETE');
  DBMS_OUTPUT.PUT_LINE(v_msg);
END;
/
-- Expected output: User deleted successfully

--test case 4: Invalid action specified
DECLARE
    v_result VARCHAR2(200);
BEGIN
    v_result := manage_users(31, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'INVALID');
    DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
-- Expected output: Invalid action

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

--to add new artwork when artwork id is null
BEGIN
  manage_artwork(NULL , 2, 4, 7, 12, 'The Starry Night', 'A painting by vincent van gogh', 2500, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
END;
/
--to update existing artwork
BEGIN
  manage_artwork(8 , 3, 5, 10, 15, 'The Persistence of Memory', 'A painting by Salvador Dali', 5000, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
END;
/
--to update non-existing artwork
BEGIN
  manage_artwork(100 , 3, 5, 10, 15, 'The Persistence of Memory', 'A painting by Salvador Dali', 5000, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
END;
/
--Invalid Input
BEGIN
  manage_artwork(NULL , 2, 4, 7, 12, NULL, 'A painting by Salvador Dali', 5000, 'Sold', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
END;
/