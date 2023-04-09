
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
