"""reducer.py"""
import sys

current_word = None
current_count = 0
word = None
for line in sys.stdin:
  line = line.strip()
  word, count = line.split("\t", 1)
  try:
    count = int(count)
  except ValueError:
    current_word = word
    current_count = count
