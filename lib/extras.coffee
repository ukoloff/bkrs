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
  .pipe dumpz x
  .pipe fs.createWriteStream "src/#{x}"
  .on 'finish', done
  require "./#{x}"
  .save out
  out.end()
.done ->
  require './combine'
