BEGIN
EXECUTE IMMEDIATE 'DROP PACKAGE artist_actions_pkg';
dbms_output.put_line('Objects dropped');
EXCEPTION
WHEN OTHERS
THEN dbms_output.put_line('Objects not found');
END;
/


--Package for artist actions
CREATE OR REPLACE PACKAGE artist_actions_pkg AS

-- Procedure to add artwork
PROCEDURE add_artwork (
  p_user_id IN NUMBER,
  p_art_category_id IN NUMBER,
  p_exhibition_id IN NUMBER,
  p_order_items_id IN NUMBER,
  p_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_amount IN NUMBER,
  p_status IN VARCHAR2,
  p_artwork_image IN BLOB
);

-- Procedure to update artwork
PROCEDURE update_artwork (
  p_artwork_id IN NUMBER,
  p_user_id IN NUMBER,
  p_art_category_id IN NUMBER,
  p_exhibition_id IN NUMBER,
  p_order_items_id IN NUMBER,
  p_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_amount IN NUMBER,
  p_status IN VARCHAR2,
  p_artwork_image IN BLOB
);

-- Procedure to delete artwork
PROCEDURE delete_artwork (
  p_artwork_id IN NUMBER
);

END artist_actions_pkg;
/

CREATE OR REPLACE PACKAGE BODY artist_actions_pkg AS

-- Procedure to add artwork
PROCEDURE add_artwork (
  p_user_id IN NUMBER,
  p_art_category_id IN NUMBER,
  p_exhibition_id IN NUMBER,
  p_order_items_id IN NUMBER,
  p_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_amount IN NUMBER,
  p_status IN VARCHAR2,
  p_artwork_image IN BLOB
) AS
BEGIN
  IF p_user_id IS NULL OR p_art_category_id IS NULL OR p_name IS NULL OR p_amount IS NULL OR p_status IS NULL THEN
    RAISE_APPLICATION_ERROR(-20000, 'One or more required parameters are null');
  END IF;

  INSERT INTO ARTWORK (
    ArtworkID,
    UserID,
    ArtCategoryID,
    ExhibitionID,
    OrderItemsID,
    Name,
    Description,
    Amount,
    Status,
    ArtworkImage
  ) VALUES (
    artwork_seq.NEXTVAL,
    p_user_id,
    p_art_category_id,
    p_exhibition_id,
    p_order_items_id,
    p_name,
    p_description,
    p_amount,
    p_status,
    p_artwork_image
  );
END add_artwork;

-- Procedure to update artwork
PROCEDURE update_artwork (
  p_artwork_id IN NUMBER,
  p_user_id IN NUMBER,
  p_art_category_id IN NUMBER,
  p_exhibition_id IN NUMBER,
  p_order_items_id IN NUMBER,
  p_name IN VARCHAR2,
  p_description IN VARCHAR2,
  p_amount IN NUMBER,
  p_status IN VARCHAR2,
  p_artwork_image IN BLOB
) AS
  l_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO l_count FROM ARTWORK WHERE ArtworkID = p_artwork_id;

  IF l_count = 0 THEN
    RAISE_APPLICATION_ERROR(-20001, 'Artwork does not exist');
  END IF;

  UPDATE ARTWORK SET
    UserID = p_user_id,
    ArtCategoryID = p_art_category_id,
    ExhibitionID = p_exhibition_id,
    OrderItemsID = p_order_items_id,
    Name = p_name,
    Description = p_description,
    Amount = p_amount,
    Status = p_status,
    ArtworkImage = p_artwork_image
  WHERE ArtworkID = p_artwork_id;
END update_artwork;

-- Procedure to delete artwork
PROCEDURE delete_artwork (
  p_artwork_id IN NUMBER
) AS
  l_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO l_count FROM ARTWORK WHERE ArtworkID = p_artwork_id;

  IF l_count = 0
  THEN
    RAISE_APPLICATION_ERROR(-20000, 'Artwork not found');
  END IF;

  DELETE FROM ARTWORK WHERE ArtworkID = p_artwork_id;
END delete_artwork;
END artist_actions_pkg;
/






-- Test case for add_artwork procedure when required parameters are null
BEGIN
  artist_actions_pkg.add_artwork(8, 1, 1, 1, 'Artwork Name', 'Artwork Description', 100, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -20000 THEN
        DBMS_OUTPUT.PUT_LINE('Test passed: Required parameters cannot be null');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Test failed: Unexpected error occurred');
      END IF;
END;
/
-- Test case for add_artwork procedure with valid input
DECLARE
  l_artwork_id NUMBER;
BEGIN
  artist_actions_pkg.add_artwork(1, 1, 1, 1, 'Artwork Name', 'Artwork Description', 100, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
  SELECT MAX(ArtworkID) INTO l_artwork_id FROM ARTWORK;
  DBMS_OUTPUT.PUT_LINE('Added Artwork ID: ' || l_artwork_id);
  DBMS_OUTPUT.PUT_LINE('Test passed: Artwork added successfully');
END;
/
-- Test case for update_artwork procedure with invalid artwork ID
BEGIN
  artist_actions_pkg.update_artwork(999, 1, 1, 1, 1, 'Artwork Name', 'Artwork Description', 100, 'Available', utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp'));
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -20001 THEN
        DBMS_OUTPUT.PUT_LINE('Test passed: Artwork does not exist');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Test failed: Unexpected error occurred');
      END IF;
END;
/
-- Test case for update_artwork procedure with valid input
DECLARE
  l_artwork_id NUMBER;
BEGIN
  artist_actions_pkg.update_artwork(
    p_artwork_id => 11,
    p_user_id => 2,
    p_art_category_id => 3,
    p_exhibition_id => null,
    p_order_items_id => 5,
    p_name => 'Test Artwork 2 Updated Again',
    p_description => 'This is a test artwork updated once more',
    p_amount => 500,
    p_status => 'Sold',
    p_artwork_image => utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/new_image.webp')
  );
  
  SELECT ArtworkID INTO l_artwork_id FROM Artwork WHERE ArtworkID = 11;
  DBMS_OUTPUT.PUT_LINE('Test passed: Artwork updated successfully');
  DBMS_OUTPUT.PUT_LINE('Updated Artwork ID: ' || l_artwork_id);
END;
/ 

-- Test case for delete_artwork procedure with invalid artwork ID
BEGIN
  artist_actions_pkg.delete_artwork(999);
  EXCEPTION
    WHEN OTHERS THEN
      IF SQLCODE = -20000 THEN
        DBMS_OUTPUT.PUT_LINE('Test passed: Artwork not found');
      ELSE
        DBMS_OUTPUT.PUT_LINE('Test failed: Unexpected error occurred');
      END IF;
END;
/
-- Test case for delete_artwork procedure with valid input
DECLARE
  l_artwork_id NUMBER := 86;
BEGIN
  artist_actions_pkg.delete_artwork(p_artwork_id => l_artwork_id);
  DBMS_OUTPUT.PUT_LINE('Deleted Artwork ID: ' || l_artwork_id);
  DBMS_OUTPUT.PUT_LINE('Test passed: Artwork deleted successfully');
END;
/





