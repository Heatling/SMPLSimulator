public void main{
	<:'y' (a reference to an integer) now refers to a new value '2':> 
	int y = 2;
	<:Create a pointer (to an integer) refered as 'x', that points to 'y':>
	@int x = @y;
	
	y == 2;
	$x == 2;
	
	<:Make 'x' point to the pointer of a new value '3':>
	x = @3;
	<:'y' now refers to the value x is pointing to:>
	y = $x;
	
	$x == 3;
	y == 3;
	
};