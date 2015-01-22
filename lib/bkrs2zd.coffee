zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'

fs.createReadStream "src/dabruks_#{ts}.gz"
.pipe zlib.createUnzip()
.pipe split (arr)->
  @queue "<#{arr.join ':'}>\n"
.pipe process.stdout
