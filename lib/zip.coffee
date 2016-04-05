fs = require 'fs'
yazl = require 'yazl'
log = require './log'

z = new yazl.ZipFile()
z.outputStream.pipe fs.createWriteStream 'src/bkrs.zip'
.on 'close', ->
  log 'ZIP created!'

for f in "bkrs bruks".split ' '
  z.addFile "src/#{f}.dsl", "#{f}.dsl"

z.end()
