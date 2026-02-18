%option noyywrap
digit	[0-9]
letter	[A-Za-z]
%{
  #include <stdio.h>
  #include <string.h>
  #include "y.tab.h"
  #include <iostream>
  using namespace std;
%}


%%
{letter}({letter}|{digit})*	{yylval.str=strdup(yytext); return IDENTIFIER;}
";" {yylval.str=strdup(yytext); return SEMICOLON;}
"=" {yylval.str=strdup(yytext); return EQUAL;}
"{" {yylval.str=strdup(yytext); return CURLYOB;}
"}" {yylval.str=strdup(yytext); return CURLYCP;}
"," {yylval.str=strdup(yytext); return COMMA;}
"*" {yylval.str=strdup(yytext); return MULTP;}
"+" {yylval.str=strdup(yytext); return ADD;}
"/" {yylval.str=strdup(yytext); return DIVISION;}
"-" {yylval.str=strdup(yytext); return SUBS;}
"^" {yylval.str=strdup(yytext); return POWER;}
(([1-9]{digit}*)|0)("."{digit}+)? {yylval.str=strdup(yytext);return NUMBER;}
\n
[ \t]+
%%
