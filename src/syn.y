%{ 
    #include <iostream> 
    #include "parse.h" 

    extern "C" {
        char* yytext;
        int line_number = 1;  
    
        int yylex();
        void yyerror(const char* s);
        int yywrap(); 
    }
    
    // Keeps track of the different parameters in a definition signature. 
    std::vector<struct parameter> parameter_vector; 
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
    DEF param_list START statement_list END {
        std::cout << "definition: ";
        for (parameter param : parameter_vector) {
            std::cout << param << " "; 
        }
        std::cout << std::endl; 
        parameter_vector.clear();
    }
  | MAIN statement_list DONE
  ; 

param_list: 
    param 
  | param param_list 
  ; 
  
param: 
    ALPHA   { parameter_vector.push_back(parameter($<str>1)); }
  | INTEGER { parameter_vector.push_back(parameter($<str>1)); } 
  | SYMBOL  { parameter_vector.push_back(parameter($<ch>1));  } 
  | '(' ALPHA ':' ALPHA ')' { 
        passed_value val($<str>2, $<str>4); 
        parameter param(val);  
        parameter_vector.push_back(param);
    }
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
    std::cout << "Begin parsing" << std::endl;
    int result = yyparse(); 
    std::cout << "End parsing" << std::endl; 
    return result; 
}

void yyerror(const char* s) {
    fprintf(stderr, "Error: %s at line %d\n", s, line_number);
    fprintf(stderr, "    %s\n", yytext); 
}

int yywrap() {
    return 1; 
}