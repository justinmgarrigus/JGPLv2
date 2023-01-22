=== v2 Updates === 

1.) Lexical analyzer written in Lex, syntax analyzer written in Yacc, and 
    interpreter each written in C.
2.) Big focus on safe compilation/interpretation. 
3.) All previous code must be executable along with support for <sequence>'s and 
    <statement>'s.
    

=== Features === 

1.) "def" instead of "func".
2.) floats do not exist, they are created at runtime. "alpha" and "number" are 
    also individual types ("var1" is therefore two tokens, but can be
    converted back into an identifier at runtime). 
3.) Statement collections are realized as <sequences>'s. In other words, the 
    code is no longer realized as tabbed, but instead begun, ended, and 
    separated. The main block takes the form:
        START='MAIN', END='DONE', SEPARATOR=';'
    This yields code of the form: 
        MAIN
            display "hello, world!\n"; 
            int var = 5; 
            display var; 
        DONE
    Note that sequences can contain an extra separator at the end (here, after 
    the final 'var'). Additionally, the newlines/tabbings are now unnecessary. 
    Functions take the form: 
        DEF <parameters>
        START
           ... 
        END 
    These are the only two built-in blocks, everything else is user-defined. 
    Functions show that sequences must be prepared to overlap: a function in 
    reality consists of two sub-definitions: 
        DEF (parameters: sequence) START (code: sequence) END
    Where the bounds of (parameters) and (code) overlap. 
4.) Replace triangle braces with parenthesis in parameter definitions.
    Parenthesis are the only reserved character. 
    
    
=== Syntax analysis === 

- A program consists of a collection of blocks. For simplicity sake, two blocks 
  (mentioned before) are predefined, with others capable of being defined by 
  the user: DEF [params] START [statements] END, and MAIN [statements] DONE.