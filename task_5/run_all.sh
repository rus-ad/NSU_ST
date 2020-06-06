cat ./dst-stu/d/mr/tf-idf/* |python mapper.py | sort |python reducer.py > output.tsv
