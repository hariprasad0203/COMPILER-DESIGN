%{
#include <stdio.h>
#include <stdlib.h>

// Array of month abbreviations
char* month[]={"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
%}

%%

[0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9] {
    int d, m, y;

    // sscanf reads from a string buffer (yytext), not scanf
    sscanf(yytext, "%d-%d-%d", &d, &m, &y);

    if (m >= 1 && m <= 12)
        printf("%02d %s %04d", d, month[m-1], y);
    else
        printf("%s", yytext);
}

.|\n {
    // Corrected action block syntax for default characters
    ECHO;
}

%%

int yywrap() {
    return 1;
}

int main() {
    // Open the input file for reading
    yyin = fopen("input.txt", "r");
    if (yyin == NULL) {
        // Added missing closing quotation mark
        printf("File not found\n");
        return 1;
    }

    // The main engine function is yylex(), not yytext()
    yylex();

    fclose(yyin);
    return 0;
}

[24bcs041@mepcolinux ex1]$./date
12 JUN 2003
12-13-2005
03 NOV 2006
[24bcs041@mepcolinux ex1]$cat input.txt
12-06-2003
12-13-2005
03-11-2006
