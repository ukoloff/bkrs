#
# Add traditional chines articles
#
fs = require 'fs'
tongwen = require 'tongwen'

s2t = {}

@add = (word)->
  return if s2t[word]
  t = tongwen.s2t word
  s2t[word] = t if t!=word

@save = (done)->
  all = for k, v of s2t
    "#{v}  =<r>#{k}</r>"
  fs.writeFile "src/s2t", all.join "\n"
  done?()
