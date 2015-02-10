#
# Generate pinyin 2 hanzi index
#
tongwen = require 'tongwen'

py2hz = {}

# Split BKRS pinyin line into array
@split = split = (line)->
  String line
  .replace /\s*/g, ''
  .replace /\[.*]/g, ','  # drop [...]
  .split /[;,]/
  .filter (x)->x

@add = (article)->
  hanzi = article[0]
  pinyin = article[1]
  len = article.slice(2).join('').length
  split pinyin
  .forEach (py)->
    (py2hz[py]||=[]).push
      h: hanzi
      n: len

pyLine = (s)->
  s = s.h
  st = tongwen.s2t s
  "[ref]#{s}[/ref]#{if s!=st then " / #{st}" else ''}"

@save = (dst)->
  for k, v of py2hz
    v.sort (a, b)->
      if a.n<b.n
        1
      else if a.n>b.n
        -1
      else
        0
    dst.write [k].concat v.map pyLine
  false
