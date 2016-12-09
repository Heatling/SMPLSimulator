namespace CodeSnippets.ApproxEulersNumber;

public ((@string)[] args) -> int main{
	int k = (string) <- args[0];
	return (int) <- approximate_e(k);
};

(int k) -> float approximate_e{
	float result = 1;
	float result = 1;
	
	for(int i = 1; i<k; i++){
		factor *= i;
		result += 1.0/factor;
	}
	return result;
};