import sqlite3
from flask import Flask, request

app = Flask(__name__)

@app.route("/user")
def get_user():
    username = request.args.get("username")
    # 🚨 Vulnerable: directly concatenating user input into SQL query
    query = "SELECT * FROM users WHERE username = '" + username + "';"
    conn = sqlite3.connect("test.db")
    cursor = conn.cursor()
    cursor.execute(query)
    return str(cursor.fetchall())
