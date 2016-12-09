
lexer grammar SMPLLexer;
@header{
package dk.heatless.smplSimulator.grammar;
}

//Logical operators
NOT 		: '!'	;
AND 		: '&'	;
OR 			: '|'	;
XOR			: '^'	;
NEQ			: '!='	;
GT 			: '>'	;
GE 			: '>='	;
LT 			: '<'	;
LE 			: '<='	;
EQ 			: '=='	;

//Bitwise operators
R_SHIFT		: '>>'	;
L_SHIFT		: '<<'	;
BIT_AND		: '&&'	;
BIT_OR		: '||'	;
BIT_XOR		: '^^'	;
BIT_NOT		: '!!'	;

//Arithmetic operators
PLUS 		: '+'	;
MINUS 		: '-'	;
MUL 		: '*'	;
DIV 		: '/'	;
MOD			: '%'	;
INC			: '++'	;
DEC			: '--'	;

//Assignments
ASSIGN 		: '='	;
ADD_ASSIGN	: '+='	;
SUB_ASSIGN	: '-='	;
MUL_ASSIGN	: '*='	;
DIV_ASSIGN	: '/='	;
MOD_ASSIGN	: '%='	;
AND_ASSIGN	: '&='	;
OR_ASSIGN	: '|='	;
XOR_ASSIGN	: '^='	;

//Groups
LPAREN 		: '('	;
RPAREN 		: ')'	;
LBRACE 		: '{'	;
RBRACE 		: '}'	;
LBRACKET 	: '['	;
RBRACKET 	: ']'	;
LANGLE		: '<|'	;
RANGLE		: '|>'	;

//Misc
SEMI 		: ';'	;
COMMA		: ','	;
DOT			: '.'	;
COLON 		: ':'	;
POUND		: '#'	;
APPR		: '~'	;
QUEST		: '?'	;
AT			: '@'	;
DOLLAR		: '$'	;
B_SLASH		: '\\'	;
C_MARK		: '<%>'	;
F_MARK		: '<:>'	;
LARROW		: '<-'	;
RARROW		: '->'	;


//keywords
BREAK 		: 'break'	;
CASE		: 'case'	;
CHAR		: 'char'	;
CONTINUE 	: 'continue';
DEFAULT		: 'default'	;
DO			: 'do'		;
ELSE		: 'else'	;
ENUM		: 'enum'	;	
FINAL		: 'final'	;
FLOAT		: 'float'	;
FOR			: 'for'		;
GOTO		: 'goto'	;
IF 			: 'if'		;
INT 		: 'int'		;
PUBLIC		: 'public'	;
PRIVATE		: 'private'	;
RETURN		: 'return'	;
SWITCH		: 'switch'	;
TYPE		: 'type'	;
STRING		: 'string'	;
UNION		: 'union'	;
USE			: 'use'		;
VOID 		: 'void'	;
VOLATILE	: 'volatile';
WHILE 		: 'while'	;
     
//Numbers
fragment
DIGIT 		: '0'..'9'	;
fragment
DIGITS		: DIGIT+	;	
INTEGER 	: DIGITS	;
FLOAT_LIT	: DIGITS 
			  '.' DIGITS;


//Characters
IDENTIFIER : LETTER (LETTER|'0'..'9')* ;
CHAR_LIT	: '\'' CHARACTER '\'';
STRING_LIT	: '"' CHARACTER* '"';

fragment
LETTER : 'A'..'Z'
       | 'a'..'z'
       | '_'
       ;
fragment
CHARACTER	: (LETTER | ' ' | '\\'.);

//Ignored
WS : (' '|'\r'|'\t'|'\u000C'|'\n') -> skip ;
COMMENT : '<:' .*? ':>' -> channel(HIDDEN);
