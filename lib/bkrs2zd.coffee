zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'
dumpz = require './dumpz'

parts =
  zh: 'dabkrs'
  ru: 'dabruks'
  ex: 'examples'

for k, v of parts
  fs.createReadStream "src/#{v}_#{ts}.gz"
  .pipe zlib.createUnzip()
  .pipe split (arr)->
    @queue arr
  .pipe dumpz()
  .pipe fs.createWriteStream "src/#{k}"
