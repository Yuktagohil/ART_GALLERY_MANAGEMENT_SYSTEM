--testcases in user role table 
EXECUTE INSERT_USER_ROLE('JUDGES');
EXECUTE UPDATE_USER_ROLE(4,'Organizer');
EXECUTE DELETE_USER_ROLE(4);
EXECUTE VIEW_USER_ROLES;

--test cases in users table
EXECUTE INSERT_USER(1, 'john.doe@example.com', 'johndoe', 'password', 'John', 'Doe', 'Software Developer', 'USA');
EXECUTE UPDATE_USER(31, 1, 'john.doe@example.com', 'newusername', 'newpassword', 'New', 'User', 'Specialty', 'Nationality');
EXECUTE DELETE_USER(31);
EXECUTE view_users_details;

--testcases in contacts table
EXECUTE INSERT_CONTACT(2,'5849579873','BOSTON','MALDEN','BOSTON','MA','USA','03214');
EXECUTE UPDATE_CONTACT(6,6,'8835479990','BOSTON','MALDEN','BOSTON','MA','USA','03214');
EXECUTE DELETE_CONTACT(6,6);
EXECUTE VIEW_CONTACTS;

--testcase in shipper table
EXECUTE INSERT_SHIPPER('FEDEX', '9478889990', 'yuktabag@gmail.com');
EXECUTE UPDATE_SHIPPER(10, 'FEDEX', '7778816290', 'yuktabag@gmail.com');
EXECUTE DELETE_SHIPPER(8);
EXECUTE VIEW_SHIPPERS;

--test cases in online exhibition table
EXECUTE INSERT_EXHIBITION(2,TO_DATE('2023/12/02 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),TO_DATE('2023/12/06 14:02:44', 'yyyy/mm/ddhh24:mi:ss'),'Upcoming');
EXECUTE UPDATE_EXHIBITION(1,1,TO_DATE('2023-05-01 10:00:00', 'YYYY-MM-DD HH24:MI:SS'),TO_DATE('2023-05-05 18:00:00', 'yyyy/mm/ddhh24:mi:ss'),'Active');
EXECUTE DELETE_EXHIBITION(25);
EXECUTE VIEW_EXHIBITIONS;

--TEST CASES in orders table
EXECUTE INSERT_ORDER(NULL, '8', 3, 947237582494, 'Credit Card', 'Success', 'Processing', 'Pending', '123 Main Street', SYSDATE, 100.50);
EXECUTE update_order_status(26, 'Processing', 'Preparing to be shipped');
EXECUTE DELETE_ORDER(25);
EXECUTE VIEW_ORDERS;

--Test Cases in order items table
Execute INSERT_ORDER_ITEM(NULL,25);
Execute UPDATE_ORDER_ITEMS(11,24);
Execute DELETE_ORDER_ITEM(1,1);
Execute VIEW_ORDER_ITEMS;

--test cases in art category table
EXECUTE INSERT_ART_CATEGORY('Music');
EXECUTE UPDATE_ART_CATEGORY(11, 'Song');
EXECUTE DELETE_ART_CATEGORY(9);
EXECUTE VIEW_ART_CATEGORY;

--testcases in artwork table
EXECUTE INSERT_ARTWORK(2,2,8,2,'Blue rays','benevolent mass art',120,'Available',utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
EXECUTE UPDATE_ARTWORK(79,2,2,8,NULL,'Ray of Hope','good intensions',230,'Not Available',utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
EXECUTE DELETE_ARTWORK(78);
EXECUTE VIEW_ARTWORKS;

EXECUTE MANAGE_ARTWORKS.VIEW_ALL_ARTWORKS;

