psql -c '\x' -c "CREATE USER easycar WITH PASSWORD 'easycar';" && psql -c '\x' -c "select * from pg_shadow;"
psql -c '\x' -c "CREATE DATABASE easycar;"
psql -c '\x' -c "GRANT ALL ON DATABASE easycar TO easycar;" 
psql -f /home/laptop/tasks/ST/task_2/group_work.sql easycar
