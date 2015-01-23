fs = require 'fs'

pinyin = {}

@article = (arr)->
  return if '_'==arr[1]

  arr[1]
  .replace /\s*/g, ''
  .replace /\[.*]/g, ''  # drop [...]
  .split /[;,]/
  .filter (x)->x
  .forEach (py)-> (pinyin[py]||=[]).push arr[0]

  @queue arr

@eof = ->
  o = fs.createWriteStream "src/py"
  for k, v of pinyin
    o.write "#{k}  #{v.map((s)->"<r>#{s}</r>").join '<br>'}\n"
