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


-- Function to get orders for a customer
CREATE OR REPLACE FUNCTION GET_CUSTOMER_ORDERS(P_USERID IN INTEGER) RETURN SYS_REFCURSOR AS
    R_CUSTOMER_ORDERS SYS_REFCURSOR;
BEGIN
    OPEN R_CUSTOMER_ORDERS FOR
        SELECT o.OrderID, o.OrderDateTime, o.OrderStatus, o.TotalAmount
        FROM ORDERS o
        WHERE o.UserID = P_USERID;
        
    RETURN R_CUSTOMER_ORDERS;
END;
/

GET_CUSTOMER_ORDERS(7);

DECLARE
    CURSOR C_ORDERS IS
        SELECT OrderID, OrderDateTime, OrderStatus, TotalAmount
        FROM TABLE(GET_CUSTOMER_ORDERS(7));
    R_ORDER C_ORDERS%ROWTYPE;
BEGIN
    OPEN C_ORDERS;
    LOOP
        FETCH C_ORDERS INTO R_ORDER;
        EXIT WHEN C_ORDERS%NOTFOUND;
        -- do something with R_ORDER
    END LOOP;
    CLOSE C_ORDERS;
END;

-- Function to get the list of all available artwork
FUNCTION GET_AVAILABLE_ARTWORKS RETURN SYS_REFCURSOR AS
    available_artworks SYS_REFCURSOR;
BEGIN
    OPEN available_artworks FOR
    SELECT * FROM ARTWORK WHERE Status = 'AVAILABLE';
    RETURN available_artworks;
END GET_AVAILABLE_ARTWORKS;

-- Function to get the details of a specific artwork
FUNCTION GET_ARTWORK_DETAILS(P_ARTWORKID IN INTEGER) RETURN SYS_REFCURSOR AS
    artwork_details SYS_REFCURSOR;
BEGIN
    OPEN artwork_details FOR
    SELECT * FROM ARTWORK WHERE ArtworkID = P_ARTWORKID;
    RETURN artwork_details;
END GET_ARTWORK_DETAILS;

-- Function to get orders for a customer
CREATE OR REPLACE FUNCTION GET_CUSTOMER_ORDERS(P_USERID IN INTEGER) RETURN SYS_REFCURSOR AS
    CURSOR C_CUSTOMER_ORDERS IS
        SELECT o.OrderID, o.OrderDateTime, o.OrderStatus, o.TotalAmount
        FROM ORDERS o
        WHERE o.UserID = P_USERID;
    R_CUSTOMER_ORDERS SYS_REFCURSOR;
BEGIN
    OPEN R_CUSTOMER_ORDERS; 
    RETURN R_CUSTOMER_ORDERS;
END;
/

FUNCTION GET_CUSTOMER_ORDER_DETAILS(P_ORDERID IN INTEGER) RETURN SYS_REFCURSOR AS
    v_cursor SYS_REFCURSOR;
BEGIN
    -- code to retrieve order details goes here
    OPEN v_cursor FOR SELECT * FROM customer_orders WHERE order_id = P_ORDERID;
    RETURN v_cursor;
END;

DECLARE
    V_USERID INTEGER := 7; -- Replace 123 with the actual user ID
    V_CURSOR SYS_REFCURSOR;
BEGIN
    V_CURSOR := GET_CUSTOMER_ORDERS(V_USERID);
    -- You can now fetch the result set from the cursor and do further processing
END;

-- Function to get customer details
FUNCTION GET_CUSTOMER_DETAILS(P_USERID IN INTEGER) RETURN SYS_REFCURSOR AS
    CURSOR C_CUSTOMER_DETAILS IS
        SELECT u.FirstName, u.LastName, c.ContactNumber, c.AddressLine1,
               c.AddressLine2, c.City, c.State, c.Country, c.ZipCode
        FROM USERS u
        INNER JOIN CONTACT c ON u.UserID = c.UserID
        WHERE u.UserID = P_USERID;
    R_CUSTOMER_DETAILS SYS_REFCURSOR;
BEGIN
    OPEN R_CUSTOMER_DETAILS FOR
        SELECT * FROM C_CUSTOMER_DETAILS;
    RETURN R_CUSTOMER_DETAILS;
END GET_CUSTOMER_DETAILS;
