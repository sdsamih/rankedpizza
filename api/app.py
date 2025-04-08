from flask import Flask
from db import init_db
from routes import api

app = Flask(__name__)
init_db(app)
app.register_blueprint(api)

if __name__ == '__main__':
    app.run(host ='0.0.0.0',port = 5000,debug=True)
