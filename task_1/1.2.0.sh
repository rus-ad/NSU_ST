jq -r ".friends[]|{name, id:.id, know:.knows[], like:.music[]}|[.know, .name, .id]|@csv" dst-stu/d/friends.json  | sort -t, -u -k1,2 | awk -f csv-to-tree_for_1.2.0.awk > tre.dot
dot -Tjpeg tre.dot -o tre.jpeg && eog --fullscreen tre.jpeg
