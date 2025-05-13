WL = "EQ"
ENV = "DEV"  # DEV, UAT, PROD

configs = {
    "EQ_DEV": {
        "apiUrl": "https://dev2-operator-api.equix.app",
        "url": "https://dev2.equix.app/?wlb=equix",
        "urlPortal": "https://portal-equix-dev2.equix.app/login",
        "version": "v1",
        "username": "huyen.tran@equix.com.au",
        "password": "Cgsi#12345",
        "pin": "111111",
        "origin": "https://dev2.equix.app",
        "originAdminPortal": "https://portal-equix-dev2.equix.app",
        "environment": "equix",
        "userID": "eq1746774775099",
    },
    "EQ_UAT": {
        "apiUrl": "https://uat-operator-api.equix.app",
        "url": "https://uat.equix.app",
        "urlPortal": "https://portal-equix-uat.equix.app/login",
        "version": "v1",
        "username": "huyen.tran.eq@equix.com.au",
        "password": "Cgsi#12345",
        "pin": "111111",
        "origin": "https://uat.equix.app",
        "originAdminPortal": "https://portal-equix-uat.equix.app",
        "environment": "equix",
        "userID": "eq1746524237162",
    },
    "EQ_PROD": {
        "apiUrl": "https://operator-api.equix.app",
        "url": "https://web.equix.app",
        "urlPortal": "https://portal-equix.equix.app/login",
        "version": "v1",
        "username": "Od-operation-equix@equix.com.au",
        "password": "TeamOD123@hoangquocviet#",
        "pin": "628943",
        "origin": "https://www.equix.app",
        "originAdminPortal": "https://portal-equix.equix.app",
        "environment": "equix",
        "userID": "eq1727944631226",
    },
    "MO_UAT": {
        "apiUrl": "https://equix-uat-operator-api.equix.app",
        "url": "https://morrison-uat.equix.app/",
        "urlPortal": "https://portal-morrison-uat.equix.app/login",
        "version": "v1",
        "username": "huyen.tran.mo@equix.com.au",
        "password": "Cgsi#12345",
        "pin": "111111",
        "origin": "https://morrison-uat.equix.app/",
        "originAdminPortal": "https://portal-morrison-uat.equix.app",
        "environment": "morrison",
        "userID": "eq1746503935113",
    },
    "TFG_UAT": {
        "apiUrl": "https://equix-uat-operator-api.equix.app",
        "url": "https://tradeforgood-uat.equix.app/",
        "urlPortal": "https://portal-tradeforgood-uat.equix.app/login",
        "version": "v1",
        "username": "huyen.tran.tfg@equix.com.au",
        "password": "Cgsi#12345",
        "pin": "111111",
        "origin": "https://tradeforgood-uat.equix.app/",
        "originAdminPortal": "https://portal-tradeforgood-uat.equix.app",
        "environment": "morrison",
        "userID": "eq1746524586903",
    },
}


def get_config(wl, env):
    key = f"{wl.upper()}_{env.upper()}"
    if key not in configs:
        raise Exception(f"Config not found for {key}")
    return configs[key]


config = get_config(WL, ENV)

# Thuận tiện cho RF, tạo các biến individual
URL = config["url"]
URL_ADMIN_PORTAL = config["urlPortal"]
username = config["username"]
password = config["password"]
apiUrl = config["apiUrl"]
origin = config["origin"]
version = config["version"]
pin = config["pin"]
originAdminPortal = config["originAdminPortal"]
environment = config["environment"]
userID = config["userID"]
