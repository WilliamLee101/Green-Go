import requests
from datetime import date

meals_time = ["breakfast", "lunch", "dinner"]
today = date.today()
URLs = {"marciano": "https://www.bu.edu/dining/location/marciano/#menu", "warren": "https://www.bu.edu/dining/location/warren/#menu", "west":"https://www.bu.edu/dining/location/west/#menu"}


# print(page.text)
from bs4 import BeautifulSoup
updated_menu = {}
updated_menu[str(today)] = {}
details = ["cals", "saturated fat", "carbs", "sugars", "proteins"]

for dining_hall in URLs.keys():
    URL = URLs[dining_hall]
    page = requests.get(URL)
    soup = BeautifulSoup(page.content, "html.parser")
    updated_menu[str(today)][dining_hall] = {}
    
    for meal_time in meals_time:
        id = str(today)+"-"+meal_time
        updated_menu[str(today)][dining_hall][meal_time] = {}
        results = soup.find(id=id)
        xs = results.find_all("li", class_="menu-item menu-main menu-has-warning")
        for x in xs:
            title = x.find("h4", class_="js-nutrition-open-alias menu-item-title").text
            updated_menu[str(today)][dining_hall][meal_time][title] = {}
            updated_menu[str(today)][dining_hall][meal_time][title]["item"] = title
            descripton = x.find("p", class_="menu-description")
            if descripton != None:
                descripton = descripton.text
                descripton = descripton.replace("\t\t\t\t", "")
                descripton = descripton.replace("\n\t\t\t\t\t", "")
                descripton = descripton.replace("\n\t", "")
                updated_menu[str(today)][dining_hall][meal_time][title]["description"] = descripton
            z = x.find("ul", class_="menu-nutrition-overview")
            if not z==None:
                for line in z:
                    line = line.text
                    for detail in details:
                        if detail in line:
                            updated_menu[str(today)][dining_hall][meal_time][title][detail]=line