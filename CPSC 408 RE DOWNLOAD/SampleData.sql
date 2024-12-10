-- Active: 1733774513425@@127.0.0.1@3305@clothes
-- Insert sample data into Customer
INSERT INTO Customer (Name, Address, Email, Password, Phone, SignupDate, CardOnFile)
VALUES 
('John Doe', '123 Main St', 'johndoe@example.com', 'password123', '5551234567', '2023-01-15', 1),
('Jane Smith', '456 Elm St', 'janesmith@example.com', 'password456', '5559876543', '2023-03-20', 0),
('Alice Johnson', '789 Oak St', 'alicej@example.com', 'password789', '5554567890', '2023-07-05', 1);

-- Insert sample data into ProductCategory
INSERT INTO ProductCategory (Name)
VALUES 
('Shirts'),
('Pants'),
('Accessories');

-- Insert sample data into Product
INSERT INTO Product (Name, Description, Price, Stock, Size, CategoryID)
VALUES
('Women Shirt 1', 'A comfortable tank top.', 19.99, 100, 'M', 1), -- CategoryID 1 = Shirts
('Women Shirt 2', 'A stylish long sleeve t-shirt.', 29.99, 80, 'M', 1),
('Women Shirt 3', 'A classic t-shirt.', 39.99, 60, 'L', 1),
('Women Pant 1', 'Classic straight-leg pants.', 59.99, 50, 'S', 2), -- CategoryID 2 = Pants
('Women Pant 2', 'Foldover comfortable pants.', 69.99, 40, 'M', 2),
('Women Pant 3', 'Joggers for daily comfort.', 79.99, 30, 'L', 2),
('Men Shirt 1', 'Classic long sleeve t-shirt.', 79.99, 90, 'M', 1), -- CategoryID 1 = Shirts
('Men Shirt 2', 'Comfortable t-shirt for casual wear.', 89.99, 70, 'L', 1),
('Men Shirt 3', 'A hoodie perfect for cold weather.', 99.99, 50, 'L', 1),
('Men Pant 1', 'Classic shorts for summer.', 99.99, 40, 'M', 2), -- CategoryID 2 = Pants
('Men Pant 2', 'Straight-leg pants with a modern fit.', 109.99, 30, 'M', 2),
('Men Pant 3', 'Oversized pants for comfort.', 119.99, 20, 'L', 2);



-- Insert sample data into Store
INSERT INTO Store (Location, Name)
VALUES 
('Downtown', 'Urban Outfitters'),
('Uptown', 'Chic Fashion');



-- Insert sample data into Order
INSERT INTO Orders (OrderDate, ArrivalDate, ProductID, CustomerID)
VALUES
('2023-12-01', '2023-12-05', 1, 1), -- Customer 1 ordered ProductID 1 (Women Shirt 1)
('2023-12-02', '2023-12-06', 4, 2), -- Customer 2 ordered ProductID 4 (Women Pant 1)
('2023-12-03', '2023-12-07', 8, 3), -- Customer 3 ordered ProductID 8 (Men Shirt 2)
('2023-12-04', '2023-12-08', 9, 1); -- Customer 1 ordered ProductID 9 (Men Shirt 3)


-- Insert sample data into Payment
INSERT INTO Payment (Amount, PaymentMethod, OrderID, PaymentDate)
VALUES 
(29.99, 'Credit Card', 1, '2023-08-01'),
(49.99, 'PayPal', 2, '2023-09-10'),
(19.99, 'Debit Card', 3, '2023-10-20');



SET FOREIGN_KEY_CHECKS = 1;

-- Delete all existing rows from the Product table
DELETE FROM Product;

-- Reset the auto-increment counter
ALTER TABLE Product AUTO_INCREMENT = 1;

-- Insert updated product data
INSERT INTO Product (Name, Description, Price, Stock, Size, CategoryID, ImageURL)
VALUES
-- Women's Shirts
('Women Shirt 1', 'A comfortable tank top.', 19.99, 100, 'M', 1, '/static/images/women_shirt_1.png'),
('Women Shirt 2', 'A stylish long sleeve t-shirt.', 29.99, 80, 'M', 1, '/static/images/women_shirt_2.png'),
('Women Shirt 3', 'A classic t-shirt.', 39.99, 60, 'L', 1, '/static/images/women_shirt_3.png')

