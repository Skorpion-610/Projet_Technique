from peewee import *
from datetime import datetime

# Créer une connexion à la base de données MySQL
database = MySQLDatabase('TPFRANCKTHOMAS', user='fp', password='fp',host='localhost', port=3306)

# Définition du modèle de table
class Mesure(Model):
    id = AutoField()
    capteur = CharField()
    batterie = FloatField()
    temperature = FloatField()
    humidite = FloatField()
    date = DateTimeField(default=datetime.now)
        
    class Meta:
        database = database

database.connect()

# Créer les tables
database.create_tables([Mesure])