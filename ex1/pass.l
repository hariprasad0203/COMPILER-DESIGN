%{
#include<stdio.h>
#include<string.h>
#include<ctype.h>
char password[100];
int i=0;
%}
%%
[a-zA-Z0-9&@$\-]* {
        int len=strlen(yytext);
        int upper= 0,lower=0,digit=0,special=0;
        if(len<8){
                printf("Invalid password:length should be atleast 8 characters \n");
        }
        if(len>64){
                printf("Invalid password:length should not exceed 64 characters \n");
        }
        for (i =0 ;i<len;i++){
                if (isupper(yytext[i]))
                        upper=1;
                if (islower(yytext[i]))
                        lower=1;
                if (isdigit(yytext[i]))
                        digit=1;
                if (yytext[i]=='&'||yytext[i]=='@'||yytext[i]=='$'||yytext[i]=='-')
                        special=1;
        }
        if(!isalpha(yytext[0])){
        printf("first char should be alphabet\n");
        }
        if(!upper)
                printf("NO uppercase\n");
        if(!lower)
                printf("NO lowercase\n");
        if(!digit)
                printf("NO digit\n");
        if(!special)
                printf("NO special\n");
        if(upper&&lower&&digit&&special)
                printf("Valid pass\n");
                return 0;
}
.|\n {
        printf("Invalid pass:Should start with alphabet and contain valid characters\n");
        return 0;
}

%%

int yywrap(){
        return 1;
}
int main(){
        printf("Enter the pass:");
        yylex();
        return 0;
}

[24bcs041@mepcolinux ex1]$./pass
Enter the pass:hari
Invalid password:length should be atleast 8 characters
NO uppercase
NO digit
NO special
[24bcs041@mepcolinux ex1]$./pass
Enter the pass:hari@0203
NO uppercase
[24bcs041@mepcolinux ex1]$./pass
Enter the pass:Hari@9203
Valid pass
