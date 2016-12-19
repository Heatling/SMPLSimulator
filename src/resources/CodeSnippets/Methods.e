namespace Methods;

type <|
		int first, 
		int size, 
		@(int[] array) pArray,
	|>
	Queue;
	
public Queue q : void -> bit isEmpty{
	return q.size == 0;
};

public Queue q : void -> bit isFull{
	return q.size == q.array[];
};

public Queue q : void -> <|int value, bit success|>  dequeue{
	if(q.isEmpty()){
		return <|0, 0|>;
	}else{
		int value = q.array[first];
		q.first = (q.first+1) % q.array[];
		q.size--;
		return <|value, 1|>;
	}
};

public Queue q : int value -> bit enqueue{
	if(q.isFull()){
		return 0;
	}else{
		q.array[(q.first + q.size++)%q.array[]] = value;
		return 1;
	}
};
		 

