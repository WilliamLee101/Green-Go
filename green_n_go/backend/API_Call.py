import requests
import datetime
import random

base_url = "https://www.bu.edu/dining/api/locations/"
dining_halls = ["marciano", "warren", "west"]
meal_groups = ["Breakfast", "Lunch", "Dinner"]

menu = {}

for i in range(7):
    NextDay_Date = datetime.datetime.today() + datetime.timedelta(days=i)
    NextDay_Date = NextDay_Date.strftime('%Y-%m-%d')
    menu[NextDay_Date] = {}
    for dining_hall in dining_halls:
        url = base_url + dining_hall + "/menu/" + NextDay_Date + "/"
        response = requests.get(url).json()
        menu[NextDay_Date][dining_hall] = {}
        for meal_group in meal_groups:
            if meal_group in response["meal_groups"].keys():
                menu[NextDay_Date][dining_hall][meal_group] = {}
                for station_index in range(len(response["meal_groups"][meal_group]["stations"])):
                    station_name = response["meal_groups"][meal_group]["stations"][station_index]["station_name"]
                    for index in range(len(response["meal_groups"][meal_group]["stations"][station_index]["menu_items"])):
                        name = response["meal_groups"][meal_group]["stations"][station_index]["menu_items"][index]["name"]
                        menu[NextDay_Date][dining_hall][meal_group][name] = {}
                        menu[NextDay_Date][dining_hall][meal_group][name]["item_name"] = name
                        menu[NextDay_Date][dining_hall][meal_group][name]["station_name"] = station_name
                        for key in response["meal_groups"][meal_group]["stations"][station_index]["menu_items"][index]:
                            try:
                                menu[NextDay_Date][dining_hall][meal_group][name][key] = int(response["meal_groups"][meal_group]["stations"][station_index]["menu_items"][index][key])
                            except ValueError: 
                                menu[NextDay_Date][dining_hall][meal_group][name][key] = response["meal_groups"][meal_group]["stations"][station_index]["menu_items"][index][key]
                            except TypeError:
                                menu[NextDay_Date][dining_hall][meal_group][name][key] = response["meal_groups"][meal_group]["stations"][station_index]["menu_items"][index][key]
                            
                            rating = random.uniform(0, 5)
                            rating = round(rating, 1)
                            menu[NextDay_Date][dining_hall][meal_group][name]["rating"] = rating
                            menu[NextDay_Date][dining_hall][meal_group][name]["num_rating"] = 0
                            menu[NextDay_Date][dining_hall][meal_group][name]["sum_rating"] = 0

