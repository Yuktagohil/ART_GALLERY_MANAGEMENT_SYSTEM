CREATE OR REPLACE PACKAGE artist_actions_pkg AS
  PROCEDURE add_artwork(
    p_user_id IN INTEGER,
    p_art_category_id IN INTEGER,
    p_name IN VARCHAR2,
    p_description IN VARCHAR2,
    p_amount IN NUMBER,
    p_artwork_image IN BLOB);
  PROCEDURE update_artwork(
    p_artwork_id IN INTEGER,
    p_name IN VARCHAR2,
    p_description IN VARCHAR2,
    p_amount IN NUMBER,
    p_artwork_image IN BLOB);
END artist_actions_pkg;
/

CREATE OR REPLACE PACKAGE BODY artist_actions_pkg AS
  PROCEDURE add_artwork(
    p_user_id IN INTEGER,
    p_art_category_id IN INTEGER,
    p_name IN VARCHAR2,
    p_description IN VARCHAR2,
    p_amount IN NUMBER,
    p_artwork_image IN BLOB)
  IS
  BEGIN
    INSERT INTO ARTWORK (
      ArtworkID,
      UserID,
      ArtCategoryID,
      Name,
      Description,
      Amount,
      Status,
      ArtworkImage
    )
    VALUES (
      artwork_seq.NEXTVAL,
      p_user_id,
      p_art_category_id,
      p_name,
      p_description,
      p_amount,
      'Available',
      p_artwork_image
    );
  END add_artwork;

  PROCEDURE update_artwork(
    p_artwork_id IN INTEGER,
    p_name IN VARCHAR2,
    p_description IN VARCHAR2,
    p_amount IN NUMBER,
    p_artwork_image IN BLOB)
  IS
  BEGIN
    UPDATE ARTWORK
    SET
      Name = p_name,
      Description = p_description,
      Amount = p_amount,
      ArtworkImage = p_artwork_image
    WHERE
      ArtworkID = p_artwork_id;
  END update_artwork;
END artist_actions_pkg;
/

--test case 1 : This test case tests the add_artwork procedure by inserting a new artwork and checking if the artwork ID is returned correctly.
DECLARE
  v_user_id INTEGER := 2;
  v_art_category_id INTEGER := 3;
  v_name VARCHAR2(100) := 'Nature';
  v_description VARCHAR2(500) := 'Butterfly.';
  v_amount NUMBER := 1000;
  v_artwork_image BLOB :=  utl_raw.cast_to_raw('Test Artwork Image');
  v_artwork_id INTEGER;
BEGIN
  artist_actions_pkg.add_artwork(
    p_user_id => v_user_id,
    p_art_category_id => v_art_category_id,
    p_name => v_name,
    p_description => v_description,
    p_amount => v_amount,
    p_artwork_image => v_artwork_image
  );

  SELECT ArtworkID INTO v_artwork_id FROM artwork WHERE Name = v_name AND RowNum = 1;
  IF v_artwork_id IS NOT NULL THEN
    DBMS_OUTPUT.PUT_LINE('Artwork inserted with ID ' || v_artwork_id);
  ELSE
    DBMS_OUTPUT.PUT_LINE('Artwork not inserted');
  END IF;
END;
/

-- Test Case 2: Update an existing artwork with valid parameters
DECLARE
  v_artwork_id INTEGER := 1;
  v_name VARCHAR2(100) := 'Updated Artwork';
  v_description VARCHAR2(500) := 'This artwork is updated.';
  v_amount NUMBER := 2000;
  v_artwork_image BLOB := utl_raw.cast_to_raw('/Users/bunny/DMDD_PROJECT/Images/tanner.webp');
  v_artwork_row artwork%ROWTYPE;
BEGIN
  -- Open the image file and read the content into the BLOB variable
  v_artwork_image := utl_raw.cast_to_raw('Updated Artwork Image');

  artist_actions_pkg.update_artwork(
    p_artwork_id => v_artwork_id,
    p_name => v_name,
    p_description => v_description,
    p_amount => v_amount,
    p_artwork_image => v_artwork_image
  );

  -- Check if the artwork is updated successfully
  SELECT * INTO v_artwork_row FROM artwork WHERE ArtworkID = v_artwork_id;
  DBMS_OUTPUT.PUT_LINE('Artwork ID: ' || v_artwork_row.ArtworkID);
  DBMS_OUTPUT.PUT_LINE('Artwork Name: ' || v_artwork_row.Name);
  DBMS_OUTPUT.PUT_LINE('Artwork Description: ' || v_artwork_row.Description);
  DBMS_OUTPUT.PUT_LINE('Artwork Amount: ' || v_artwork_row.Amount);
END;
/
