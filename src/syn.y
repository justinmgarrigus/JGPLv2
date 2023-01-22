%{ 
    #include <stdio.h> 

    extern "C" {
        char* yytext;
        int line_number = 1;  
    
        int yylex();
        void yyerror(const char* s);
        int yywrap(); 
    }
%}

%union {
    char *str; // ALPHA and INTEGER can span multiple characters. 
    char ch;   // SYMBOLs are single characters. 
}

%token DEF START END MAIN DONE 

%token ALPHA
%token INTEGER
%token SYMBOL 

%% 

program:
    block_list
  |
  ;

block_list: 
    block 
  | block block_list 
  ; 

block:
    DEF param_list START statement_list END
  | MAIN statement_list DONE
  ; 

param_list: 
    param 
  | param param_list 
  ; 
  
param: 
    ALPHA 
  | INTEGER
  | SYMBOL 
  | '(' ALPHA ':' ALPHA ')'
  ; 

statement_list: 
    statement
  | statement statement_list 
  ; 
  
statement: 
    item_list ';'
  ;

item_list: 
    item 
  | item item_list 
  ; 

item: 
    ALPHA
  | INTEGER
  | SYMBOL
  ;

%% 

int main() {
    printf("Begin parsing\n"); 
    int result = yyparse(); 
    printf("End parsing\n"); 
    return result; 
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s at line %d\n", s, line_number);
    fprintf(stderr, "    %s\n", yytext); 
}

int yywrap() {
    return 1; 
}