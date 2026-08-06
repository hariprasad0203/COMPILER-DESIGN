%{
#include <stdio.h>
#include <string.h>

int MAX = 0;
char Longest[100][100];
int count = 0;
%}

%%
[a-zA-Z][a-zA-Z0-9]* {   /* Fixed: Added '*' to match full words */
    int len = strlen(yytext);
    if (len > MAX) {     /* Fixed: Changed 'max' to uppercase 'MAX' */
        MAX = len;       /* Fixed: Changed 'max' to uppercase 'MAX' */
        count = 0;
        strcpy(Longest[count], yytext);
        count++;
    }
    else if (len == MAX) {
        strcpy(Longest[count], yytext);
        count++;
    }
}
[\t\n]+ ;               /* Fixed: Changed '/n' to '\n' */
. ;
%%

int yywrap() {
    return 1;
}

int main() {
    int i;
    yyin = fopen("INPUT.txt", "r");
    if (yyin == NULL) {
        printf("can't open file\n");
        return 1;
    }
    yylex();

    printf("Longest len=%d\n", MAX); /* Fixed: Added missing semicolon */
    printf("Longest string(s):\n");
    for (i = 0; i < count; i++) {
        printf("%s\n", Longest[i]);
    }
    fclose(yyin);
    return 0;
}

[24bcs041@mepcolinux ex1]$./alph
Longest len=10
Longest string(s):
strawberry
hariprasad
[24bcs041@mepcolinux ex1]$cat INPUT.txt
apple banana strawberry blueberry orange hariprasad
