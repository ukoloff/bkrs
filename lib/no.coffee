zlib = require 'zlib'
fs = require 'fs'
split = require 'split'

fs.createReadStream 'src/dabkrs_150120.gz'
.pipe zlib.createUnzip()
.pipe split (s)->
  console.log '>', s
