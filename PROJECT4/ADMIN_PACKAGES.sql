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