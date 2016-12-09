public int z = 0;

public void main{
	int x = 1;
	<: The use expression acts as a function
	   that gets the given variables (here x) as argument
	   and then it immediately runs.
	  
	:>
	int y = x -> {
		x = 2;
		z = 1;
		return x;
	};
	y == 2;
	
	<: The use expression does not affect its immediate scope.
		But, it does effect its immediate scope's super scope.
	:>
	x == 1;
	z == 1;
	
	<: If the arguments change, y is not affected:>
	x = 1;
	y == 2;
};


