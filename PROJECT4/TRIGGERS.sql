CREATE OR REPLACE TRIGGER trg_order_items
AFTER INSERT ON ORDER_ITEMS
FOR EACH ROW
DECLARE
  v_total_amount ORDERS.TOTALAMOUNT%TYPE;
  v_order_id NUMBER;
  v_OrderItemsID ORDER_ITEMS.ORDERITEMSID%TYPE;
    v_ShipperID SHIPPER.SHIPPERID%TYPE := 1;
    v_TransactionID ORDERS.TransactionID%TYPE;
    v_TransactionMethod ORDERS.TransactionMethod%TYPE := 'credit card';
    v_TransactionStatus ORDERS.TransactionStatus%TYPE := 'complete';
    v_OrderStatus ORDERS.OrderStatus%TYPE := 'Confirmed';
    v_ShippingStatus ORDERS.ShippingStatus%TYPE := 'Preparing to be Shipped';
    v_ShippingAddress ORDERS.ShippingAddress%TYPE;
    
BEGIN
    v_orderid := :NEW.orderid;
  -- Calculate the total amount
  v_total_amount := CALCULATE_TOTALAMOUNT(v_orderid);
  
  -- Generate a new order ID
  SELECT order_seq.NEXTVAL INTO v_order_id FROM dual;
  
  -- Insert the new order
  INSERT INTO ORDERS (OrderID, UserID, ShipperID, TransactionID, TransactionMethod, TransactionStatus, OrderStatus, ShippingStatus, ShippingAddress, OrderDateTime, TotalAmount)
  VALUES (v_orderid, p_UserID, v_ShipperID, v_TransactionID, v_TransactionMethod, v_TransactionStatus, v_OrderStatus, v_ShippingStatus, v_ShippingAddress, SYSDATE, v_total_amount);
END;
/
