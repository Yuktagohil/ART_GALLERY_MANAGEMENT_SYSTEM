--trigger to update artwork status 
CREATE OR REPLACE TRIGGER update_artwork_availability
AFTER UPDATE OF exhibitionstatus ON online_exhibition
FOR EACH ROW
DECLARE
    artwork_id artwork.artworkid%TYPE;
    artwork_status artwork.status%TYPE;
    v_msg varchar(100);
BEGIN
    IF (:OLD.ExhibitionStatus = 'Upcoming' AND :NEW.ExhibitionStatus = 'Active' AND :NEW.ExhibitionStartDateTime = SYSDATE) THEN
        UPDATE artwork SET status = 'Available' WHERE exhibitionid = :NEW.ExhibitionID;
    END IF;
    
    SELECT artworkid, status INTO artwork_id, artwork_status FROM artwork WHERE exhibitionid = :NEW.ExhibitionID;
    
    IF artwork_status = 'Available' AND artwork_status != 'Sold' AND SYSDATE > :NEW.ExhibitionEndDateTime THEN
        UPDATE artwork SET status = 'Not available' WHERE artworkid = artwork_id;
    ELSE
        v_msg := 'Artwork not updated because it is not available or it has already been sold';
    END IF;
END;
/

--check exhibition id when adding new artwork
CREATE OR REPLACE TRIGGER check_exhibition_dates
BEFORE INSERT ON ARTWORK
FOR EACH ROW
DECLARE
    exhibition_end_date DATE;
    v_msg varchar(100);
BEGIN
    SELECT ExhibitionEndDateTime INTO exhibition_end_date FROM ONLINE_EXHIBITION WHERE ExhibitionID = :NEW.ExhibitionID;
    
    IF exhibition_end_date < SYSDATE THEN
    v_msg := 'Cannot add artwork to an exhibition that has already ended.';
    END IF;
END;
/


