zlib = require 'zlib'
fs = require 'fs'
split = require './split'
ts = require './timestamp'

fs.createReadStream "src/dabkrs_#{ts}.gz"
.pipe zlib.createUnzip()
.pipe split (arr)->
  console.log '<', arr.join(':'), '>'
