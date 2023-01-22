#include "parse.h"

std::ostream& operator<<(
    std::ostream& out, 
    const parameter& param)
{
    if (param.type == parameter_keyword) 
        out << "[keyword: " << param.value.keyword << "]"; 
    else if (param.type == parameter_symbol) 
        out << "[symbol: " << param.value.symbol << "]"; 
    else if (param.type == parameter_passed_value) 
        out << "(passed: " << param.value.passed.type << ")"; 
    else
        out << "{UNKNOWN}";  
    
    return out; 
}