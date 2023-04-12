CREATE OR REPLACE PACKAGE user_role_pkg IS
    -- Procedure to create a new user role
    PROCEDURE create_user_role(
        p_roleid IN NUMBER,
        p_rolename IN VARCHAR2
    );

    -- Procedure to update an existing user role
    PROCEDURE update_user_role(
        p_roleid IN NUMBER,
        p_rolename IN VARCHAR2
    );

    -- Procedure to delete an existing user role
    PROCEDURE delete_user_role(
        p_roleid IN NUMBER
    );

    -- Function to get all user roles
    FUNCTION get_user_roles
        RETURN SYS_REFCURSOR;
END user_role_pkg;
/

CREATE OR REPLACE PACKAGE BODY user_role_pkg IS
    -- Procedure to create a new user role
    PROCEDURE create_user_role(
        p_roleid IN NUMBER,
        p_rolename IN VARCHAR2
    ) AS
    BEGIN
        INSERT INTO user_role (roleid,rolename)
        VALUES (p_roleid,p_rolename);
        COMMIT;
    END create_user_role;

    -- Procedure to update an existing user role
    PROCEDURE update_user_role(
        p_roleid IN NUMBER,
        p_rolename IN VARCHAR2
    ) AS
    BEGIN
        UPDATE user_role
        SET rolename = p_rolename
        WHERE roleid = p_roleid;
        COMMIT;
    END update_user_role;

    -- Procedure to delete an existing user role
    PROCEDURE delete_user_role(
        p_roleid IN NUMBER
    ) AS
    BEGIN
        DELETE FROM user_role
        WHERE roleid = p_roleid;
        COMMIT;
    END delete_user_role;

    -- Function to get all user roles
    FUNCTION get_user_roles
        RETURN SYS_REFCURSOR AS
        l_cur SYS_REFCURSOR;
    BEGIN
        OPEN l_cur FOR
        SELECT roleid, rolename
        FROM user_role;
        RETURN l_cur;
    END get_user_roles;
END user_role_pkg;
/
--testcase
DECLARE
    -- Declare variables for the test case
    l_roleid NUMBER;
    l_rolename VARCHAR2(50);
    l_cur SYS_REFCURSOR;
BEGIN
    -- Test creating a new user role
    user_role_pkg.create_user_role(user_role_seq.NEXTVAL, 'Organizer');
    
    -- Test updating an existing user role
    user_role_pkg.update_user_role(1, 'Supervisor');
    
    -- Test deleting an existing user role
    user_role_pkg.delete_user_role(5);
    
    -- Test getting all user roles again to confirm the changes
    l_cur := user_role_pkg.get_user_roles;
    DBMS_OUTPUT.PUT_LINE('All User Roles after update and delete:');
    LOOP
        FETCH l_cur INTO l_roleid, l_rolename;
        EXIT WHEN l_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(l_roleid || ' - ' || l_rolename);
    END LOOP;
END;
/

CREATE OR REPLACE PACKAGE user_pkg IS

  PROCEDURE insert_user (
    p_userid     IN  USERS.userid%TYPE,
    p_roleid     IN  USERS.roleid%TYPE,
    p_username   IN  USERS.username%TYPE,
    p_emailid    IN  USERS.emailid%TYPE,
    p_password   IN  USERS.password%TYPE,
    p_firstname  IN  USERS.firstname%TYPE,
    p_lastname   IN  USERS.lastname%TYPE,
    p_speciality IN  USERS.speciality%TYPE,
    p_nationality IN USERS.nationality%TYPE
  );

  PROCEDURE update_user (
    p_userid     IN  USERS.userid%TYPE,
    p_roleid     IN  USERS.roleid%TYPE,
    p_username   IN  USERS.username%TYPE,
    p_emailid    IN  USERS.emailid%TYPE,
    p_password   IN  USERS.password%TYPE,
    p_firstname  IN  USERS.firstname%TYPE,
    p_lastname   IN  USERS.lastname%TYPE,
    p_speciality IN  USERS.speciality%TYPE,
    p_nationality IN USERS.nationality%TYPE
  );

  PROCEDURE delete_user (
    p_username IN USERS.username%TYPE
  );

