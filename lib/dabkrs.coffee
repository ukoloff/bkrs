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
  all = for k, v of pinyin
    "#{k}  #{v.map((s)->"<r>#{s}</r>").join '<br>'}"
  fs.writeFile "src/py", all.join "\n"
