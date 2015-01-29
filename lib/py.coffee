#
# Generate pinyin 2 hanzi index
#

# Split BKRS pinyin line into array
@split = (line)->
  String line
  .replace /\s*/g, ''
  .replace /\[.*]/g, ','  # drop [...]
  .split /[;,]/
  .filter (x)->x
