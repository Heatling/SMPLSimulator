
lexer grammar SMPLLexer;
@header{
package dk.heatless.smplSimulator.grammar;
}
AND : '&';
OR : '|';
ASSIGN : '=';
SEMI : ';';
GT : '>';
GE : '>=';
LT : '<';
LE : '<=';
EQ : '==';
NEQ : '!=';
PLUS : '+';
MINUS : '-';
MUL : '*';
DIV : '/';
NOT : '!';
LPAREN : '(';
RPAREN : ')';
LBRACE : '{';
RBRACE : '}';
LBRACKET : '[';
RBRACKET : ']';
COLON : ':';
IF : 'if';
ELSE : 'else';
WHILE : 'while';
CONTINUE : 'continue';
BREAK : 'break';
WRITE : 'write';
READ : 'read';
INT : 'int';
VOID : 'void';

COMMENT : '/*' .*? '*/' -> channel(HIDDEN);
     

INTEGER : ('0' | '1'..'9' '0'..'9'*);

IDENTIFIER : LETTER (LETTER|'0'..'9')* ;

fragment
LETTER : 'A'..'Z'
       | 'a'..'z'
       | '_'
       ;

WS : (' '|'\r'|'\t'|'\u000C'|'\n') -> skip ;
