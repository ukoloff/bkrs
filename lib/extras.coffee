#
# Run extras generations
#
fs = require 'fs'
through2 = require 'through2'

log = require './log'
dumpz = require './dumpz'
seq = require './seq'
extras = require '../package'
  .extras

seq extras
.step (i, x, done)->
  log "Creating #{x}..."
  out = through2.obj()
  out
  .pipe dumpz()
  .pipe once()
  .pipe fs.createWriteStream "src/#{x}"
  .on 'finish', done
  require "./#{x}"
  .save out
  out.end()
.done ->
  require './combine'

# Write to file in a single piece
once = ->
  buf = ''
  write = (data, enc, cb)->
    buf += data
    do cb
  end = (cb)->
    @push buf if buf.length
    do cb
  through2 write, end
