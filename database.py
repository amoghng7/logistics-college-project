from flask import Flask
from flaskext.mysql import MySQL
from flask_bcrypt import Bcrypt
import string
import random


def id_generator(size=7, chars=string.ascii_uppercase + string.digits):
    return ''.join(random.choice(chars) for _ in range(size))


app = Flask('__main__')
bcrypt = Bcrypt(app)
mysql = MySQL()
app.config['MYSQL_DATABASE_USER'] = 'root'
app.config['MYSQL_DATABASE_PASSWORD'] = 'root'
app.config['MYSQL_DATABASE_DB'] = 'logistics'
app.config['MYSQL_DATABASE_HOST'] = 'localhost'
mysql.init_app(app)

conn = mysql.connect()
cursor = conn.cursor()


class retrieve:
    'sql querries'
    tid = None

    def check_cust(self, tid):
        if(cursor.execute("select * from track where tid = '" + tid + "'")):
            data = cursor.fetchone()
            if data[0]:
                return True
            else:
                return False
        else:
            return False

    def check_password(self, uid, pw):
        if(cursor.execute("SELECT pass_hash FROM admin WHERE id = '" + str(uid) + "'")):
            pw_hash = cursor.fetchone()
            if(bcrypt.check_password_hash(pw_hash[0], pw)):
                return True
            else:
                return False
        else:
            return False

    def getsu(self, uid):
        cursor.execute(
            "SELECT is_superuser FROM admin WHERE id = '" + uid + "'")
        su = cursor.fetchone()[0]
        return(su)

    def getname(self, uid):
        cursor.execute("SELECT name FROM admin WHERE id = '" + uid + "'")
        name = cursor.fetchone()[0]
        return(name)

    def disp_pdetails(self, tid):
        cursor.execute(
            "SELECT p.details,p.type FROM package p,track t where tid = '" + tid + "' AND p.pid = t.pid")
        data = cursor.fetchone()
        return(data)

    def disp_oaddress(self, tid):
        cursor.execute("SELECT O.* FROM TRACK T, PACKAGE P, ORIGIN O WHERE TID = '" +
                       tid + "' AND P.PID = T.PID AND P.OID = O.OID")
        data = cursor.fetchone()
        data = data[1:8]
        return(data)

    def disp_daddress(self, tid):
        cursor.execute("SELECT D.* FROM TRACK T, PACKAGE P, DESTINATION D WHERE TID = '" +
                       tid + "' AND P.PID = T.PID AND P.DID = D.DID")
        data = cursor.fetchone()
        data = data[1:8]
        return(data)

    def disp_priority(self, tid):
        cursor.execute(
            "SELECT P.PRIORITY FROM TRACK T, PACKAGE P WHERE TID = '" + tid + "' AND P.PID = T.PID")
        data = cursor.fetchone()
        return(data)

    def disp_status(self, tid):
        cursor.execute("SELECT E._STATUS FROM TRACK T, PACKAGE P, CURR_EVENT E WHERE TID = '" +
                       tid + "' AND P.PID = T.PID AND E.EID = P.EID")
        data = cursor.fetchone()
        return(data)

    def disp_levent(self, tid):
        cursor.execute("SELECT E.LOCATION FROM TRACK T, PACKAGE P, CURR_EVENT E WHERE TID = '" +
                       tid + "' AND P.PID = T.PID AND E.EID = P.EID")
        data = cursor.fetchone()
        return(data)


class insert():
    def __init__(self):
        pass

    # Inserts value into admin
    def add_admin(self, *args, **data):
        try:
            id = data['user_name'][0]
            pw = str(data['password1'][0])
            pw_hash = bcrypt.generate_password_hash(pw).decode('utf-8')
            if data['su'][0] == 'True':
                su = 1
            else:
                su = 0
            args = [id, pw_hash, data['name'][0], data['location'][0], su]
            cursor.callproc('sp_addadmin', args)  # Calls stored procedure
            conn.commit()
            return True
        except():
            return False

    def add_package(self, uid, **data):
        # inserts into ORIGIN
        semail = data['semail'][0]
        cursor.execute("INSERT INTO ORIGIN VALUES(0,'%s' ,'%s', '%s', '%s', %s, '%s', '%s')" % (
            data['sname'][0], data['sadd'][0], data['scountry'][0], data['sstate'][0], data['spc'][0], data['sphone'][0], semail))
        cursor.execute("SELECT LAST_INSERT_ID()")
        oid = str(cursor.fetchone()[0])

        # inserts into DESTINATION
        demail = data['demail'][0]
        cursor.execute("INSERT INTO DESTINATION VALUES(0,'%s' ,'%s', '%s', '%s', %s, '%s', '%s')" % (
            data['dname'][0], data['dadd'][0], data['dcountry'][0], data['dstate'][0], data['dpc'][0], data['dphone'][0], demail))
        cursor.execute("SELECT LAST_INSERT_ID()")
        did = str(cursor.fetchone()[0])

        # inserts into CURR_EVENT
        cursor.execute("SELECT location FROM admin WHERE id = '%s'" % (uid))
        loc = cursor.fetchone()[0]
        cursor.execute(
            "INSERT INTO CURR_EVENT VALUES(0,'%s', '%s', NULL)" % (0, loc))
        cursor.execute("SELECT LAST_INSERT_ID()")
        eid = str(cursor.fetchone()[0])

        # inserts into PACKAGE
        cursor.execute("INSERT INTO PACKAGE VALUES(0,'%s', '%s', %s,%s, '%s', %s, '%s')" % (
            data['details'][0], data['type'][0], oid, did, data['via'][0], data['priority'][0], eid))
        cursor.execute("SELECT LAST_INSERT_ID()")
        pid = str(cursor.fetchone()[0])

        # inserts into TRACK
        id = id_generator()
        cursor.execute("INSERT INTO TRACK VALUES('%s' ,'','%s')" % (id, pid))

        # commit
        conn.commit()
        return id
