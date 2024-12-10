-- Active: 1733873316604@@127.0.0.1@3305


CREATE TABLE Customer (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Address VARCHAR(50) NOT NULL,
    Email VARCHAR(50) NOT NULL UNIQUE,
    Password VARCHAR(50) NOT NULL,
    Phone VARCHAR(15) NOT NULL,
    SignupDate DATE,
    CardOnFile INT
);

CREATE TABLE Payment (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    PaymentMethod VARCHAR(20) NOT NULL,
    OrderID INT NOT NULL,
    PaymentDate DATE
    # FOREIGN KEY (OrderID) REFERENCES Orders (OrderID)
);

ALTER TABLE Payment
ADD CONSTRAINT fk_order
FOREIGN KEY (OrderID)
REFERENCES Orders(OrderID);

CREATE TABLE Orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    OrderDate DATE NOT NULL,
    ArrivalDate DATE,
    ProductID INT NOT NULL,
    CustomerID INT NOT NULL
    #FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    # FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID)
);

ALTER TABLE Orders
ADD CONSTRAINT fk_orders_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
ADD CONSTRAINT fk_orders_customer FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID);

CREATE TABLE ProductCategory (
    CategoryID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL
);

CREATE TABLE Product (
    ProductID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Name VARCHAR(50) NOT NULL,
    Description TEXT,
    Price DECIMAL(10,2) NOT NULL,
    Stock INT NOT NULL,
    CategoryID INT NOT NULL
    # FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID)
);



#Delete this column
ALTER TABLE Product
ADD ImageURL VARCHAR(100);




ALTER TABLE Product
ADD CONSTRAINT fk_product_category FOREIGN KEY (CategoryID) REFERENCES ProductCategory(CategoryID);


CREATE TABLE StoreInventory (
    InventoryID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    StoreID INT NOT NULL,
    ProductID INT NOT NULL,
    StockQuantity INT NOT NULL
    Size VARCHAR(10) NOT NULL
    #FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
    #FOREIGN KEY (ProductID) REFERENCES Product(ProductID)
);


ALTER TABLE StoreInventory
ADD CONSTRAINT fk_store_inventory_store FOREIGN KEY (StoreID) REFERENCES Store(StoreID),
ADD CONSTRAINT fk_store_inventory_product FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

CREATE TABLE Store (
    StoreID INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    Location VARCHAR(255) NOT NULL,
    Name VARCHAR(50) NOT NULL
);
