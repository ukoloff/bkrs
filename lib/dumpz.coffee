#
# Stream to output article(s)
#

through = require 'through'
dsl = require './dsl'
tag = require './tag'

module.exports = ->

  through (art)->
    word = art[0].replace /\s+/, ' '
    art = art.slice(1).map dsl2zd
    if 1==art.length
      art = art[0]
    else
      art = art.map (s)-> "<div>#{s}</div>"
      .join ''
    @queue "#{word}  #{art}\n"

# Tags cache
tags = {}

# Convert single DSL line to ZD
dsl2zd = (s)->
  zd = ''
  dsl s, (open, text)->
    zd += if open
      tags["#{close = open<0}#{text}"]||=tag text, close: close
    else
      text
  zd
