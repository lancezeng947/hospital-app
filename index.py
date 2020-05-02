import pandas as pd
import numpy as np
from flask import Flask, request, jsonify, Response, render_template
import json
import mysql.connector
from flask_sqlalchemy import SQLAlchemy
from flask_bootstrap import Bootstrap
from flask_wtf import FlaskForm
from joblib import dump, load
import re


# specify database configurations
config = {
    'host': 'localhost',
    'port': 3306,
    'user': 'root',
    #lance
    #'password': 'mypass',
    #heqing
    'password': 'mypass',
    'database': 'hospital'
}

db_user = config.get('user')
db_pwd = config.get('password')


db_host = config.get('host')
db_port = config.get('port')
db_name = config.get('database')

# specify connection string
connection_str = f'mysql+pymysql://{db_user}:{db_pwd}@{db_host}:{db_port}/{db_name}'
print(connection_str)


app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = connection_str
db = SQLAlchemy(app)


@app.route("/")
def home():
  return render_template("homepage.html")

@app.route("/homepage.html")
def home_banner():
  return render_template("homepage.html")


@app.route("/patient_page.html")
def patient_page():
  return render_template("patiencepage.html")

@app.route("/doctor_page.html")
def doctor_page():
  return render_template("doctorpage.html")


@app.route("/pin.html", methods = ['GET', 'POST'])
def pin():
  user_name = request.form['username']
  phone_number = request.form['phone_num']
  result = db.engine.execute("SELECT CONCAT(first_name, ' ', last_name) AS name, phone_number FROM patients WHERE CONCAT(first_name, ' ', last_name) = %s AND phone_number = %s", (user_name, phone_number))
  result = result.fetchall()
  print(result)
  print(user_name)
  print(phone_number)
  # print(result[0][0])
  # print(result[0][0] == '')

  try:
     print(result[0][0])
  except:
    return render_template("patiencepage.html")

  if result[0][0] == ' ':
    return render_template("patiencepage.html")
  else:
    return render_template("pin0.html")
  print(result[0][0])
  print(result[0][0] == '')
  if result[0][0] == ' ':
    return render_template("patiencepage.html")
  else:
    return render_template("pin.html")


@app.route("/pprofile.html")
def pprofile():
  return render_template("pprofile.html")

@app.route("/precord.html")
def precord():
  return render_template("precord.html")

@app.route("/pdoc.html")
def pdoc():
  return render_template("pdoc.html")

@app.route("/pinsur.html")
def pinsur():
  return render_template("pinsur.html")

@app.route("/pmed.html")
def pmed():
  return render_template("pmed.html")

@app.route("/phos.html")
def phos():
  return render_template("phos.html")

@app.route("/nearbyhos.html")
def nearbyhos():
  return render_template("nearbyhos.html")

@app.route("/docrecommend.html")
def docrecommend():
  return render_template("docrecommend.html")

@app.route("/support.html")
def support():
  return render_template("support.html")

@app.route("/pin0.html")
def pin0():
  return render_template("pin0.html")


if __name__ == "__main__":
  app.run(host="0.0.0.0", debug=True)
