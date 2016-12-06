
parser grammar SMPLParser;

options{
	tokenVocab=SMPLLexer;
}
@header{
package dk.heatless.smplSimulator.grammar;
}

aexpr : expr1
      | expr1 PLUS aexpr
      | expr1 MINUS aexpr;

expr1 : expr2
       | expr2 MUL expr1
       | expr2 DIV expr1 ;
	   
expr2 : exprnegate								#EXPNEGATE
       | identifier (LBRACKET expr RBRACKET)?	#VARIABLE
       | integer								#CONSTANT
       ;

expr : bexpr1
       | bexpr1 OR expr
       ;
	   
bexpr1 : bexpr2
        | bexpr2 AND bexpr1;
		
bexpr2 : e1 = aexpr opr e2 = aexpr
       | e1 = aexpr;
	
exprnegate:
           |MINUS expr
           | NOT expr;

opr : GT
    | GE
    | LT
    | LE
    | EQ
    | NEQ
    ;


decl : type identifier (LBRACKET r = integer RBRACKET)? SEMI (decl)?;

type : INT
     | VOID ;
	 

stmt :
	 ( assignStmt
     | continueStmt
	 | breakStmt
     | readStmt
     | writeStmt
	 | ifelseStmt
     | whileStmt
	 | blockStmt
	 ) (s2 = stmt)?
     ;

assignStmt : identifier (LBRACKET e1 = expr RBRACKET)? ASSIGN e2 = expr SEMI ;

continueStmt : CONTINUE SEMI ;

readStmt : READ identifier (LBRACKET e = expr RBRACKET)? SEMI ;

breakStmt : BREAK SEMI ;

writeStmt : WRITE expr SEMI ;

ifelseStmt : IF LPAREN expr RPAREN s1 = blockStmt (ELSE s2 = blockStmt)* ;

whileStmt : WHILE LPAREN expr RPAREN blockStmt;

blockStmt : LBRACE decl? stmt RBRACE ;

program :  blockStmt;


identifier : IDENTIFIER;

integer : INTEGER;