END user_pkg;
/

CREATE OR REPLACE PACKAGE BODY user_pkg IS

  PROCEDURE insert_user (
    p_userid     IN  USERS.userid%TYPE,
    p_roleid     IN  USERS.roleid%TYPE,
    p_username   IN  USERS.username%TYPE,
    p_emailid    IN  USERS.emailid%TYPE,
    p_password   IN  USERS.password%TYPE,
    p_firstname  IN  USERS.firstname%TYPE,
    p_lastname   IN  USERS.lastname%TYPE,
    p_speciality IN  USERS.speciality%TYPE,
    p_nationality IN USERS.nationality%TYPE
  ) AS
  BEGIN
    INSERT INTO USERS (
      userid,
      roleid,
      username,
      emailid,
      password,
      firstname,
      lastname,
      speciality,
      nationality
    ) VALUES (
      p_userid,
      p_roleid,
      p_username,
      p_emailid,
      p_password,
      p_firstname,
      p_lastname,
      p_speciality,
      p_nationality
    );
    COMMIT;
  END insert_user;

  PROCEDURE update_user (
    p_userid     IN  USERS.userid%TYPE,
    p_roleid     IN  USERS.roleid%TYPE,
    p_username   IN  USERS.username%TYPE,
    p_emailid    IN  USERS.emailid%TYPE,
    p_password   IN  USERS.password%TYPE,
    p_firstname  IN  USERS.firstname%TYPE,
    p_lastname   IN  USERS.lastname%TYPE,
    p_speciality IN  USERS.speciality%TYPE,
    p_nationality IN USERS.nationality%TYPE
  ) AS
  BEGIN
    UPDATE USERS SET
      roleid = p_roleid,
      username = p_username,
      emailid = p_emailid,
      password = p_password,
      firstname = p_firstname,
      lastname = p_lastname,
      speciality = p_speciality,
      nationality = p_nationality
    WHERE userid = p_userid;
    COMMIT;
  END update_user;

  PROCEDURE delete_user (
    p_username IN USERS.username%TYPE
  ) AS
  BEGIN
    DELETE FROM USERS WHERE username = p_username;
    COMMIT;
  END delete_user;

END user_pkg;
/

-- Create a new user
BEGIN
  user_pkg.insert_user(
    p_userid => users_seq.NEXTVAL,
    p_roleid => 1,
    p_username => 'testuser',
    p_emailid => 'testuser@test.com',
    p_password => 'password',
    p_firstname => 'Test',
    p_lastname => 'User',
    p_speciality => 'Software Engineer',
    p_nationality => 'USA'
  );
END;
/
BEGIN
user_pkg.insert_user(
    p_userid => users_seq.NEXTVAL,
    p_roleid => 1,
    p_username => 'produser',
    p_emailid => 'testuser@test.com',
    p_password => 'password',
    p_firstname => 'Test',
    p_lastname => 'User',
    p_speciality => 'Software Engineer',
    p_nationality => 'USA'
  );
END;
/
-- Verify that the new user was created
SELECT * FROM USERS WHERE username = 'testuser';

-- Update the user's email address
BEGIN
  user_pkg.update_user(
    p_userid => users_seq.NEXTVAL,
    p_roleid => 2,
    p_username => 'testuser',
    p_emailid => 'updatedemail@test.com',
    p_password => 'password',
    p_firstname => 'Test',
    p_lastname => 'User',
    p_speciality => 'Software Engineer',
    p_nationality => 'USA'
  );
END;
/
-- Verify that the user's email address was updated
SELECT * FROM USERS WHERE username = 'testuser';

-- Delete the user
BEGIN
  user_pkg.delete_user(p_username => 'testuser');
END;
/
-- Verify that the user was deleted
SELECT * FROM USERS;
