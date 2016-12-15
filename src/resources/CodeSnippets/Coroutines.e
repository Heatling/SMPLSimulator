namespace Coroutines;

public void main{
	coroutine{
		Queue q;
		produce{
			while(1){
				while( !isFull(q) ){
					enqueue(q, newItem());
				}
				yield consume;
			}
		}
		
		consume{
			while(1){
				while( !isEmpty(q) ){
					dequeue(q);
				}
				yield produce;
			}
		}
	}
};