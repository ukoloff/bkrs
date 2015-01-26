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
        do out
        do tag

  tag = ->
    m = /]|$/.exec s
    t = m.input.substring 0, m.index
        .trim()
    s = m.input.substring m.index+1
    x = 1
    if '/'==t.substring 0, 1
      x = -1
      t = t.substring 1
        .trim()
    fn? x, t

  do text while s.length
  do out
