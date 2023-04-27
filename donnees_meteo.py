import requests
from datetime import datetime, timedelta

now = datetime.now()
delta = now.hour % 3
if delta == 0:
    hour = now.hour
else:
    hour = now.hour - delta

date_time = now - timedelta(hours=delta)
date_str = date_time.strftime("%Y%m%d%H")

url = "https://donneespubliques.meteofrance.fr/donnees_libres/Txt/Synop/synop.{}.csv".format(date_str)
response = requests.get(url)

print (response.status_code)
# Si la requête échoue, on récupère le fichier .csv de la dernière heure multiple de 3 avant l'heure actuelle
while response.status_code != 200 or "Fichier non trouvé" in response.text :
    date_time = date_time - timedelta(hours=3)
    date_str = date_time.strftime("%Y%m%d%H")
    url = "https://donneespubliques.meteofrance.fr/donnees_libres/Txt/Synop/synop.{}.csv".format(date_str)
    print (url)
    response = requests.get(url)

    if date_time < datetime.strptime('2023-04-27 00:00:00', '%Y-%m-%d %H:%M:%S'):
        # Si on atteint cette date, on n'essaie plus de télécharger de fichier
        print("Aucun fichier disponible pour cette date.")
        break

if response.status_code == 200:
    with open("temperature.csv", "wb") as f:
        f.write(response.content)