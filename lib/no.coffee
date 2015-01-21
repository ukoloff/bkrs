zlib = require 'zlib'
fs = require 'fs'

fs.createReadStream 'src/dabkrs_150120.gz'
.pipe zlib.createUnzip()
.pipe process.stdout
