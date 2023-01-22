#ifndef PARSE_H
#define PARSE_H

#include <vector>
#include <iostream>  

enum parameter_type {
    parameter_keyword,
    parameter_symbol, 
    parameter_passed_value 
}; 

struct passed_value {  
    char *type; 
    char *id; 
    
    passed_value() = default; 
    passed_value(char* type, char* id) : type(type), id(id) {};
}; 

union parameter_value {
    char *keyword; 
    char symbol; 
    passed_value passed; 
    
    parameter_value() = default; 
    parameter_value(char* keyword) : keyword(keyword) {} 
    parameter_value(char symbol) : symbol(symbol) {} 
    parameter_value(passed_value passed) : passed(passed) {}
}; 

struct parameter {
    parameter_value value;
    parameter_type type; 
    
    parameter(char* keyword) : value(keyword), type(parameter_keyword) {}
    parameter(char symbol) : value(symbol), type(parameter_symbol) {}
    parameter(passed_value pass) : value(pass), type(parameter_passed_value) {}
    
    friend std::ostream& operator<<(std::ostream& out, const parameter& val); 
};

#endif