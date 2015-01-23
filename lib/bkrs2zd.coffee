zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'
dumpz = require './dumpz'

fs.createReadStream "src/dabruks_#{ts}.gz"
.pipe zlib.createUnzip()
.pipe split (arr)->
  @queue arr
.pipe dumpz()
.pipe fs.createWriteStream 'src/ru'
