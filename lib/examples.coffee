#
# Special processing for examples
#
s2t = require './s2t'

ex = []

@article = (arr)->
  # Only chinese examples
  return if /[^\u4e00-\u9fff]/.test arr[0]

  # Require cyrillic in definition
  return unless arr.slice(1).some (s)->/[\u0400-\u04ff]/.test s

  s2t.add arr[0]
  ex.push arr[0]

  @queue arr

@_for = _for = (str)->
  ex
  .map (x)->
    i: x.indexOf str
    s: x
  .filter (z)->z.i>=0
  .sort (a, b)->
    if a.i<b.i
      -1
    else if a.i>b.i
      1
    else if a.s.length<b.s.length
      -1
    else if a.s.length>b.s.length
      1
    else if a.s<b.s
      -1
    else if a.s>b.s
      1
    else
      0
  .map (z)-> z.s

@for = (str)->
  z = _for str
  .map (x)->"[ref]#{x}[/ref]"
  if z.length
    z.unshift '[p]E.g.[/p]'
  z
