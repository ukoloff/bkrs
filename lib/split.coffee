#
# Stream to split DSL source into articles
#

split = require 'split'
through = require 'through'

module.exports = (cb)->
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

  write = (buf)->
    s.write buf

  end = (buf)->
    s.end()
    do flush
    @queue null

  self = through write, end
