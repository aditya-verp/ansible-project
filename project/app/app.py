from flask import Flask, jsonify
import psycopg2
import os

app = Flask(__name__)

def get_db_connection():
    conn = psycopg2.connect(
        host=os.environ['DB_HOST'],
        database=os.environ['DB_NAME'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD'],
        port=os.environ['DB_PORT']
    )
    return conn

@app.route('/')
def index():
    conn = None
    try:
        conn = get_db_connection()
        conn_status = "Successfully connected to PostgreSQL"
    except Exception as e:
        conn_status = f"Failed to connect to PostgreSQL: {e}"
    finally:
        if conn:
            conn.close()
    
    return f"""
    <html>
    <head>
        <title>Flask PostgreSQL App</title>
    </head>
    <body>
        <h1>Welcome to the Flask PostgreSQL App</h1>
        <p>{conn_status}</p>
    </body>
    </html>
    """

@app.route('/items', methods=['GET'])
def get_items():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute('SELECT * FROM items;')
    items = cur.fetchall()
    cur.close()
    conn.close()
    return jsonify(items)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=80)
