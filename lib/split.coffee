#
# Stream to split DSL source into articles
#

split = require 'split'
through2 = require 'through2'

module.exports = (cb = (arr)-> @push arr)->
  buf = []

  flush = ->
    return unless buf.length
    cb?.call self, buf
    buf= []

  $ = (s)->
    return if /^\s*#/.test s
    ($ = word) s

  word = (s)->
    return unless s = s.trim()
    do flush
    buf.push s
    $ = def

  def = (s)->
    if s = s.trim()
      buf.push s
    else
      $ = word

  # Line splitter
  s = split (line)->
    $ line
    return

  write = (buf, enc, cb)->
    s.write buf
    do cb

  end = (cb)->
    s.end()
    do flush
    do cb

  self = through2.obj write, end
