
CREATE TABLE orders (
    OrderID INTEGER(100) NOT NULL PRIMARY KEY,
    UserID INTEGER(100) NOT NULL,
    ShipperID INTEGER(100) NOT NULL,
    TransactionID INTEGER(100) NOT NULL,
    TransactionMethod VARCHAR(45) NOT NULL,
    TransactionStatus VARCHAR(45) NOT NULL,
    OrderStatus VARCHAR(45) NOT NULL,
    ShippingStatus VARCHAR(45) NOT NULL,
    ShippingAddress VARCHAR(45) NOT NULL,
    OrderTimeDate TIMESTAMP NOT NULL,
    TotalAmount INT NOT NULL,
    CONSTRAINT fk1 FOREIGN KEY (UserID)
        REFERENCES users (UserID),
    CONSTRAINT fk2 FOREIGN KEY (ShipperID)
        REFERENCES shipper (ShipperID)
);

CREATE TABLE order_items (
    OrderItemsID INTEGER(100) PRIMARY KEY,
    OrderID INTEGER(100) NOT NULL,
    FOREIGN KEY (OrderID)
        REFERENCES orders (OrderID)
);