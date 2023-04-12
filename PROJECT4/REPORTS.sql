--Report for revenue generated by artist
SELECT TRUNC(o.OrderDateTime, 'MONTH') AS Month, SUM(o.TotalAmount) AS Revenue
FROM ORDERS o
JOIN ORDER_ITEMS oi ON o.OrderID = oi.OrderID
JOIN ARTWORK a ON oi.OrderItemsID = a.OrderItemsID
WHERE a.UserID = :artist_id
AND EXTRACT(YEAR FROM o.OrderDateTime) = :year
GROUP BY TRUNC(o.OrderDateTime, 'MONTH')
ORDER BY Month ASC;