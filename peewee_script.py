from peewee import *

# Créer une connexion à la base de données MySQL
database = MySQLDatabase('TPFRANCKTHOMAS', user='fp', password='fp',host='localhost', port=3306)

# Créer une classe modèle pour chaque table
class TABLEFP(Model):
    # Les champs de la table
    Batterie = FloatField()
    Temperature = FloatField()
    Humidite = FloatField()

# Créer les tables dans la base de données
database.connect()
database.create_tables([TABLEFP])