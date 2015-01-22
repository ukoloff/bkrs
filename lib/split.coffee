split = require 'split'
through = require 'through'

module.exports = (cb)->
  buf = []

  flush = ->
    return unless buf.length
    cb?.call self, buf
    buf.length = 0

  mode = hash = (s)->
    return if /^\s*#/.test s
    (mode = word) s

  word = (s)->
    return unless s = s.trim()
    do flush
    buf.push s
    mode = def

  def = (s)->
    if /^\s/.test s
      buf.push s if s = s.trim()
    else
      (mode = word) s

  # Line splitter
  s = split (line)->
    mode line
    return

  write = (buf)->
    s.write buf

  end = (buf)->
    s.end()
    do flush
    @queue null

  self = through write, end
