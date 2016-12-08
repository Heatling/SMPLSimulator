
parser grammar SMPLParser;

options{
	tokenVocab=SMPLLexer;
}
@header{
package dk.heatless.smplSimulator.grammar;
}

//------------------------------------Operator classes

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

//--------------------------------------------Data types	
tuple_data_type
	:	LANGLE data_type_list RANGLE
	;

basic_data_type
	:	INT
	|	VOID
	|	FLOAT
	|	STRING
	|	CHAR
	|	tuple_data_type 
	|	LPAREN data_type RPAREN
	|	basic_data_type IDENTIFIER
	;
	
array_data_type
	:	basic_data_type 
		(LBRACKET expression? RBRACKET)?	//Array
	;

qualified_data_type
	:	array_data_type
	|	qualifier data_type
	|	AT data_type
	;

qualified_data_type_list
	:	qualified_data_type (COMMA qualified_data_type)* COMMA?
	;

qualified_data_type_list_par
	:	LPAREN qualified_data_type_list RPAREN
	|	qualified_data_type_list
	;
	
data_type
	:	qualified_data_type_list_par		
		(	RARROW				//function
			data_type
		)?					
	;

data_type_list
	:	data_type (COMMA data_type)* COMMA?
	;

data_type_list_par
	:	LPAREN data_type_list RPAREN
	|	data_type_list
	;

qualifier
	:	FINAL
	|	VOLATILE
	;
	

//----------------------Expressions lower expression types have higher precedence
tuple_expression
	:	LANGLE expression_list RANGLE
	;

basic_expression
	:	IDENTIFIER
	|	INTEGER
	|	CHAR_LIT
	|	STRING_LIT
	|	tuple_expression
	|	data_type LBRACE expression_list? RBRACE
	|	LPAREN expression RPAREN
	;
	
primary_postfix_expression
	:	basic_expression
	|	primary_postfix_expression 
		(	LPAREN expression_list? RPAREN	//Function call
		|	LBRACKET expression RBRACKET	//array index
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
	
function_expression
	:	data_type_list_par
		RARROW 
		(	function_expression
		|	constant_expression
		|	block_statement
		)
	;
	
assignment_expression
	:	function_expression
	|	constant_expression
	|	secondary_postfix_expression assignment_operator assignment_expression
	;
		
expression
	:	assignment_expression
	;

expression_list
	:	expression (COMMA expression)* COMMA?
	;
	
//--------------------------------------------Declarations

declaration_assignment
	:	IDENTIFIER 
		(	(ASSIGN expression)?		//Normal assignment
		|	block_statement				//Quick function assignment
		)
		
	;

declaration_assignment_list
	:	declaration_assignment (COMMA declaration_assignment)* COMMA?
	;

//--------------------------------------------Statements
expression_statement
	:	expression SEMI
	;
	
declaration_statement
	:	data_type declaration_assignment_list SEMI
	;
	
alternative_statement
	:	ELSE block_statement
	;

if_statement
	:	IF expression block_statement 	//Normal if
			(	alternative_statement	//Final else	
			|	ELSE if_statement		//else if
			)?
	|	IF	expression COLON
		if_case+
		alternative_statement?
	;
	
if_case
	:	expression block_statement
	;
	
switch_statement
	: SWITCH expression LBRACE switch_case+ RBRACE
	;
	
switch_case
	:	(	expression 
		|	DEFAULT	
		)
		COLON statement_list
	;
	
while_statement
	:	WHILE expression block_statement
		alternative_statement?
	|	DO block_statement WHILE expression_statement
	;
	
for_arguments
	:	(	expression_statement						//Normal for
		|	declaration_statement
		) 
		expression_statement 
		expression?
	|	data_type COLON expression		//for each
	;

for_statement
	:	FOR 
		(	LPAREN for_arguments RPAREN
		|	for_arguments
		)
		block_statement
		alternative_statement?
	;

iteration_statement
	:	(IDENTIFIER COLON)?
		(	for_statement
		|	while_statement
		)
	;
	
jump_statement
	:	(	(	CONTINUE
			|	BREAK	
			)
			IDENTIFIER?
		|	RETURN
			expression
		)
		SEMI
	;	
	
block_statement
	:	LBRACE statement_list RBRACE
	;

statement
	:	expression_statement
	|	declaration_statement
	|	if_statement
	|	iteration_statement
	|	jump_statement
	|	block_statement
	;
	
statement_list
	:	
	|	statement statement_list 
	;


//---------------------------------------------Global scope
modifier
	:	
	|	PUBLIC
	|	PRIVATE
	;
	
unit_field
	:	modifier declaration_statement
	;
	
unit_start
	:	unit_field*
	;
	
	
	
	
	