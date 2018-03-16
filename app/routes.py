from app import app, render_template, request, url_for, redirect, session
from app.database import retrieve, insert
from flask_weasyprint import render_pdf
from flask_qrcode import QRcode

QRcode(app)
app.config.update(dict(
    UPLOAD_FOLDER='/Users/amoghg/Documents/app/app/uploads'))

error = ''
org_id = 1


# Routes to Home page
@app.route('/')
@app.route('/home')
def home():
    return render_template('index.html', title='Home')


# Routes to About page
@app.route('/about')
def about():
    return render_template('about.html', title='About')


# Routes to Contact page
@app.route('/contact')
def contact():
    return render_template('contact.html', title='Contact')


# Routes to Track page
@app.route('/track')
def track():
    error = request.args.get('error')
    return render_template('track.html', error=error, title='Track')


# Authentication route
@app.route('/authenticating', methods=['GET', 'POST'])
def authenticate():
    error = ''
    if request.method == 'POST':
        data = request.form
        tid = data['id']
        ret = retrieve()
        if ret.check_cust(tid):
            return redirect(url_for('success', tid=tid))
        else:
            error = "Invalid Tracking ID!"
            return redirect(url_for('track', title='Track', error=error))
    return redirect(url_for('track', title='Track', error=error))


# If the product is real this is opened
@app.route('/success')
def success():
    tid = request.args.get('tid')
    ret = retrieve()
    pdet = ret.disp_pdetails(tid)
    oaddr = ret.disp_oaddress(tid)
    daddr = ret.disp_daddress(tid)
    pr = ret.disp_priority(tid)
    if(pr[0] == 0):
        pr = 'NO'
    else:
        pr = 'YES'
    st = ret.disp_status(tid)
    if(st[0] == 0):
        st = 'IN TRANSIT'
    else:
        st = 'DELIVERED'
    le = ret.disp_levent(tid)
    return render_template('track_succ.html', tid=tid, title='Track',
                           pdet=pdet, oaddr=oaddr, daddr=daddr,
                           pr=pr, st=st, le=le)


@app.route('/login')
def login():
    if 'user' in session:
        return redirect(url_for('register'))
    else:
        error = request.args.get('error')
        return render_template('login.html', error=error)


@app.route('/submit', methods=['GET', 'POST'])
def submit():
    if request.method == 'POST':
        uid = request.form.get('id')
        ret = retrieve()
        if ret.check_password(uid, request.form.get('password')):
            session['user'] = uid
            session['super_user'] = ret.getsu(uid)
            session['name'] = ret.getname(uid)
            return redirect(url_for('register'))
        else:
            error = "Invalid credentials!"
            return redirect(url_for('login', title='Track', error=error))
    return redirect(url_for('login', title='Track', error="error"))


@app.route('/register')
def register():
    if 'user' in session:
        error = request.args.get('error')
        su = session['super_user']
        name = session['name']
        return render_template('register.html', error=error,
                               title="Register", su=su, name=name)
    else:
        return redirect(url_for('login', error='Please login to continue.'))


@app.route('/admin')
def admin():
    if 'user' in session and session['super_user'] == 1:
        message = request.args.get('error')
        name = session['name']
        return render_template('admin.html', error=message,
                               title='Admin', name=name)
    else:
        return redirect(url_for('login', error='Please login to continue.'))


@app.route('/logout')
def logout():
    session.pop('user', None)
    session.pop('super_user', None)
    session.pop('name', None)
    return redirect(url_for('login',
                            error="You've been successfully logged out."))


@app.route('/add_admin', methods=['GET', 'POST'])
def add_admin():
    if request.method == 'POST':
        data = request.form
        if data['password1'] == data['password2']:
            add = insert()
            x = add.add_admin(**data)
            if x:
                return redirect(url_for('admin', error="success"))
            else:
                return redirect(url_for('admin',
                                        error="Username already exist"))
        else:
            return redirect(url_for('admin',
                                    error="Passwords do not match"))


@app.route('/add_package', methods=['GET', 'POST'])
def add_package():
    if request.method == 'POST':
        data = request.form
        for i, j in data.items():
            if j:
                pass
            else:
                return redirect(url_for('register',
                                        error='All the fields are required!')
                                )
        add = insert()
        id = add.add_package(uid=session['user'], **data)
        return redirect(url_for('succ_reg', track_id=id))
    return redirect(url_for('register', error="Unsuccesfull"))


@app.route('/succ_reg')
def succ_reg():
    track_id = request.args.get('track_id')
    ret = retrieve()
    pdet = ret.disp_pdetails(track_id)
    oaddr = ret.disp_oaddress(track_id)
    daddr = ret.disp_daddress(track_id)
    return render_template('success.html', track_id=track_id,
                           pdet=pdet, oaddr=oaddr, daddr=daddr)


@app.route('/invoice', methods=['GET'])
def invoice():
    track_id = request.args.get('track_id')
    return render_pdf(url_for('printp', track_id=track_id))


@app.route('/print')
def printp():
    tid = request.args.get('track_id')
    ret = retrieve()
    pdet = ret.disp_pdetails(tid)
    oaddr = ret.disp_oaddress(tid)
    daddr = ret.disp_daddress(tid)
    return render_template('print.html', track_id=tid,
                           pdet=pdet, oaddr=oaddr, daddr=daddr)


@app.errorhandler(404)
def page_not_found(e):
    return render_template('404.html'), 404