INSERT INTO Product (Name, Description, Price, Stock, Size, CategoryID, ImageURL)
VALUES
('Women Pant 1', 'Classic straight-leg pants.', 59.99, 50, 'S', 2, '/static/images/women_pant_1.png'),
('Women Pant 2', 'Foldover comfortable pants.', 69.99, 40, 'M', 2, '/static/images/women_pant_2.png'),
('Women Pant 3', 'Joggers for daily comfort.', 79.99, 30, 'L', 2, '/static/images/women_pant_3.png')

INSERT INTO Product (Name, Description, Price, Stock, Size, CategoryID, ImageURL)
VALUES
('Men Shirt 1', 'Classic long sleeve t-shirt.', 79.99, 90, 'M', 1, '/static/images/men_shirt_1.png'),
('Men Shirt 2', 'Classic t-shirt.', 89.99, 80, 'L', 1, '/static/images/men_shirt_2.png'),
('Men Shirt 3', 'Classic hoodie.', 99.99, 70, 'L', 1, '/static/images/men_shirt_3.png')

INSERT INTO Product (Name, Description, Price, Stock, Size, CategoryID, ImageURL)
VALUES
('Men Pant 1', 'Classic shorts.', 99.99, 60, 'M', 2, '/static/images/men_pant_1.png'),
('Men Pant 2', 'Classic straight-leg pants.', 109.99, 50, 'L', 2, '/static/images/men_pant_2.png'),
('Men Pant 3', 'Oversized pants.', 119.99, 40, 'L', 2, '/static/images/men_pant_3.png');



ALTER TABLE StoreInventory
ADD Size VARCHAR(10) NOT NULL;

ALTER TABLE Product
DROP COLUMN Size;

