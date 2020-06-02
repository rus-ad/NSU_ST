CREATE FUNCTION get_cost_of_rent(id varchar(128), start_date timestamp, end_date timestamp) 
RETURNS float(8) AS $$
DECLARE cost_of_rent float(8);

BEGIN
	SELECT AVG(rent.sum) INTO cost_of_rent
	FROM car
	LEFT JOIN rent ON car.vin = rent.vin
	WHERE car.vin = $1 and rent.date_since >= $2 and rent.date_since >= $3;
	RETURN cost_of_rent;
END;
$$ LANGUAGE PLpgSQL;

