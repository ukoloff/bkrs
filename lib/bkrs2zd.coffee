#
# Read and process all BKRS sources
#

zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'
dumpz = require './dumpz'
seq = require './seq'
sources = require './parts'

seq Object.keys sources
.step (file, done)->
  v = sources[file]
  console.log "Parsing #{file}..."
  fs.createReadStream "src/#{file}_#{ts}.gz"
  .pipe zlib.createUnzip()
  .pipe split v.article or (arr)-> @queue arr
  .pipe dumpz()
  .on('end', v.eof or ->)
  .on('end', done)
  .pipe fs.createWriteStream "src/#{file}"
.done ->
  require './combine'
