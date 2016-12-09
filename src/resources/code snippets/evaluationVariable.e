public void main{
	int x = 2;
	final int sqrX{
		return x*x;
	};
	
	sqrX == 4;
	x = 3;
	sqrX == 9;
	
};