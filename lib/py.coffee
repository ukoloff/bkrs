#
# Generate pinyin 2 hanzi index
#
fs = require 'fs'
tongwen = require 'tongwen'
tag = require './tag'

py2hz = {}

# Split BKRS pinyin line into array
@split = split = (line)->
  String line
  .replace /\s*/g, ''
  .replace /\[.*]/g, ','  # drop [...]
  .split /[;,]/
  .filter (x)->x

@add = (hanzi, pinyin)->
  split pinyin
  .forEach (py)->
    (py2hz[py]||=[]).push hanzi

tags = {}

getTags = ->
  for n in ['ref', 'wrap']
    for close in [0..1]
      tags["#{n}#{if close then 'x' else ''}"] = tag n, group: 'py', close: close

pyLine = (s)->
  r = "#{tags.ref}#{s}#{tags.refx}"
  st = tongwen.s2t s
  r+=" / #{st}" if st!=s
  "#{tags.wrap}#{r}#{tags.wrapx}"

@save = (done)->
  do getTags
  all = for k, v of py2hz
    "#{k}  #{v.map(pyLine).join ''}"
  fs.writeFile "src/py", all.join "\n"
  done?()
