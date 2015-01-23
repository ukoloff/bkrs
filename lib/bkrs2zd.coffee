zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'
dumpz = require './dumpz'

for k, v of require './parts'
  fs.createReadStream "src/#{k}_#{ts}.gz"
  .pipe zlib.createUnzip()
  .pipe split v.article or (arr)-> @queue arr
  .pipe dumpz()
  .on('end', v.eof or ->)
  .pipe fs.createWriteStream "src/#{k}"
