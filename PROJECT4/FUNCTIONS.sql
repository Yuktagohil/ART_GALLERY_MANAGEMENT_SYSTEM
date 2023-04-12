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
CREATE OR REPLACE FUNCTION purchase_artwork(p_UserID IN NUMBER, p_ArtworkID IN NUMBER)
RETURN VARCHAR
IS
    v_Amount ARTWORK.AMOUNT%TYPE;
    v_Status ARTWORK.STATUS%TYPE;
    v_OrderID ORDERS.ORDERID%TYPE;
    v_OrderItemsID ORDER_ITEMS.ORDERITEMSID%TYPE;
    v_msg VARCHAR2(200);
BEGIN
    SELECT Amount, Status INTO v_Amount, v_Status FROM artwork WHERE ArtworkID = p_ArtworkID;
    
    IF v_Status = 'Available' THEN
        UPDATE artwork SET Status = 'Sold' WHERE ArtworkID = p_ArtworkID;
        COMMIT;
        RETURN 'Your order is placed';
        
        -- Generate a new order ID

        SELECT orders_seq.NEXTVAL INTO v_OrderID FROM dual;
        SELECT order_items_seq.NEXTVAL INTO v_OrderItemsID FROM dual;
        
        -- Insert the order details into order_items table
        INSERT INTO order_items (OrderItemsID, OrderID)
        VALUES (v_OrderItemsID, v_OrderID);
        v_msg := 'Your order is placed';
    ELSE
     v_msg := 'The artwork is not available for purchase.';
    END IF;
    RETURN v_msg;
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

