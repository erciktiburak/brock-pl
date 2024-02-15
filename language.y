%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "symtable.h"
%}

%union {
    char *string;
    struct Class *class;
    struct Method *method;
    struct Parameter *param;
    struct Expression *expr;
}

%token <string> IDENTIFIER
%token <string> TYPE
%token <string> ACCESS_MODIFIER
%token <string> KEYWORD
%token <string> OPERATOR
%token <string> LITERAL
%token <string> SEMICOLON
%token <string> LEFT_BRACE
%token <string> RIGHT_BRACE
%token <string> LEFT_PAREN
%token <string> RIGHT_PAREN
%token <string> COMMA
%token <string> DOT
%token <string> ASSIGN
%token <string> COLON
%token <string> EXTENDS

%type <string> class_declaration
%type <string> class_body
%type <string> method_declaration
%type <string> parameter_list
%type <string> parameter
%type <string> statement
%type <string> expression
%type <string> access_modifier
%type <string> type

%%

program : /* empty */
        | program class_declaration
        ;

class_declaration : ACCESS_MODIFIER? KEYWORD IDENTIFIER EXTENDS IDENTIFIER LEFT_BRACE class_body RIGHT_BRACE
                  ;

class_body : /* empty */
           | class_body method_declaration
           ;

method_declaration : ACCESS_MODIFIER? KEYWORD IDENTIFIER LEFT_PAREN parameter_list? RIGHT_PAREN LEFT_BRACE /* statements */ RIGHT_BRACE
                   ;

parameter_list : parameter
               | parameter_list COMMA parameter
               ;

parameter : TYPE IDENTIFIER
          ;

access_modifier : ACCESS_MODIFIER
                ;

type : TYPE
     ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 1;
}
