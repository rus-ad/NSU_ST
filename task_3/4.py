from pymongo import MongoClient
from random import randint
from pprint import pprint
from math import ceil

client = MongoClient(port=27017)
db=client.sample
col = db.MyFirstCollection
items = col.count()
count_pages = ceil(items / 5)


def skiplimit(page_size, page_num):
	skips = page_size * (page_num - 1)
	cursor = col.find().skip(skips).limit(page_size)
	return [x for x in cursor]

pages = []
for num in range(1, count_pages + 1):
	pages.append(skiplimit(5, num))
	

for page in pages:
	print('='*15)
	print(page)
	print('='*15)
	



