#
# Stream to output article(s)
#

fs = require 'fs'
yaml = require 'js-yaml'
through = require 'through'
dsl = require './dsl'
tag = require './tag'

module.exports = fn = ->

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
      tags["#{if close = open<0 then '-' else '+'}#{text}"]||=tag text, close: close
    else
      text
  zd

fn.report = ->
  console.log 'Saving used tags...'
  r = {}
  Object.keys tags
  .map (tag)->
    k: tag.replace /./, (c)-> if '-'==c then '/' else ''
    v: tags[tag]
  .sort (a, b)->
    if a.k==b.k
      0
    else if a.k>b.k
      1
    else
      -1
  .forEach (x)->
    r[x.k] = x.v

  fs.writeFile "src/tags", yaml.dump r
