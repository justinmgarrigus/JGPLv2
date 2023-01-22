%{ 

#include <string.h> 
#include "y.tab.h"

%} 
%%

"DEF"   { return DEF; }
"START" { return START; }
"END"   { return END; }
"MAIN"  { return MAIN; } 
"DONE"  { return DONE; }
[();:]   { return *yytext; }

[a-zA-Z]+ {
    yylval.str = strdup(yytext); 
    return ALPHA; 
}

[0-9]+ {
    yylval.str = strdup(yytext); 
    return INTEGER;
}

\n { yylineno++; } // For debugging purposes

[ \t] ; // Whitespace is otherwise ignored 

. { 
    yylval.ch = *yytext; 
    return SYMBOL; 
}

%%