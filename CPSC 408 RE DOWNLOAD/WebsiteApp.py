from flask import Flask, render_template, request, redirect, url_for, jsonify
import importmysql as sql

app = Flask(__name__)

@app.route('/product/<int:product_id>')
def product_page(product_id):
    """
    Displays the product page dynamically based on ProductID.
    """
    cur_obj, conn = sql.establish_connection()
    
    # Updated SQL query to fetch product, inventory, and store details
    query = """
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
    WHERE p.ProductID = %s
    """

    cur_obj.execute(query, (product_id,))
    product_data = cur_obj.fetchall()

    # If no product data is found
    if not product_data:
        return "Product not found", 404

    # Building the product_info dictionary
    product_info = {
        "name": product_data[0]["ProductName"],
        "description": product_data[0]["Description"],
        "price": product_data[0]["Price"],
        "image_url": product_data[0]["ImageURL"],
        "sizes": list(set(row["Size"] for row in product_data)),  # Unique sizes
        "stores": [
            {
                "location": row["Location"],
                "size": row["Size"],
                "stock": row["StockQuantity"],
                "inventory_id": row["InventoryID"],
            }
            for row in product_data
        ]
    }

    # Close the database connection
    conn.close()

    # Render the product page with the retrieved product information
    return render_template('product.html', product=product_info)






# Helper function to execute queries
def execute_query(query, params=None, fetchone=False, fetchall=False):
    cur_obj, conn = sql.establish_connection()
    try:
        cur_obj.execute(query, params or ())
        if fetchone:
            return cur_obj.fetchone()
        if fetchall:
            return cur_obj.fetchall()
        conn.commit()
        return None
    finally:
        sql.close_connection(cur_obj, conn)

# Home Route
@app.route('/')
def home():
    """
    Displays the home page (Home.html) without any modifications.
    """
    return render_template('Home.html')



# Route for My Cart (MyCart.html)
@app.route('/MyCart')
def my_cart():
    """
    Renders the MyCart.html page.
    """
    return render_template('MyCart.html')

@app.route('/Checkout', methods=['POST'])
def checkout():
    if request.method == 'POST':
        try:
            # Fetch cart items from the frontend
            cart_items = request.get_json()
            print("Received cart items:", cart_items)  # Log for debugging
            if not cart_items:
                return jsonify({'error': 'No items in the cart!'}), 400

            # Establish database connection
            cur_obj, conn = sql.establish_connection()

            for item in cart_items:
                inventory_id = item.get('inventory_id')  # Ensure this is present

                if not inventory_id:
                    print("Missing inventory_id in item:", item)  # Debug log
                    return jsonify({'error': 'Incomplete item details!'}), 400

                # Debugging: Print the item details
                print(f"Processing item: InventoryID={inventory_id}")

                # Check stock availability
                cur_obj.execute(
                    "SELECT StockQuantity FROM StoreInventory WHERE InventoryID = %s",
                    (inventory_id,)
                )
                result = cur_obj.fetchone()
                if not result:
                    return jsonify({'error': f'InventoryID {inventory_id} not found!'}), 400
                if result['StockQuantity'] < 1:  # Check if at least 1 item is in stock
                    return jsonify({'error': f'Insufficient stock for item with InventoryID {inventory_id}!'}), 400

                # Add entry to Orders table first
                cur_obj.execute(
                    """
                    INSERT INTO Orders (OrderDate, ArrivalDate, ProductID, CustomerID)
                    VALUES (
                        CURDATE(), 
                        DATE_ADD(CURDATE(), INTERVAL 5 DAY), 
                        (SELECT ProductID FROM StoreInventory WHERE InventoryID = %s), 
                        1
                    )
                    """,
                    (inventory_id,)
                )

                # Reduce stock after successful order entry
                cur_obj.execute(
                    "UPDATE StoreInventory SET StockQuantity = StockQuantity - 1 WHERE InventoryID = %s",
                    (inventory_id,)
                )

            # Commit transaction
            conn.commit()
            return jsonify({'message': 'Checkout successful!'}), 200

        except Exception as e:
            # Rollback transaction in case of any failure
            conn.rollback()
            print(f"Error during checkout: {e}")  # Debugging log
            return jsonify({'error': 'Failed to process checkout!'}), 500

        finally:
            # Close the database connection
            sql.close_connection(cur_obj, conn)




if __name__ == '__main__':
    app.run(debug=True)














