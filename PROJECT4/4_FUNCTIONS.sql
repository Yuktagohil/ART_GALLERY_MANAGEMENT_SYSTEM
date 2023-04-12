BEGIN
EXECUTE IMMEDIATE 'DROP FUNCTION purchase_artwork';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/    

BEGIN
EXECUTE IMMEDIATE 'DROP FUNCTION check_online_exhibition_status';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/    

BEGIN
EXECUTE IMMEDIATE 'DROP FUNCTION CALCULATE_TOTALAMOUNT';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/    


--function to purchase artwork
CREATE OR REPLACE FUNCTION purchase_artwork(p_UserID IN INTEGER, p_ArtworkID IN INTEGER)
RETURN VARCHAR2
IS
    v_Amount NUMBER;
    v_OrderItemsID INTEGER;
    v_OrderID INTEGER;
    v_Status VARCHAR2(45);
BEGIN
    SELECT Amount, TRIM(Status) INTO v_Amount, v_Status FROM artwork WHERE ArtworkID = p_ArtworkID;

    IF v_Status = 'Available' THEN
--        UPDATE artwork SET Status = 'Sold' WHERE ArtworkID = p_ArtworkID;
--        COMMIT;
        RETURN 'The artwork is available for purchase';
    ELSE
        RAISE_APPLICATION_ERROR(-20001, 'The artwork is not available for purchase.');
    END IF;
END;
/

--function to check the exhibition status
CREATE OR REPLACE FUNCTION check_online_exhibition_status(
    p_exhibition_id IN online_exhibition.exhibitionid%TYPE
)
RETURN VARCHAR2
IS
    v_status online_exhibition.exhibitionstatus%TYPE;
    v_msg VARCHAR2(200);
BEGIN
    SELECT exhibitionstatus INTO v_status FROM online_exhibition WHERE exhibitionid = p_exhibition_id;
    IF v_status = 'Active' THEN
    v_msg := 'EXHIBITION IS ACTIVE NOW';
        
    ELSIF v_status = 'Upcoming' then 
       v_msg := 'UPCOMING EXHIBITION'; 
    ELSIF v_status = 'Completed' then
        v_msg := 'EXHIBITION HAS BEEN COMPLETED';
    END IF;
    RETURN v_msg;
END;
/

--function to calculate total amount in order
CREATE OR REPLACE FUNCTION CALCULATE_TOTALAMOUNT(p_order_id IN ORDERS.ORDERID%TYPE)
RETURN NUMBER
IS
  v_total_amount NUMBER := 0;
BEGIN
  SELECT SUM(A.Amount) INTO v_total_amount
  FROM ORDER_ITEMS OI
  JOIN ARTWORK A ON OI.OrderItemsID = A.OrderItemsID
  WHERE OI.OrderID = p_order_id;
  
  RETURN v_total_amount;
END;
/


-- Test cases for purchase_artwork function
DECLARE
  v_result VARCHAR2(4000);
BEGIN
  v_result := purchase_artwork(p_UserID => 11, p_ArtworkID => 41);
  DBMS_OUTPUT.PUT_LINE('Purchase result: ' || v_result);
END;
/

-- Test cases for check_online_exhibition_status function
-- Test case 1: Valid input, exhibition is active
DECLARE
v_result VARCHAR2(200);
BEGIN
v_result := check_online_exhibition_status(1); -- Assuming exhibition ID 1 is active
DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- Test case 2: Valid input, exhibition is upcoming
DECLARE
v_result VARCHAR2(200);
BEGIN
v_result := check_online_exhibition_status(2); -- Assuming exhibition ID 2 is upcoming
DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- Test case 3: Valid input, exhibition is completed
DECLARE
v_result VARCHAR2(200);
BEGIN
v_result := check_online_exhibition_status(3); -- Assuming exhibition ID 3 is completed
DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- Test cases for CALCULATE_TOTALAMOUNT function
-- Test case 1: Valid input, order ID exists
DECLARE
v_result NUMBER;
BEGIN
v_result := CALCULATE_TOTALAMOUNT(1); -- Assuming order ID 1 exists and has some artwork
DBMS_OUTPUT.PUT_LINE(v_result);
END;
/

-- Test case 2: Valid input, order ID does not exist
DECLARE
v_result NUMBER;
BEGIN
v_result := CALCULATE_TOTALAMOUNT(100); -- Assuming order ID 100 does not exist
DBMS_OUTPUT.PUT_LINE(v_result);
END;
/
