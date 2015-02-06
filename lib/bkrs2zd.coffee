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
log = require './log'

seq sources
.step (file, params, done)->
  log "Parsing #{file}..."
  fs.createReadStream "src/#{file}_#{ts}.gz"
  .pipe zlib.createUnzip()
  .pipe split params.article or (arr)-> @queue arr
  .pipe dumpz()
  .on('end', done)
  .pipe fs.createWriteStream "src/#{file}"
.done ->
  require './extras'
