from pymongo import MongoClient


client = MongoClient(port=27017)
db=client.sample
col = db.MyFirstCollection

print("Returns object by identifier")
ids = input('>>>')

result = col.find({"name": "somename" + ids})
for i in result:
	print(i)


