#
# Parser of single DSL line
#

html = require './html'

module.exports = (s, fn)->
  s = html s

  soFar = ''

  out = ->
    fn? 0, soFar if soFar.length
    soFar = ''

  text = ->
    m = /\\|\[|$/.exec s
    soFar += m.input.substring 0, m.index
    s = m.input.substring m.index+1
    switch m[0]
      when '\\'
        soFar += s.substring 0, 1
        s = s.substring 1
      when '['
        do tag

  tag = ->
    m = /]|$/.exec s
    s = m.input.substring m.index+1
    t = m.input.substring 0, m.index
    if /[\u0400-\u04ff]/.test t
      soFar+="[#{t}#{m[0]}"
      return
    do out
    t = t.trim()
    x = 1
    if '/'==t.substring 0, 1
      x = -1
      t = t.substring 1
        .trim()
    fn? x, t.replace /\s+/, ' '

  do text while s.length
  do out