-- Insert StoreInventory data with sizes for all products
INSERT INTO StoreInventory (StoreID, ProductID, Size, StockQuantity)
VALUES
    -- Women Shirts
    (1, 1, 'S', 10), -- Downtown store, Women Shirt 1, Size Small
    (1, 1, 'M', 15), -- Downtown store, Women Shirt 1, Size Medium
    (1, 1, 'L', 20), -- Downtown store, Women Shirt 1, Size Large
    (2, 1, 'S', 5),  -- Uptown store, Women Shirt 1, Size Small
    (2, 1, 'M', 10), -- Uptown store, Women Shirt 1, Size Medium
    (2, 1, 'L', 15), -- Uptown store, Women Shirt 1, Size Large
    (1, 2, 'S', 8),  -- Downtown store, Women Shirt 2, Size Small
    (1, 2, 'M', 12), -- Downtown store, Women Shirt 2, Size Medium
    (1, 2, 'L', 18), -- Downtown store, Women Shirt 2, Size Large
    (2, 2, 'S', 6),  -- Uptown store, Women Shirt 2, Size Small
    (2, 2, 'M', 9),  -- Uptown store, Women Shirt 2, Size Medium
    (2, 2, 'L', 12), -- Uptown store, Women Shirt 2, Size Large
    (1, 3, 'S', 5),  -- Downtown store, Women Shirt 3, Size Small
    (1, 3, 'M', 10), -- Downtown store, Women Shirt 3, Size Medium
    (1, 3, 'L', 15), -- Downtown store, Women Shirt 3, Size Large
    (2, 3, 'S', 4),  -- Uptown store, Women Shirt 3, Size Small
    (2, 3, 'M', 7),  -- Uptown store, Women Shirt 3, Size Medium
    (2, 3, 'L', 9),  -- Uptown store, Women Shirt 3, Size Large
    (1, 4, 'S', 6),  -- Downtown store, Women Pant 1, Size Small
    (1, 4, 'M', 8),  -- Downtown store, Women Pant 1, Size Medium
    (1, 4, 'L', 10), -- Downtown store, Women Pant 1, Size Large
    (2, 4, 'S', 3),  -- Uptown store, Women Pant 1, Size Small
    (2, 4, 'M', 5),  -- Uptown store, Women Pant 1, Size Medium
    (2, 4, 'L', 8),  -- Uptown store, Women Pant 1, Size Large
    (1, 5, 'S', 7),  -- Downtown store, Women Pant 2, Size Small
    (1, 5, 'M', 12), -- Downtown store, Women Pant 2, Size Medium
    (1, 5, 'L', 14), -- Downtown store, Women Pant 2, Size Large
    (2, 5, 'S', 4),  -- Uptown store, Women Pant 2, Size Small
    (2, 5, 'M', 8),  -- Uptown store, Women Pant 2, Size Medium
    (2, 5, 'L', 10), -- Uptown store, Women Pant 2, Size Large
    (1, 6, 'S', 5),  -- Downtown store, Women Pant 3, Size Small
    (1, 6, 'M', 9),  -- Downtown store, Women Pant 3, Size Medium
    (1, 6, 'L', 11), -- Downtown store, Women Pant 3, Size Large
    (2, 6, 'S', 3),  -- Uptown store, Women Pant 3, Size Small
    (2, 6, 'M', 6),  -- Uptown store, Women Pant 3, Size Medium
    (2, 6, 'L', 8),  -- Uptown store, Women Pant 3, Size Large
    (1, 7, 'S', 12), -- Downtown store, Men Shirt 1, Size Small
    (1, 7, 'M', 18), -- Downtown store, Men Shirt 1, Size Medium
    (1, 7, 'L', 20), -- Downtown store, Men Shirt 1, Size Large
    (2, 7, 'S', 8),  -- Uptown store, Men Shirt 1, Size Small
    (2, 7, 'M', 14), -- Uptown store, Men Shirt 1, Size Medium
    (2, 7, 'L', 16), -- Uptown store, Men Shirt 1, Size Large
    (1, 8, 'S', 10), -- Downtown store, Men Shirt 2, Size Small
    (1, 8, 'M', 15), -- Downtown store, Men Shirt 2, Size Medium
    (1, 8, 'L', 18), -- Downtown store, Men Shirt 2, Size Large
    (2, 8, 'S', 6),  -- Uptown store, Men Shirt 2, Size Small
    (2, 8, 'M', 10), -- Uptown store, Men Shirt 2, Size Medium
    (2, 8, 'L', 12), -- Uptown store, Men Shirt 2, Size Large
    (1, 9, 'S', 9),  -- Downtown store, Men Shirt 3, Size Small
    (1, 9, 'M', 14), -- Downtown store, Men Shirt 3, Size Medium
    (1, 9, 'L', 19), -- Downtown store, Men Shirt 3, Size Large
    (2, 9, 'S', 5),  -- Uptown store, Men Shirt 3, Size Small
    (2, 9, 'M', 9),  -- Uptown store, Men Shirt 3, Size Medium
    (2, 9, 'L', 11), -- Uptown store, Men Shirt 3, Size Large
    (1, 10, 'S', 8), -- Downtown store, Men Pant 1, Size Small
    (1, 10, 'M', 14), -- Downtown store, Men Pant 1, Size Medium
    (1, 10, 'L', 18), -- Downtown store, Men Pant 1, Size Large
    (2, 10, 'S', 6),  -- Uptown store, Men Pant 1, Size Small
    (2, 10, 'M', 10), -- Uptown store, Men Pant 1, Size Medium
    (2, 10, 'L', 14); -- Uptown store, Men Pant 1, Size Large




SELECT 
    p.Name AS ProductName, 
    p.Description, 
    p.Price, 
    p.ImageURL,  
    si.InventoryID,
    si.Size, 
    si.StockQuantity, 
    s.Name AS Location
    FROM Product p
    JOIN StoreInventory si ON p.ProductID = si.ProductID
    JOIN Store s ON si.StoreID = s.StoreID
    WHERE p.ProductID = 1