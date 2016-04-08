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
counts = require './counts'

if dumpz.passThru
  require './appveyor'
  .message "Using BKRS v#{ts}"

counts "version", ts

seq sources
.step (file, params, done)->
  log "Parsing #{file}..."
  fs.createReadStream "src/#{file}_#{ts}.gz"
  .pipe zlib.createUnzip()
  .pipe split params.article
  .pipe dumpz file
  .on('end', done)
  .pipe fs.createWriteStream "src/#{file}"
.done ->
  require './abrv'
