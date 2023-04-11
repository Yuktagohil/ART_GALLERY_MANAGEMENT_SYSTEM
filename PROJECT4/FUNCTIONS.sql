--function to purchase artwork
CREATE OR REPLACE FUNCTION purchase_artwork(p_UserID IN NUMBER, p_ArtworkID IN NUMBER)
RETURN VARCHAR
IS
    v_Amount NUMBER;
    v_Status VARCHAR2(10);
    v_OrderItemsID NUMBER;
    v_OrderID Number;
BEGIN
    SELECT Amount, Status INTO v_Amount, v_Status FROM artwork WHERE ArtworkID = p_ArtworkID;
    
    IF v_Status = 'Available' THEN
        UPDATE artwork SET Status = 'Sold' WHERE ArtworkID = p_ArtworkID;
        COMMIT;
        RETURN 'Your order is placed';
        
        -- Generate a new order ID
        SELECT order_items_seq.NEXTVAL INTO v_OrderID FROM dual;
        
        -- Insert the order details into order_items table
        INSERT INTO order_items (OrderItemsID, OrderID)
        VALUES (p_ArtworkID, order_items_seq.NEXTVAL);
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