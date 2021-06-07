"""
LABORATORIO #2

- Martínez Ostoa Néstor Iván
- Reconocimiento de Patrones
- LCD, IIMAS, UNAM
"""

import nltk

class Parser:
	def __init__(self, sequences):
		self.sequences = sequences
		self.median_grammar = nltk.CFG.fromstring(
			"""
			S -> A A
		    A -> "c" B
		    B -> F B E
		    B -> H D J
		    D -> F D E
		    D -> "d"
		    F -> "b"
		    E -> "b"
		    H -> "a"
		    J -> "a"
			"""
		)
		self.submedian_grammar = nltk.CFG.fromstring(
			"""
		    S -> A A
		    A -> "c" M
		    B -> F L
		    B -> F B E
		    B -> R E
		    D -> F G
		    D -> F D E
		    D -> W E
		    L -> H N J
		    L -> F L
		    R -> H N J
		    R -> R E
		    G -> "d"
		    G -> F G
		    W -> "d"
		    W -> W E
		    F -> "b"
		    E -> "b"
		    H -> "a"
		    M -> F B E
		    J -> "a"
		    N -> F D E
		    """
		)
		self.acrocentric_grammar = nltk.CFG.fromstring(
			"""
			S -> A A
		    A -> "c" B
		    B -> F L
		    B -> R E
		    D -> F G
		    D -> W E
		    L -> F L
		    R -> R E
		    G -> F G
		    W -> W E
		    L -> H D J
		    H -> "a"
		    R -> H D J
		    G -> "d"
		    W -> "d"
		    J -> "a"
		    E -> "b"
		    F -> "b"
			"""
		)

	def determine_chromosome_from(self, sequence):
		for idx, grammar in enumerate([self.median_grammar, self.submedian_grammar, self.acrocentric_grammar]):
			p = nltk.LeftCornerChartParser(grammar)
			for t in p.parse(sequence):
				if idx == 0: return "Median"
				elif idx == 1: return "Submedian"
				else: return "Acrocentric"

	def parse(self):
		for seq in self.sequences:
			chromosome = self.determine_chromosome_from(seq)
			print(f"Secuencia:\n\t\'{seq}\'\nCromosoma: {chromosome}\n\n")

if __name__ == '__main__':
	sequences = [
		"cbbbabbbbdbbbbabbbcbbbabbbbdbbbbabbb",
		"cbabbbdbbbbbabbbcbbbabbbbbdbbbab",
		"cadbbbbbbabbbbbcbbbbbabbbbbbda"
	]
	Parser(sequences).parse()
