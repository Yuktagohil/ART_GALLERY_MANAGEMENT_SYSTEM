CREATE OR REPLACE PROCEDURE INSERT_USER_ROLE (
   p_role_name IN user_role.rolename%TYPE
) AS
   v_count NUMBER;
   v_role_id NUMBER(5);
BEGIN
    SELECT COUNT(*) INTO v_count FROM user_role WHERE rolename = p_role_name;
   
   SELECT MAX(roleid) + 1 INTO v_role_id FROM user_role;
   IF v_count > 1 THEN
   dbms_output.put_line('----------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('Role already exists');
   ELSE
      INSERT INTO user_role (roleid, rolename) VALUES (v_role_id, p_role_name);
      dbms_output.put_line('----------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('Role successfully inserted');
   END IF;
   COMMIT;
EXCEPTION
   WHEN OTHERS THEN
   dbms_output.put_line('----------------------------------------------------------');
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
      ROLLBACK;
END;
/


CREATE OR REPLACE PROCEDURE UPDATE_USER_ROLE(
    p_roleId IN NUMBER,
    p_roleName IN VARCHAR2
)
IS
    v_count NUMBER;
BEGIN
    -- Check if role exists
    SELECT COUNT(*) INTO v_count FROM user_role WHERE roleId = p_roleId;
    
    IF v_count = 0 THEN
    dbms_output.put_line('----------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('No such role exists.');
    ELSE
        -- Update user_role table
        UPDATE user_role SET roleName = p_roleName WHERE roleId = p_roleId;
        COMMIT;
        dbms_output.put_line('----------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Successfully updated role.');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
    dbms_output.put_line('----------------------------------------------------------');
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_USER_ROLE(
    p_roleId IN NUMBER
)
IS
    v_count NUMBER;
BEGIN
    -- Check if role exists
    SELECT COUNT(*) INTO v_count FROM user_role WHERE roleId = p_roleId;
    IF v_count = 0 THEN
        DBMS_OUTPUT.PUT_LINE('No such role exists.');
         DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    ELSE
        -- Delete from user_role table
        DELETE FROM user_role WHERE roleId = p_roleId;
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('User role Successfully deleted.');
         DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
         DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
END;
/


CREATE OR REPLACE PROCEDURE VIEW_USER_ROLES
IS
BEGIN
  FOR rec IN (SELECT * FROM USER_ROLE)
  LOOP
    DBMS_OUTPUT.PUT_LINE('ROLE ID: ' || rec.ROLEID || ', ROLE NAME: ' || rec.ROLENAME);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('User roles retrieved successfully.');
EXCEPTION
  WHEN OTHERS THEN
  dbms_output.put_line('----------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


