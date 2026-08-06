%{
#include <stdio.h>
#include <string.h>

FILE* out;
int count = 0;

int isPalindrome(char* str) {
    int len = strlen(str);
    int i = 0;
    int j = len - 1;
    while (i < j) {
        if (str[i] != str[j])
            return 0;
        i++;
        j--;
    }
    return 1;
}
%}

%%
[01]+ {
    if (isPalindrome(yytext)) {
        fprintf(out, "%s\n", yytext);
        count++;
    }
}
[\t\n]+ ;
. ;
%%


int yywrap() {
    return 1;
}


int main() {
    FILE* in = fopen("p2.txt", "r");
    if (in == NULL) {
        printf("Cannot open input file\n");
        return 1;
    }

    out = fopen("palindrome.txt", "w");
    if (out == NULL) {
        printf("Can't open output file\n");
        fclose(in);
        return 1;
    }

    yyin = in;
    yylex();

    printf("No.of.binary palindrome strings = %d\n", count);

    fclose(in);
    fclose(out);
    return 0;
}

[24bcs041@mepcolinux ex1]$./palin
No.of.binary palindrome strings = 4
[24bcs041@mepcolinux ex1]$cat p2.txt
101
111
010
110
001
1010101

[24bcs041@mepcolinux ex1]$cat palindrome.txt
101
111
010
1010101
