#
# Stream to output article(s)
#

fs = require 'fs'
yaml = require 'js-yaml'
through2 = require 'through2'
dsl = require './dsl'
tag = require './tag'
log = require './log'
counts = require './counts'

passThru = 'dsl'==process.env.npm_config_tags

# Tags cache
tags = {}
wrappers = null

module.exports = fn = (name)->
  start = new Date
  ticks = 0
  seconds = -1

  tick = if process.stdout.isTTY
    ->
      ticks++
      s = Math.floor (new Date()-start)/1000
      return if seconds==s
      process.stdout.write "#{ticks}/#{seconds=s}\r"
  else
    ->

  indent = (s, i)-> "#{if i then ' ' else ''}#{s}"

  plain = (art, enc, cb)->
    do tick
    cb null, art.map(indent).join("\n")+"\n\n"

  zd = (art, enc, cb)->
    do tick
    word = art[0].replace /\s+/, ' '
    art = art.slice(1).map dsl2zd
    if 1==art.length
      art = art[0]
    else
      wrappers ?= do getWrappers
      art = art.map (s)-> "#{wrappers.wrap}#{s}#{wrappers.wrapx}"
      .join wrappers.br
    cb null, "#{word}  #{art}\n"

  write = if passThru
    plain
  else
    zd

  end = (cb)->
    counts name, ticks
    do cb

  through2.obj write, end

getWrappers = ->
  r = {}
  for w in ['wrap', 'br']
    for z in [0, 1]
      r["#{w}#{if z then 'x' else ''}"]=tag w, close: z, group: 'zd'
  r

# Convert single DSL line to ZD
dsl2zd = (s)->
  zd = ''
  dsl s, (open, text)->
    zd += if open
      tags["#{if close = open<0 then '-' else '+'}#{text}"]||=tag text, close: close
    else
      text
  zd

fn.passThru = passThru

fn.ext = if passThru
  'dsl' # For new Dictan Converter
else
  'txt' # For makezd

fn.report = ->
  if passThru
    require './gd'
  else
    do reportTags

reportTags = ->
  log "Saving used tags..."
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

  fs.writeFile "src/tags.yml", yaml.dump r
