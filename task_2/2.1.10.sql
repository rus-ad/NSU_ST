DELETE FROM client
WHERE client_id IN
    (SELECT client_id FROM 
        (SELECT client_id,
                ROW_NUMBER() OVER(PARTITION BY birthday ORDER BY client_id) AS bday,
                ROW_NUMBER() OVER(PARTITION BY firstName ORDER BY client_id) AS fName,
                ROW_NUMBER() OVER(PARTITION BY lastName ORDER BY client_id) AS lName
        FROM client) t
        WHERE t.bday > 1 and  t.fName > 1 and t.lName > 1);
