"""
code_table: diccionario que representa la tabla de codificación
"""
code_table = {'A': 'AA', 'B': 'AB', 'C': 'AC', 'D': 'AD', 'E': 'AE',
          'F': 'BA', 'G': 'BB', 'H': 'BC', 'I': 'BF', 'J': 'BG', 'K': 'BE',
          'L': 'CA', 'M': 'CB', 'N': 'CC', 'O': 'CD', 'P': 'CE',
          'Q': 'DA', 'R': 'DB', 'S': 'DC', 'T': 'DD', 'U': 'DE',
          'V': 'EA', 'W': 'EB', 'X': 'EC', 'Y': 'ED', 'Z': 'EE'
          }

"""
norm(str_to_op) 
    función para normalizar un string dado
--------------------------------------------
str_to_op: string a normalizar
"""
def norm(str_to_op):
  return  "".join(str_to_op.split()).upper()

"""
codifica(norm_str) 
    función que codifica un string normalizado usando la tabla de codificación
--------------------------------------------
str_to_op: string ingresado por el usuario
"""
def codifica(str_to_op):
  norm_str = norm(str_to_op)
  coded_str = ""
  for c in norm_str:
    coded_str += code_table[c]
  return coded_str

"""
decodifica(norm_str) 
    función que decodifica un string normalizado usando la tabla de codificación
--------------------------------------------
str_to_op: string ingresado por el usuario
"""
def decodifica(str_to_op):
  norm_str = norm(str_to_op)
  keys = list(code_table.keys())
  vals = list(code_table.values())
  decoded_str = ""
  for i in range(1, len(norm_str), 2):
    pair = norm_str[i-1] + norm_str[i]
    decoded_str += keys[vals.index(pair)]
  return decoded_str

def main():
  should_code = int(input('Codificar(0) / Decodificar(1): '))
  str_to_op = str(input('Ingresa cadena: '))
  if should_code == 0:
    print(codifica(str_to_op)) 
  else:
    print(decodifica(str_to_op))

main()
