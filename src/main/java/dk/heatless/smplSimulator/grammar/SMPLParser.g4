
parser grammar SMPLParser;

options{
	tokenVocab=SMPLLexer;
}
@header{
package dk.heatless.smplSimulator.grammar;
}

//Operator classes

prefix_operator
	:	NOT
	|	BIT_NOT
	|	MINUS
	|	INC
	|	DEC
	;
	
post_operator
	:	INC
	|	DEC
	;
	
logical_binary_operator
	:	AND					
	|	OR					
	|	XOR			
	|	NEQ			
	|	EQ			
	|	GT				
	|	GE				
	|	LT			
	|	LE
	;
	
arithmetic_binary_operator
	:	PLUS
	| 	MINUS
	|	MUL
	|	DIV
	|	MOD
	|	BIT_XOR
	|	BIT_OR
	|	BIT_AND
	|	L_SHIFT	
	|	R_SHIFT	
	;

assignment_operator
	:	ASSIGN
	|	ADD_ASSIGN
	|	SUB_ASSIGN
	|	MUL_ASSIGN
	|	DIV_ASSIGN
	|	MOD_ASSIGN
	|	AND_ASSIGN
	|	OR_ASSIGN
	|	XOR_ASSIGN
	;

//Expressions lower expression types have higher precedence

basic_expression
	:	IDENTIFIER
	|	INTEGER
	|	CHAR_LIT
	|	STRING_LIT
	|	data_type LBRACE expression_list RBRACE
	|	LPAREN expression RPAREN
	;
	
primary_postfix_expression
	:	basic_expression
	|	primary_postfix_expression 
		(	LPAREN expression_list RPAREN
		|	LBRACKET expression RBRACKET
		)
	;
	
prefix_expression
	:	primary_postfix_expression
	|	(	prefix_operator					//INC or DEC
		|	LPAREN data_type RPAREN			//Cast
		|	LPAREN data_type RPAREN LARROW	//Conversion
		|	AT								//pointer dereference
		|	DOLLAR							//address-of
		)
		prefix_expression
	;
	
secondary_postfix_expression
	:	prefix_expression
	|	secondary_postfix_expression post_operator 
	|	secondary_postfix_expression DOT IDENTIFIER
	;
	
arithmetic_expression
	:	secondary_postfix_expression
	|	arithmetic_expression arithmetic_binary_operator secondary_postfix_expression
	;
	
logical_expression
	:	arithmetic_expression
	|	logical_expression logical_binary_operator arithmetic_expression
	;
	
constant_expression
	:	logical_expression
		//Can also be a conditional
		(QUEST expression COLON constant_expression)?
	;
	
assignment_expression
	:	constant_expression
	|	secondary_postfix_expression assignment_operator assignment_expression
	;
		
expression
	:	assignment_expression
	;

expression_list
	:	
	|	expression (COMMA expression)* COMMA?
	;
	
//Declarations
declaration
	:	data_type declaration_assignment_list SEMI
	;

declaration_assignment
	:	IDENTIFIER ASSIGN expression
	;

declaration_assignment_list
	:	declaration_assignment
	|	declaration_assignment (COMMA declaration_assignment) COMMA?
	;
	


//Data types
basic_data_type
	:	INT
	|	VOID
	|	FLOAT
	|	STRING
	|	CHAR
	|	LPAREN data_type RPAREN
	;

array_data_type
	:	basic_data_type 
		(LBRACKET expression? RBRACKET)?	//Array
	;

data_type
	:	array_data_type
	|	qualifier data_type
	|	AT data_type
	;

qualifier
	:	FINAL
	|	VOLATILE
	;


	
//Functions
parameter_type
	:	data_type
	;
parameter_type_list
	:
	|	parameter_type (COMMA parameter_type)* COMMA?
	;	
identifier_list
	:
	|	IDENTIFIER (COMMA IDENTIFIER)* COMMA?
	;

//Global scope
modifier
	:	
	|	PUBLIC
	|	PRIVATE
	;
	
	
	
	
	
	
	