from flask import Flask, render_template, redirect, url_for, request, flash, session
from flask_bcrypt import Bcrypt

app = Flask(__name__)
bcrypt = Bcrypt(app)
app.secret_key = 'development key'
from app import routes
