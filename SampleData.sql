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
('Casual Shirt', 'A comfortable casual shirt.', 29.99, 50, 'M', 1),
('Formal Pants', 'Stylish formal pants.', 49.99, 30, 'L', 2),
('Leather Belt', 'Genuine leather belt.', 19.99, 100, NULL, 3);

-- Insert sample data into Store
INSERT INTO Store (Location, Name)
VALUES 
('Downtown', 'Urban Outfitters'),
('Uptown', 'Chic Fashion');

-- Insert sample data into StoreInventory
INSERT INTO StoreInventory (StoreID, ProductID, StockQuantity)
VALUES 
(1, 1, 20), -- Downtown store has 20 Casual Shirts
(1, 2, 10), -- Downtown store has 10 Formal Pants
(2, 1, 30), -- Uptown store has 30 Casual Shirts
(2, 3, 50); -- Uptown store has 50 Leather Belts

-- Insert sample data into Order
INSERT INTO `Order` (OrderDate, ArrivalDate, ProductID, CustomerID)
VALUES 
('2023-08-01', '2023-08-05', 1, 1), -- John Doe ordered a Casual Shirt
('2023-09-10', '2023-09-15', 2, 2), -- Jane Smith ordered Formal Pants
('2023-10-20', '2023-10-25', 3, 3); -- Alice Johnson ordered a Leather Belt

-- Insert sample data into Payment
INSERT INTO Payment (Amount, PaymentMethod, OrderID, PaymentDate)
VALUES 
(29.99, 'Credit Card', 1, '2023-08-01'),
(49.99, 'PayPal', 2, '2023-09-10'),
(19.99, 'Debit Card', 3, '2023-10-20');
