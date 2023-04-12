CREATE OR REPLACE PROCEDURE INSERT_ORDER_ITEM(
   p_order_id IN ORDER_ITEMS.ORDERID%TYPE,
   p_orderitems_id IN ORDER_ITEMS.ORDERITEMSID%TYPE
) AS
   v_order_items_id ORDER_ITEMS.ORDERITEMSID%TYPE;
   IS_TRUE NUMBER;
BEGIN
   -- Check if the order exists
   select count(*) 
    INTO IS_TRUE
    from ORDER_ITEMS where ORDERITEMSID = p_orderitems_id;
    IF IS_TRUE > 0
    THEN
        DBMS_OUTPUT.PUT_LINE('Order Items already exists.');
    ELSE

   -- Insert the order item
   INSERT INTO ORDER_ITEMS (ORDERITEMSID, ORDERID)
   VALUES (order_items_seq.NEXTVAL, p_order_id);

   -- Display success message
   DBMS_OUTPUT.PUT_LINE('Order item inserted successfully.');
   END IF;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      -- Handle error when order or artwork doesn't exist
      DBMS_OUTPUT.PUT_LINE('Order or artwork does not exist.');
   WHEN OTHERS THEN
      -- Handle other errors
      DBMS_OUTPUT.PUT_LINE('An error occurred while inserting the order item.');
END;
/

CREATE OR REPLACE PROCEDURE UPDATE_ORDER_ITEMS(
    p_order_id IN ORDER_ITEMS.ORDERID%TYPE,
    p_order_items_id IN ORDER_ITEMS.ORDERITEMSID%TYPE
)
AS
    v_order_items_count INTEGER;
    V_ORDERSTATUS VARCHAR(50);
BEGIN
    -- Check if the order item already exists
    SELECT COUNT(*) INTO v_order_items_count
    FROM ORDER_ITEMS
    WHERE OrderID = p_order_id;

    -- If the order item already exists, raise an exception
    IF v_order_items_count > 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'Order item already exists');
    END IF;
    SELECT ORDERSTATUS INTO V_ORDERSTATUS FROM ORDERS WHERE ORDERID=p_order_id;
    IF V_ORDERSTATUS= 'COMPLETE'
    THEN
    DBMS_OUTPUT.PUT_LINE('Order is complete and cannot be updated');
    ELSE
    -- If the order item doesn't exist, insert it
    INSERT INTO ORDER_ITEMS (OrderID, OrderItemsID)
    VALUES (p_order_id, p_order_items_id);

    -- Display success message
    DBMS_OUTPUT.PUT_LINE('Order item inserted successfully');
    END IF;
EXCEPTION
    -- Handle exceptions
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/

CREATE OR REPLACE PROCEDURE DELETE_ORDER_ITEM (
    p_order_id IN ORDER_ITEMS.ORDERID%TYPE,
    p_order_items_id IN ORDER_ITEMS.ORDERITEMSID%TYPE
)
AS
  v_count INTEGER;
  v_ORDER_count INTEGER;
  v_order_status ORDERS.ORDERSTATUS%TYPE;
BEGIN
  -- Check if the order item exists
  SELECT COUNT(*) INTO v_count FROM ORDER_ITEMS WHERE ORDERITEMSID = p_order_items_id;

  -- If there are no records, raise an exception
  IF v_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Order item not found');
  END IF;

  -- If there are more than one record, raise an exception
  IF v_count > 1 THEN
    RAISE_APPLICATION_ERROR(-20002, 'Duplicate order items found');
  END IF;
    SELECT ORDERSTATUS INTO v_order_status FROM ORDERS WHERE ORDERID=p_order_id;
    SELECT COUNT(*) INTO v_ORDER_count FROM ORDER_ITEMS WHERE ORDERITEMSID=p_order_items_id and ORDERID=p_order_id;
    IF v_order_status= 'COMPLETE'
    THEN
    DBMS_OUTPUT.PUT_LINE('Order is complete and cannot be updated');
    ELSIF v_ORDER_count = 1
    THEN
  -- If there is only one record, delete it and display a message
  DELETE FROM ORDER_ITEMS WHERE ORDERITEMSID = p_order_items_id;
  DBMS_OUTPUT.PUT_LINE('Order item deleted successfully');
  END IF;
  EXCEPTION
   WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLCODE || ' - ' || SQLERRM);
END;
/


CREATE OR REPLACE PROCEDURE VIEW_ORDER_ITEMS
IS
    v_OrderId ORDER_ITEMS.ORDERID%TYPE;
    v_OrderItemsId ORDER_ITEMS.ORDERITEMSID%TYPE;
BEGIN
    FOR c IN (SELECT ORDERID, OrderItemsID FROM ORDER_ITEMS)
    LOOP
        v_OrderId := c.ORDERID;
        v_OrderItemsId := c.ORDERITEMSID;
        DBMS_OUTPUT.PUT_LINE('ORDER ID: ' || v_OrderId || ', ORDER ITEMS ID: ' || v_OrderItemsId);
    END LOOP;
END;
/

