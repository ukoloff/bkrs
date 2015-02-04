#
# Add traditional chines articles
#
tongwen = require 'tongwen'

s2t = {}

@add = (word)->
  return if s2t[word]
  t = tongwen.s2t word
  s2t[word] = t if t!=word

@save = (dst)->
  for k, v of s2t
    dst.write [v, "[p]трад.[/p] [ref]#{k}[/ref]"]
