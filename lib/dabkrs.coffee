pinyin = {}

@article = (arr)->
  return if '_'==arr[1]

  arr[1]
  .replace /\s*/g, ''
  .replace /\[.*]/g, ''  # drop [...]
  .split /[;,]/
  .filter (x)->x
  .forEach (py)-> (pinyin[py]||=[]).push arr[0]

  # console.log py.join(', ')

  @queue arr

@eof = ->
  console.log 'PY', pinyin
