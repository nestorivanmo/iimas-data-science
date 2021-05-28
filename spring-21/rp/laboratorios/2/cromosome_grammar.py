#L = {0^n 1^n}
#L = {ZERO^n ONE^n}
#G(V,T,P,S)

tokens = (
    'ZERO','ONE',   #Alfabeto
    )
 
# Each literal must be a single character
literals = []
 
t_ZERO = '0'
t_ONE = '1'
 
def t_error(t):
    print("Illegal character '%s'" % t.value[0])
    t.lexer.skip(1)
 
# Build the lexer, and enable debugging
import ply.lex as lex
lex.lex(debug=1) 
 
# dictionary of names
names = { }

#S->0S1
#S->01

def p_statement_assign(p):
    'statement : ZERO statement ONE'    
  
def p_statement_assign2(p):
    'statement : ZERO ONE'    

def p_error(p):
    if p:
        print("Syntax error at '%s'" % p.value)
    else:
        print("Syntax error at EOF")
 
import ply.yacc as yacc
yacc.yacc()
 
while 1:
    try:
        s = input('calc > ')
    except EOFError:
        break
    if not s: 
        continue
    yacc.parse(s)