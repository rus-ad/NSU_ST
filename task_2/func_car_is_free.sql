CREATE TYPE complex AS (
    date_diff interval,
    status_is_free varchar(128)
);


CREATE FUNCTION get_status_car(id varchar(128), input_date timestamp) 
RETURNS complex AS $$
DECLARE date_diff interval;
DECLARE status_is_free varchar(128);
BEGIN
	SELECT age(rent.date_till, input_date) INTO date_diff
	FROM car
	LEFT JOIN rent ON car.vin = rent.vin
	WHERE car.vin = $1;
	
	if date_diff > '00:00:00'::interval then
		SELECT 'Car is not free' INTO status_is_free;
	else
		SELECT 'Car is free' INTO status_is_free;
		SELECT '00:00:00' INTO date_diff;
	end if;
	RETURN (date_diff, status_is_free);
END;
$$ LANGUAGE PLpgSQL;


