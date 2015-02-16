#
# Special processing for examples
#
fts = require 'full-text-search-light'

s2t = require './s2t'

ex = new fts 'BKRS'
ex.init()

@article = (arr)->
  # Only chinese examples
  return if /[^\u4e00-\u9fff]/.test arr[0]

  # Require cyrillic in definition
  return unless arr.slice(1).some (s)->/[\u0400-\u04ff]/.test s

  s2t.add arr
  ex.add arr[0]

  @queue arr

@_for = _for = (str)->
  ex
  .search str
  .filter (s)->s!=str
  .sort strCmp
  .slice(0, 108)
  .map (x)->
    i: x.indexOf str
    s: x
  .sort (a, b)->
    if a.i<b.i
      -1
    else if a.i>b.i
      1
    else
      strCmp a.s, b.s
  .map (z)-> z.s

@for = (str)->
  z = _for str
  .map (x)->"[m2][ref]#{x}[/ref][/m]"
  if z.length
    z.unshift "[m1][p]Пример#{if z.length>1 then 'ы' else ''}[/p][/m1]"
  z

strCmp = (a, b)->
  if a.length<b.length
    -1
  else if a.length>b.length
    1
  else if a<b
    -1
  else if a>b
    1
  else
    0
