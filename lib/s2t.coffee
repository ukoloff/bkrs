#
# Add traditional chines articles
#
tongwen = require 'tongwen'

s2t = {}

@add = (article)->
  word = article[0]
  unless t = s2t[word]
    t = tongwen.s2t word
    return if t==word
    s2t[word] = t
  article.splice 1, 0, "[p]трад.[/p] #{t}"

@save = (dst)->
  for k, v of s2t
    dst.write [v, "[p]трад.[/p] [ref]#{k}[/ref]"]
