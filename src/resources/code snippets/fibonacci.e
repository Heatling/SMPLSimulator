public ((@string)[] args) -> int main{
	int k = (int) <- args[0];
	
	if(k < 0){
		return -1;
	}	
	switch k {
		0:
		1: return k;
	}
	
	return main(k-1) + main(k-2);
};






