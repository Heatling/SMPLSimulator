public void main{
	int y = 2;
	@int pY = @y;
	@(int x) pX = @y;
	
	$pY == 2;
	x == 2;
	$pX == 2;
	
	$pX = 3;
	
	x == 3;
	y == 3;
	$pY == 3;
	
	x = 4;
	
	y == 3;
	$pY == 3;
	$pX == 4;
};





