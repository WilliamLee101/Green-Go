import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Fetch the service account key JSON file contents
path_to_key = "/Users/williamlee/Desktop/Green-N-Go/Green-Go/green_n_go/backend/Firebase/greenngo-543b9-firebase-adminsdk-xkkor-23e3a96004.json"
cred = credentials.Certificate(path_to_key)
# Initialize the app with a service account, granting admin privileges
firebase_admin.initialize_app(cred, {
    'databaseURL': "https://greenngo-543b9-default-rtdb.firebaseio.com/"
})


from webscrapping import updated_menu
# print(updated_menu)

# #push and get
ref = db.reference("/")
ref.set({"updated_menu":updated_menu})
# print(ref.get("food"))

