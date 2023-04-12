CREATE OR REPLACE PROCEDURE INSERT_EXHIBITION (
  p_user_id                  IN NUMBER,
  p_exhibition_start_date    IN DATE,
  p_exhibition_end_date      IN DATE,
  p_exhibition_status        IN VARCHAR2
)
IS
  v_exhibition_id  NUMBER;
  
BEGIN
    
  SELECT online_exhibition_seq.NEXTVAL INTO v_exhibition_id FROM DUAL;
  INSERT INTO online_exhibition (EXHIBITIONID, USERID, EXHIBITIONSTARTDATETIME, EXHIBITIONENDDATETIME, EXHIBITIONSTATUS)
  VALUES (v_exhibition_id, p_user_id, p_exhibition_start_date, p_exhibition_end_date, p_exhibition_status);
  COMMIT;
  DBMS_OUTPUT.PUT_LINE('Successfully inserted exhibition with ID: ' || v_exhibition_id);
 DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
  WHEN DUP_VAL_ON_INDEX THEN
    DBMS_OUTPUT.PUT_LINE('Error: Exhibition ID already exists. Insertion failed.');
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_EXHIBITION (
  p_exhibition_id            IN NUMBER,
  p_user_id                  IN NUMBER,
  p_exhibition_start_date    IN DATE,
  p_exhibition_end_date      IN DATE,
  p_exhibition_status        IN VARCHAR2
)
IS
  IS_TRUE NUMBER;
  v_exhibition_start_date ONLINE_EXHIBITION.EXHIBITIONSTARTDATETIME%TYPE;
  v_exhibition_status      ONLINE_EXHIBITION.EXHIBITIONSTATUS%TYPE;
BEGIN
  select count(*) INTO IS_TRUE from online_exhibition where EXHIBITIONID = p_exhibition_id;
  
  IF IS_TRUE = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Exhibition ID does not exist. Update failed.');
    dbms_output.put_line('----------------------------------------------------------'); 
  ELSE
    SELECT EXHIBITIONSTARTDATETIME INTO v_exhibition_start_date FROM online_exhibition WHERE EXHIBITIONID = p_exhibition_id;
    
    IF v_exhibition_start_date = SYSDATE THEN 
      v_exhibition_status := 'Active';
    ELSIF v_exhibition_start_date > SYSDATE THEN 
      v_exhibition_status := 'Upcoming';
    ELSE 
      v_exhibition_status := 'Completed';
    END IF;
    
    UPDATE online_exhibition
    SET USERID = p_user_id,
        EXHIBITIONSTARTDATETIME = p_exhibition_start_date,
        EXHIBITIONENDDATETIME = p_exhibition_end_date,
        EXHIBITIONSTATUS = p_exhibition_status
    WHERE EXHIBITIONID = v_exhibition_status;
  
    IF SQL%ROWCOUNT = 0 THEN
      DBMS_OUTPUT.PUT_LINE('Error: Exhibition ID does not exist. Update failed.');
      dbms_output.put_line('----------------------------------------------------------'); 
    ELSE
      DBMS_OUTPUT.PUT_LINE('Successfully updated exhibition with ID: ' || p_exhibition_id);
      dbms_output.put_line('----------------------------------------------------------'); 
    END IF;
  END IF;
  COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
END;
/


CREATE OR REPLACE PROCEDURE DELETE_EXHIBITION (
  p_exhibition_id            IN NUMBER
)
IS
  
BEGIN
    
  DELETE FROM online_exhibition
  WHERE EXHIBITIONID = p_exhibition_id;
  
  IF SQL%ROWCOUNT = 0 THEN
    DBMS_OUTPUT.PUT_LINE('Error: Exhibition ID does not exist. Deletion failed.');
    dbms_output.put_line('----------------------------------------------------------'); 
  ELSE
    DBMS_OUTPUT.PUT_LINE('Successfully deleted exhibition with ID: ' || p_exhibition_id);
    dbms_output.put_line('----------------------------------------------------------'); 
  END IF;
 COMMIT;
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    dbms_output.put_line('----------------------------------------------------------'); 
END;
/

CREATE OR REPLACE PROCEDURE VIEW_EXHIBITIONS IS
  CURSOR c_exhibitions IS SELECT EXHIBITIONID, USERID, EXHIBITIONSTARTDATETIME, EXHIBITIONENDDATETIME, EXHIBITIONSTATUS FROM online_exhibition;
  v_exhibition_id online_exhibition.EXHIBITIONID%TYPE;
  v_user_id online_exhibition.USERID%TYPE;
  v_start_date online_exhibition.EXHIBITIONSTARTDATETIME%TYPE;
  v_end_date online_exhibition.EXHIBITIONENDDATETIME%TYPE;
  v_status online_exhibition.EXHIBITIONSTATUS%TYPE;
BEGIN
  OPEN c_exhibitions;
  LOOP
    FETCH c_exhibitions INTO v_exhibition_id, v_user_id, v_start_date, v_end_date, v_status;
    EXIT WHEN c_exhibitions%NOTFOUND;
    DBMS_OUTPUT.PUT_LINE('Exhibition ID: ' || v_exhibition_id || ', User ID: ' || v_user_id || ', Start Date: ' || TO_CHAR(v_start_date, 'YYYY-MM-DD HH24:MI:SS') || ', End Date: ' || TO_CHAR(v_end_date, 'YYYY-MM-DD HH24:MI:SS') || ', Status: ' || v_status);
  END LOOP;
  CLOSE c_exhibitions;
  DBMS_OUTPUT.PUT_LINE('Successfully retrieved exhibition details.');
  DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------');
END;
/




