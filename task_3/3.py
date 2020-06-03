from pymongo import MongoClient
from random import randint
from pprint import pprint

client = MongoClient(port=27017)
db=client.sample
col = db.MyFirstCollection

for x in col.find():
  print(x) 
