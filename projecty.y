%{
	#include <stdio.h>
	#include <iostream>
	#include <string>
	#include <string.h>
	#include <vector>
	using namespace std;
	extern FILE *yyin;
	extern int yylex();
	void yyerror(string s);	
	vector<string> variables;
	vector<string> temp_variables;
	bool isInVariables(string var) {
        for(const string& v : variables) {
            if(v == var) return true;
        }
        return false;
    }
%}

%union
{
	char * str;
}


%token<str> SEMICOLON EQUAL CURLYOB CURLYCP COMMA MULTP ADD DIVISION SUBS POWER NUMBER IDENTIFIER
%type<str> operations term expression

%%

program : livestatement statements ;

livestatement: CURLYOB identifiers CURLYCP ;

identifiers  : IDENTIFIER COMMA identifiers{
                if(!isInVariables(string($1))) variables.push_back($1);
             }
			 | IDENTIFIER  {
				if(!isInVariables(string($1))) variables.push_back($1);
              };

statements :  statement statements
			| statement ;

statement  :  IDENTIFIER EQUAL expression SEMICOLON{
				for(auto i = variables.begin(); i != variables.end();i++){
					if(*i==$1){
						cout << $1 << $2 << $3 << $4 << endl ;
						variables.erase(i);
						if(!temp_variables.empty()){
							for(int i = 0; i<temp_variables.size();i++){
								string m = temp_variables.at(i);
								if(!isInVariables(m)) variables.push_back(m);
							}
						}
						break;
					}
				}
				temp_variables.clear();
			};

expression :  term operations term{
				string s = string($1) + string($2) + string($3) ;
				$$ = strdup(s.c_str());
			}
			|  term;

operations : ADD | DIVISION | MULTP | SUBS | POWER ;

term :  NUMBER
	  | SUBS NUMBER{
            string s = string($1) + string($2);
            $$ = strdup(s.c_str());
      }
	  | ADD NUMBER{
            string s = string($1) + string($2);
            $$ = strdup(s.c_str());
      }
	  | IDENTIFIER{
			temp_variables.push_back($1);
		};



%%
void yyerror(string s){
	cerr<<"Error..."<<endl;
}

int main(int argc, char *argv[])
{
    /* Call the lexer, then quit. */
    yyin=fopen(argv[1],"r");
    yyparse();
    fclose(yyin);
    return 0;
}
