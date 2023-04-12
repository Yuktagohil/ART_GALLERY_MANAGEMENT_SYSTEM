CREATE OR REPLACE PROCEDURE INSERT_USER(
  p_role_id       IN USERS.ROLEID%TYPE,
  p_email_id      IN USERS.EMAILID%TYPE,
  p_username      IN USERS.USERNAME%TYPE,
  p_password      IN USERS.PASSWORD%TYPE,
  p_firstname     IN USERS.FIRSTNAME%TYPE,
  p_lastname      IN USERS.LASTNAME%TYPE,
  p_speciality    IN USERS.SPECIALITY%TYPE DEFAULT NULL,
  p_nationality   IN USERS.NATIONALITY%TYPE DEFAULT NULL
)
IS
  v_user_id   USERS.USERID%TYPE;
BEGIN
  BEGIN
    -- Check if the user with the given EMAILID already exists
    SELECT USERID INTO v_user_id FROM USERS WHERE EMAILID = p_email_id;
  
    -- If the user already exists, display error message and return
    DBMS_OUTPUT.PUT_LINE('Error: User with email ID ' || p_email_id || ' already exists.');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
    RETURN;
  EXCEPTION
    -- Handle "no data found" exception to proceed with user insertion
    WHEN NO_DATA_FOUND THEN
      NULL;
  END;
  
  BEGIN
    -- Generate unique ID using sequence
    
    SELECT users_seq.NEXTVAL INTO v_user_id FROM DUAL;
  
    -- Insert data into USERS table
    INSERT INTO USERS(
      USERID,
      ROLEID,
      EMAILID,
      USERNAME,
      PASSWORD,
      FIRSTNAME,
      LASTNAME,
      SPECIALITY,
      NATIONALITY
    )
    VALUES (
      v_user_id,
      p_role_id,
      p_email_id,
      p_username,
      p_password,
      p_firstname,
      p_lastname,
      p_speciality,
      p_nationality
    );
  
    -- Display success message
    DBMS_OUTPUT.PUT_LINE('Successfully inserted user with ID: ' || v_user_id);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
  
    -- Commit transaction
    COMMIT;
  EXCEPTION
    -- Handle exceptions
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
      ROLLBACK;
  END;
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_USER(
  p_userid       IN USERS.USERID%TYPE,
  p_role_id      IN USERS.ROLEID%TYPE,
  p_email_id     IN USERS.EMAILID%TYPE,
  p_username     IN USERS.USERNAME%TYPE,
  p_password     IN USERS.PASSWORD%TYPE,
  p_firstname    IN USERS.FIRSTNAME%TYPE,
  p_lastname     IN USERS.LASTNAME%TYPE,
  p_speciality   IN USERS.SPECIALITY%TYPE DEFAULT NULL,
  p_nationality  IN USERS.NATIONALITY%TYPE DEFAULT NULL
)
IS
  v_rowcount NUMBER;
BEGIN
  -- Check if the user with the given USERID exists
  SELECT COUNT(*) INTO v_rowcount FROM USERS WHERE USERID = p_userid and ROLEID = p_role_id;
  IF v_rowcount = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: User with ID ' || p_userid || ' does not exist.');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
    RETURN;
  END IF;

  -- Update data in USERS table
  UPDATE USERS SET
    ROLEID = p_role_id,
    EMAILID = p_email_id,
    USERNAME = p_username,
    PASSWORD = p_password,
    FIRSTNAME = p_firstname,
    LASTNAME = p_lastname,
    SPECIALITY = p_speciality,
    NATIONALITY = p_nationality
  WHERE USERID = p_userid;
  
  -- Display success message
  DBMS_OUTPUT.PUT_LINE('Successfully updated user with ID: ' || p_userid);
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
  
  -- Commit transaction
  COMMIT;
EXCEPTION
  -- Handle exceptions
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    ROLLBACK;
END;
/

CREATE OR REPLACE PROCEDURE DELETE_USER(
  p_userid IN USERS.USERID%TYPE
)
IS
  v_rowcount NUMBER;
BEGIN
  -- Check if the user with the given USERID exists
  SELECT COUNT(*) INTO v_rowcount FROM USERS WHERE USERID = p_userid;
  IF v_rowcount = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: User with ID ' || p_userid || ' does not exist.');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
    RETURN;
  END IF;

  -- Delete data from USERS table
  DELETE FROM USERS WHERE USERID = p_userid;
  
  -- Display success message
  DBMS_OUTPUT.PUT_LINE('Successfully deleted user with ID: ' || p_userid);
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
  
  -- Commit transaction
  COMMIT;
EXCEPTION
  -- Handle exceptions
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE view_users_details AS
   CURSOR c_users IS
      SELECT * FROM users;
   v_user users%ROWTYPE;
BEGIN
   OPEN c_users;
   LOOP
      FETCH c_users INTO v_user;
      EXIT WHEN c_users%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(v_user.USERID || ', ' || v_user.ROLEID || ', ' || v_user.EMAILID || ', ' ||
                           v_user.USERNAME || ', ' || v_user.PASSWORD || ', ' || v_user.FIRSTNAME || ', ' ||
                           v_user.LASTNAME || ', ' || v_user.SPECIALITY || ', ' || v_user.NATIONALITY);
   END LOOP;
   CLOSE c_users;
   DBMS_OUTPUT.PUT_LINE('All user details retrieved successfully');
EXCEPTION
   WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


