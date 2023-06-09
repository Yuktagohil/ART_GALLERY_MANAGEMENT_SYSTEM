SET SERVEROUTPUT ON;

EXECUTE ART_GALLERY_APP_ADMIN1.INSERT_ORDER(NULL, 8, 3, 947237582494, 'Credit Card', 'Success', 'Processing', 'Pending', '123 Main Street', SYSDATE, 100.50);
EXECUTE ART_GALLERY_APP_ADMIN1.VIEW_ORDERS;
EXECUTE ART_GALLERY_APP_ADMIN1.VIEW_ART_CATEGORY;
Execute ART_GALLERY_APP_ADMIN1.VIEW_ORDER_ITEMS;
Execute ART_GALLERY_APP_ADMIN1.INSERT_ORDER_ITEM(NULL,25);
EXECUTE ART_GALLERY_APP_ADMIN1.INSERT_USER(3, 'lovepizza.75@example.com', 'johndoe', 'password', 'John', 'Doe', 'Software Developer', 'USA');
EXECUTE ART_GALLERY_APP_ADMIN1.UPDATE_USER(33, 3, 'lovepizza.75@example.com', 'newusername', 'newpassword', 'New', 'User', 'Specialty', 'Nationality');
EXECUTE ART_GALLERY_APP_ADMIN1.view_users_details;
EXECUTE ART_GALLERY_APP_ADMIN1.INSERT_CONTACT(2,'8887703560','BOSTON','Westborough','BOSTON','MA','USA','03214');
EXECUTE ART_GALLERY_APP_ADMIN1.UPDATE_CONTACT(7,7,'8456280084','BOSTON','Natick','BOSTON','MA','USA','03214');
EXECUTE ART_GALLERY_APP_ADMIN1.VIEW_CONTACTS;
EXECUTE ART_GALLERY_APP_ADMIN1.VIEW_EXHIBITIONS;
EXECUTE ART_GALLERY_APP_ADMIN1.VIEW_ARTWORKS;

SELECT * FROM ART_GALLERY_APP_ADMIN1.CUSTOMER_ORDER;
SELECT * FROM ART_GALLERY_APP_ADMIN1.GALLERY_ARTWORK_INFO;
SELECT * FROM ART_GALLERY_APP_ADMIN1.ORDER_SHIPPER_INFO;
SELECT * FROM ART_GALLERY_APP_ADMIN1.ACTIVE_EXHIBITION_ARTWORK;
SELECT * FROM ART_GALLERY_APP_ADMIN1.ALL_ACTIVE_EXHIBITIONS;

DECLARE
  v_result VARCHAR2(4000);
BEGIN
  v_result := ART_GALLERY_APP_ADMIN1.purchase_artwork(p_UserID => 11, p_ArtworkID => 53);
  DBMS_OUTPUT.PUT_LINE('Purchase result: ' || v_result);
END;
/

EXECUTE ART_GALLERY_APP_ADMIN1.MANAGE_ARTWORKS.search_artworks_by_category('Painting');
EXECUTE ART_GALLERY_APP_ADMIN1.MANAGE_ORDERS.purchase_artwork(67,8);

