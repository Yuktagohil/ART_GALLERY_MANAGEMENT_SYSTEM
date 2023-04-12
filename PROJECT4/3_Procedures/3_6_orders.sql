CREATE OR REPLACE PROCEDURE INSERT_ORDER (
    p_order_id IN ORDERS.ORDERID%TYPE DEFAULT NULL,
    p_user_id IN ORDERS.USERID%TYPE,
    p_shipper_id IN ORDERS.SHIPPERID%TYPE,
    p_transaction_id IN ORDERS.TRANSACTIONID%TYPE,
    p_transaction_method IN ORDERS.TRANSACTIONMETHOD%TYPE,
    p_transaction_status IN ORDERS.TRANSACTIONSTATUS%TYPE,
    p_order_status IN ORDERS.ORDERSTATUS%TYPE,
    p_shipping_status IN ORDERS.SHIPPINGSTATUS%TYPE,
    p_shipping_address IN ORDERS.SHIPPINGADDRESS%TYPE,
    p_order_date_time IN ORDERS.ORDERDATETIME%TYPE,
    p_total_amount IN ORDERS.TOTALAMOUNT%TYPE
) AS
    v_order_id ORDERS.ORDERID%TYPE;
    IS_TRUE NUMBER;
BEGIN
SELECT orders_seq.NEXTVAL INTO v_order_id FROM dual;
    select count(*) 
    INTO IS_TRUE
    from ORDERS where ORDERID = p_order_id;
    IF IS_TRUE > 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Order already exists, provide orderid as NULL');
    ELSE
    
    INSERT INTO ORDERS (ORDERID, USERID, SHIPPERID, TRANSACTIONID, TRANSACTIONMETHOD, TRANSACTIONSTATUS, ORDERSTATUS, SHIPPINGSTATUS, SHIPPINGADDRESS, ORDERDATETIME, TOTALAMOUNT) 
    VALUES (v_order_id, p_user_id, p_shipper_id, p_transaction_id, p_transaction_method, p_transaction_status, p_order_status, p_shipping_status, p_shipping_address, p_order_date_time, p_total_amount);
    
    DBMS_OUTPUT.PUT_LINE('Order inserted successfully with ID ' || v_order_id);
    END IF;
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('Error: Order ID already exists.');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE update_order_status(p_order_id IN NUMBER, p_order_status IN VARCHAR2, p_shipping_status IN VARCHAR2) 
AS
IS_TRUE NUMBER;
BEGIN
select count(*) 
    INTO IS_TRUE
    from ORDERS where ORDERID = p_order_id;
    IF IS_TRUE = 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Order does not exists');
    ELSE
  UPDATE ORDERS
  SET OrderStatus = p_order_status,
      ShippingStatus = p_shipping_status
  WHERE OrderID = p_order_id;
  
  DBMS_OUTPUT.PUT_LINE('Order status updated successfully.');
  END IF;
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      DBMS_OUTPUT.PUT_LINE('Error: Order not found.');
    WHEN OTHERS THEN
      DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_ORDER(
    p_order_id IN ORDERS.ORDERID%TYPE
)
IS
    var_order_count INTEGER;
BEGIN
    -- Check if the order exists
    SELECT COUNT(*) INTO var_order_count FROM ORDERS WHERE ORDERID = p_order_id;
    IF var_order_count = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Order does not exist');
    END IF;
    
    -- Delete the order
    DELETE FROM ORDERS WHERE ORDERID = p_order_id;
    COMMIT;
    
    DBMS_OUTPUT.PUT_LINE('Order deleted successfully');
EXCEPTION
    -- Catch any exceptions and display the error message
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error deleting order: ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE VIEW_ORDERS
IS
BEGIN
  FOR rec IN (SELECT * FROM ORDERS)
  LOOP
    DBMS_OUTPUT.PUT_LINE('Order ID: ' || rec.OrderID || ', User ID: ' || rec.UserID || ', Shipper ID: ' || rec.ShipperID || ', Transaction ID: ' || rec.TransactionID || ', Transaction Method: ' || rec.TransactionMethod || ', Transaction Status: ' || rec.TransactionStatus || ', Order Status: ' || rec.OrderStatus || ', Shipping Status: ' || rec.ShippingStatus || ', Shipping Address: ' || rec.ShippingAddress || ', Order Date Time: ' || rec.OrderDateTime || ', Total Amount: ' || rec.TotalAmount);
  END LOOP;
  DBMS_OUTPUT.PUT_LINE('Orders retrieved successfully.');
EXCEPTION
  WHEN OTHERS THEN
    DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


