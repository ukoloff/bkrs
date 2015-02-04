#
# Run extras generations
#
fs = require 'fs'
through = require 'through'

dumpz = require './dumpz'
seq = require './seq'
extras = require '../package'
  .extras

seq extras
.step (x, done)->
  console.log "Creating #{x}..."
  out = through()
  out
  .pipe dumpz()
  .pipe once()
  .pipe fs.createWriteStream "src/#{x}"
  require "./#{x}"
  .save out
  out.write null
  do done
.done ->
  require './combine'

# Write to file in a single piece
once = ->
  buf = ''
  write = (data)->
    buf += data
  end = ->
    @queue buf if buf.length
    @queue null
  through write, end
