
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

arithmetic_binary_operator
	:	PLUS
	| 	MINUS
	|	MUL
	|	DIV
	|	MOD
	
	;
	
arithmetic_logic_operator
	:	BIT_XOR
	|	BIT_OR
	|	BIT_AND
	|	L_SHIFT	
	|	R_SHIFT	
	;

relational_binary_operator
	:	NEQ			
	|	EQ			
	|	GT				
	|	GE				
	|	LT			
	|	LE
	;

logical_binary_operator
	:	AND					
	|	OR					
	|	XOR
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

//----------------------Expressions lower expression types have higher precedence
tuple_expression
	:	LANGLE expression_list RANGLE
	;

basic_expression
	:	IDENTIFIER
	|	INTEGER
	|	FLOAT_LIT
	|	CHAR_LIT
	|	STRING_LIT
	|	tuple_expression
	|	data_type LBRACE expression_list? RBRACE
	|	LPAREN expression RPAREN
	;
	
postfix_expression
	:	basic_expression
	|	postfix_expression 
		(	post_operator 
		|	DOT IDENTIFIER					//Member access
		|	LPAREN expression_list? RPAREN	//Function call
		|	LBRACKET expression? RBRACKET	//array index or length
		)
	;
	
prefix_operator_expression
	:	postfix_expression
	|	prefix_operator	prefix_operator_expression
	;

prefix_mutation_expression
	:	prefix_operator_expression
	|	(	AT								//pointer dereference
		|	DOLLAR							//address-of
		|	POUND							//sizeof
		|	data_type DOT					//cast
		|	data_type LARROW				//convert
		)
		prefix_mutation_expression
	| POUND data_type
	;
	
arithmetic_expression
	:	prefix_mutation_expression
	|	arithmetic_expression arithmetic_binary_operator postfix_expression
	;

arithmetic_logic_expression
	:	arithmetic_expression
	|	arithmetic_logic_expression arithmetic_logic_operator arithmetic_expression
	;

relational_expression
	:	arithmetic_logic_expression
	|	relational_expression relational_binary_operator arithmetic_logic_expression
	;

logical_expression
	:	relational_expression
	|	logical_expression logical_binary_operator relational_expression
	;
	
constant_expression
	:	logical_expression
		
		(	QUEST expression COLON constant_expression	//conditional
		)?
	;
	
function_expression
	:	(	data_type_list_par
		|	identifier_or_pointer_identifier_list
		)
		RARROW 
		(	function_expression
		|	constant_expression
		|	block_statement
		)
	;

identifier_or_pointer_identifier
	:	AT? IDENTIFIER
	;

identifier_or_pointer_identifier_list
	:	
	|	identifier_or_pointer_identifier (COMMA identifier_or_pointer_identifier)* COMMA?
	;

assignment_expression
	:	function_expression
	|	constant_expression
	|	postfix_expression assignment_operator assignment_expression
	;
		
expression
	:	assignment_expression
	;

expression_list
	:	expression (COMMA expression)* COMMA?
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
	|	IDENTIFIER
	|	tuple_data_type 
	|	LPAREN identified_array_data_type RPAREN
	;

qualified_data_type
	:	basic_data_type 
	|	(	qualifier
		|	AT 
		|	AT LPAREN identified_array_data_type RPAREN IDENTIFIER
		)
		qualified_data_type
	;
                                                                                                   
array_data_type
	:	qualified_data_type 
	|	array_data_type
		(LBRACKET expression? RBRACKET)	//Array
	;

identified_array_data_type
	:	array_data_type IDENTIFIER?
	;

identified_data_type_list
	:	identified_array_data_type (COMMA identified_array_data_type)* COMMA?
	;
	
data_type
	:	(	LPAREN identified_data_type_list RPAREN
		|	identified_array_data_type
		)
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

//--------------------------------------------Declarations

declaration_assignment
	:	(ASSIGN expression)?		//Normal assignment
	|	block_statement				//Quick function assignment		
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
	
selection_statement
	:	if_statement
	|	switch_statement
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
			|	YIELD
			)
			IDENTIFIER?
		|	RETURN
			expression
		)
		SEMI
	;	
	
coroutine_statement
	:	COROUTINE 
		LBRACE 
		(	declaration_statement
		|	IDENTIFIER block_statement
		)*
		RBRACE
	;
	
block_statement
	:	LBRACE statement_list RBRACE
	;

statement
	:	expression_statement
	|	declaration_statement
	|	selection_statement
	|	iteration_statement
	|	jump_statement
	|	block_statement
	|	coroutine_statement
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

full_indentifier
	:	IDENTIFIER (DOT IDENTIFIER)
	;

unit_field
	:	modifier declaration_statement
	;
	
unit_type_definition
	:	TYPE data_type SEMI
	;
	
import_statement
	:	IMPORT full_indentifier (DOT MUL)? SEMI
	;
	
unit_start
	:	NAMESPACE full_indentifier SEMI 
		import_statement*
		(	unit_field
		|	unit_type_definition
		)*
	;
	

	
	
	