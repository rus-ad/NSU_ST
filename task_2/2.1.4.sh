psql -c '\x' -c "CREATE USER easycar WITH PASSWORD 'easycar';" && psql -c '\x' -c "select * from pg_shadow;"
