CREATE VIEW free_cars
  AS SELECT model.name as modelName, model.drive, car.color, car.year, car.rate, brand.name as brand
     FROM car
     LEFT JOIN rent ON car.vin = rent.vin
     LEFT JOIN model ON car.model_id = model.model_id
     LEFT JOIN brand ON model.brand_id = brand.brand_id
     WHERE rent.date_till < now();
