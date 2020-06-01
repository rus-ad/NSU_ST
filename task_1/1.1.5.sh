mkdir -p d/log/l1
mkdir -p d/log/l2
split  -n 4 -d l1.log d/log/l1/
split  -n 4 -d l2.log d/log/l2/
