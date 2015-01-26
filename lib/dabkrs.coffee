#
# Special processing for zh->ru source
#

fs = require 'fs'
tongwen = require 'tongwen'

pinyin = {}

@article = (arr)->
  return if '_'==arr[1]

  arr[1]
  .replace /\s*/g, ''
  .replace /\[.*]/g, ','  # drop [...]
  .split /[;,]/
  .filter (x)->x
  .forEach (py)-> (pinyin[py]||=[]).push arr[0]

  @queue arr

pyLine = (s)->
  r = "<r>#{s}</r>"
  st = tongwen.s2t s
  r+=" / #{st}" if st!=s
  r

@eof = ->
  all = for k, v of pinyin
    "#{k}  #{v.map(pyLine).join '<br>'}"
  fs.writeFile "src/py", all.join "\n"
