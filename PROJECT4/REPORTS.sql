--report to generate top 5 artist
WITH ranked_artists AS (
    SELECT u.userid AS artist_id, u.username AS artist_name, COUNT(DISTINCT a.artworkid) AS total_artworks_sold,
           DENSE_RANK() OVER (ORDER BY COUNT(DISTINCT a.artworkid) DESC) AS artist_rank
    FROM users u
    JOIN user_role ur ON u.roleid = ur.roleid
    JOIN artwork a ON u.userid = a.userid
    WHERE a.Status = 'Sold' AND ur.roleid = 2
    GROUP BY u.username, ur.rolename, u.userid
)
SELECT total_artworks_sold, artist_name, artist_id
FROM ranked_artists
WHERE artist_rank <= 5;