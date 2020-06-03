from pymongo import MongoClient
from random import randint
from pprint import pprint

client = MongoClient(port=27017)
db=client.sample

names = ['Kitchen','Animal','State', 'Tastey', 'Big','City','Fish', 'Pizza','Goat', 'Salty','Sandwich','Lazy', 'Fun']
company_type = ['LLC','Inc','Company','Corporation']
company_cuisine = ['Pizza', 'Bar Food', 'Fast Food', 'Italian', 'Mexican', 'American', 'Sushi Bar', 'Vegetarian']

for x in range(1, 501):
    business = {
        'name' : f"somename{x}",
        'rating' : randint(1, 5),
        'cuisine' : 2
    }
    result=db.MyFirstCollection.insert_one(business)
    print('Created {0} of 100 as {1}'.format(x,result.inserted_id))

print('finished creating 100 business reviews')
