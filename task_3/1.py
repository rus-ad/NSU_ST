use sample  
show collections
db.createCollection( "MyFirstCollection", 
	{
		capped: true, 
		size : 280000, 
		max : 1000 
	}
)
show collections
