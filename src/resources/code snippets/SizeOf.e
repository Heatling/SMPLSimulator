namespace CodeSnippets.SizeOf;

public int main{
	
	<|int x, int y|> point = <|1,1|>;
	
	int sizeOfPoint = #point;
	
	<:On 4byte word machines this would be true:>
	sizeOfPoint == 8;
};





