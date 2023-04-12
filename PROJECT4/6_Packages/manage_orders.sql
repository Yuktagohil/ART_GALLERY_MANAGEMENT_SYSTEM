CREATE OR REPLACE PACKAGE manage_orders AS
   PROCEDURE update_order_status(p_ORDERID IN INTEGER);
   PROCEDURE purchase_artwork(p_ARTWORKID IN INTEGER, p_user_id IN INTEGER);
END manage_orders;
/

CREATE OR REPLACE PACKAGE BODY manage_orders AS
   PROCEDURE update_order_status(p_ORDERID IN INTEGER) IS
   BEGIN
      UPDATE orders
      SET shippingstatus = 'shipped', orderstatus = 'placed', orderdatetime = SYSDATE
      WHERE ORDERID = p_ORDERID;
   END update_order_status;
   
   PROCEDURE purchase_artwork(p_ARTWORKID IN INTEGER,p_user_id in INTEGER) IS
      v_ORDERID orders.orderid%TYPE;
      v_shipper_id orders.shipperid%TYPE := TO_NUMBER(DBMS_RANDOM.VALUE(1, 10));
      v_trans_id orders.transactionid%TYPE := TRUNC(DBMS_RANDOM.VALUE(100000000000, 999999999999));
      v_trans_method orders.transactionmethod%TYPE := 'credit card';
      v_trans_status orders.transactionstatus%TYPE := 'complete';
      v_shipping_status orders.shippingstatus%TYPE := 'preparing to be shipped';
      v_order_status orders.orderstatus%TYPE := 'confirmed';
      v_shipping_address orders.shippingaddress%TYPE := '123 Main St, Anytown USA';
      v_orderdate orders.orderdatetime%TYPE := SYSDATE;
      v_amount orders.totalamount%TYPE;
      l_order_items_id order_items.orderitemsid%TYPE; -- Declare l_order_items_id variable
   BEGIN
   
      -- Get the artwork amount
      SELECT amount INTO v_amount
      FROM artwork
      WHERE ARTWORKID = p_ARTWORKID;
      
      -- Insert a new row into the orders table
      INSERT INTO orders(orderid, userid, shipperid, transactionid, transactionmethod, transactionstatus, orderstatus, shippingstatus, shippingaddress, orderdatetime, totalamount)
      VALUES(orders_seq.nextval, p_user_id, v_shipper_id, v_trans_id, v_trans_method, v_trans_status, v_order_status, v_shipping_status, v_shipping_address, SYSDATE, v_amount)
      RETURNING orderid INTO v_ORDERID;
      
      -- Update the artwork status to "sold"
      UPDATE artwork
      SET status = 'sold'
      WHERE ARTWORKID = p_ARTWORKID;
      
      -- Get the artwork amount
      SELECT amount INTO v_amount
      FROM artwork
      WHERE ARTWORKID = p_ARTWORKID;
      
      -- Insert a new row into the order_items table
      SELECT order_items_seq.nextval INTO l_order_items_id FROM dual;
      
      INSERT INTO order_items(orderitemsid, orderid)
      VALUES(l_order_items_id, v_ORDERID);
      
      -- Update the order's total amount
      UPDATE orders
      SET totalamount = v_amount
      WHERE orderid = v_ORDERID;
   END purchase_artwork;
END manage_orders;
/



