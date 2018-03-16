# logistics-college-project


This is a logistics project to automate logistics management. This application alows customer to track their package status and it's location. It also provides an employee login portal where an employee can login and add packages and new users. This project is built on [flask](http://flask.pocoo.org/) for backend and [MySQL](https://www.mysql.com/) for DBMS.


## Requirements:

```
Python 3 
PIP
VirtualEnv: pip install virtualenv (Useful if you need to run multiple versions)
MySQL
```

## Instalation:

Create a new virtualenv and install application dependencies.

```
virtualenv <name>
<name>/bin/pip install -r requirements.txt
```

Make sure your MySQL server is up and running and import the MySQLdump (logistics.sql) to your MySQL database. 
Then run the development server:

```
<name>/bin/python run.py
```
The website will be up on:

http://127.0.0.1:8080/

http://127.0.0.1:8080/login

login using following credentials:

Username: USER_001
Password: asdfghjkl


### Links for templates:

[Home Page](https://freewebsitetemplates.com/preview/logistics/index.html)

[Login page](https://dribbble.com/shots/2385490--001-Sign-In-Page/attachments/459757)

PS - Let me know if you need me to add or remove something.
