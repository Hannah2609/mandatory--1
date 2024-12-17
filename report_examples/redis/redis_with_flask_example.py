from flask import Flask, session  # type: ignore
import redis # type: ignore
from datetime import time, timedelta
import json

app = Flask(__name__)
# Connect to Redis
redis_client = redis.Redis(host='localhost', port=6379, db=0)


## example of using redis to store active user session
@app.route('/login', methods=['POST'])
def login():
    # When user logs in
    user_id = "user1"
    # Store session in Redis
    session_data = {
        "user_id": user_id,
        "name": "A",
        "role": "customer",
        "last_access": time.time()
    }
    redis_client.setex(
        f"session:{user_id}", 
        timedelta(minutes=30),  # 30 minute expiration
        json.dumps(session_data)
    )
    return "Logged in"


@app.route('/get_user')
def get_user():
    # Get user session from Redis
    user_id = "user1"
    session = redis_client.get(f"session:{user_id}")
    if session:
        return json.loads(session)
    return "No session found"