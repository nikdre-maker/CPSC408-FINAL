from flask import Flask, render_template, request, redirect, url_for, jsonify
import importmysql as sql

app = Flask(__name__)

#displays product page dynamically
@app.route('/product/<int:product_id>')
def product_page(product_id):
    cur_obj, conn = sql.establish_connection()
    
    #sql query that fetches all relevant details 
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

    #error handling if no data found
    if not product_data:
        return "Product not found", 404

    #product_info dictionary used by frontend
    product_info = {
        "name": product_data[0]["ProductName"],
        "description": product_data[0]["Description"],
        "price": product_data[0]["Price"],
        "image_url": product_data[0]["ImageURL"],
        "sizes": list(set(row["Size"] for row in product_data)),  
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

    
    conn.close()

    #render product page based of info
    return render_template('product.html', product=product_info)






#helper function to execute queries
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

#home page
@app.route('/')
def home():
    return render_template('Home.html')



#mycart page
@app.route('/MyCart')
def my_cart():

    return render_template('MyCart.html')

#temporary checkout method 
@app.route('/Checkout', methods=['POST'])
def checkout():
    if request.method == 'POST':
        try:
            #fetch cart items from front en
            cart_items = request.get_json()
            if not cart_items:
                return jsonify({'error': 'No items in the cart!'}), 400

            cur_obj, conn = sql.establish_connection()

            for item in cart_items:
                inventory_id = item.get('inventory_id')  #debugging

                if not inventory_id:
                    print("Missing inventory_id in item:", item)  #debugging
                    return jsonify({'error': 'Incomplete item details!'}), 400

                #debugging
                print(f"Processing item: InventoryID={inventory_id}")

                #checingk stock availability
                cur_obj.execute(
                    "SELECT StockQuantity FROM StoreInventory WHERE InventoryID = %s",
                    (inventory_id,)
                )
                result = cur_obj.fetchone()
                if not result:
                    return jsonify({'error': f'InventoryID {inventory_id} not found!'}), 400
                if result['StockQuantity'] < 1:  #if not enough stock
                    return jsonify({'error': f'Insufficient stock for item with InventoryID {inventory_id}!'}), 400

                #add to orders
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

                #reduce stock
                cur_obj.execute(
                    "UPDATE StoreInventory SET StockQuantity = StockQuantity - 1 WHERE InventoryID = %s",
                    (inventory_id,)
                )

            
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


#checkout page



if __name__ == '__main__':
    app.run(debug=True)














