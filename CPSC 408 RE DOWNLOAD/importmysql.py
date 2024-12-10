import mysql.connector

def establish_connection():
    conn = mysql.connector.connect(host="localhost",
                                user = "root",
                                    password = "CPSC408!", 
                                    auth_plugin = "mysql_native_password",
                                    database = "Clothes",
                                    port = 3305)


    cur_obj = conn.cursor(dictionary=True)

    return cur_obj, conn 

def close_connection(cur_obj, conn): 
    cur_obj.close()
    conn.close()



