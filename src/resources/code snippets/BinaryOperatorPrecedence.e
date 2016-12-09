namespace CodeSnippets.BinaryOperatorPrecedence;

public void main{
	<:Binary operator precedence is based around the  idea
	of arithmetics having lower precedence than logicals
	
	Operator classes: 
	(A: arithmetics, L: logicals, 
	_| x: from x, -> x ->: through x, x |_: to x)
	
	0: _| A -> A -> A |_: * / % + -
	1: _| A -> L -> A |_: && ^^ || << >>
	2: _| A -> L -> L |_: < <= > >= == !=
	3: _| L -> L -> L |_: ^ & |
	:>
	
	(1 + 1 * 2)
	==
	((1 + 1) * 2)
	;
	
	(2 && 2 * 2)
	==
	(2 && (2 * 2))
	;
	
	(2 < 2 || 4)
	==
	(2 < (2 || 4))
	;
	
	(1 & 2 == 2)
	==
	(1 & (2 == 2))
	;
	
	(1 | 1 | 1)
	==
	((1 | 1) | 1)
	;
	
};



