through2 = require 'through2'
utf16 = require '../lib/utf16'

convert = (buf)->
  r = new Buffer 0
  x = utf16()
  x.pipe through2 (data, enc, cb)->
    r = Buffer.concat [r, data]
    do cb
  x.end buf
  b for b in r

describe 'UTF16 converter', ->

  it 'Converts UTF8 to UTF16-LE', ->
    convert 'A'
    .should.be.eql [65, 0]
    convert 'Hi'
    .should.be.eql [72, 0, 105, 0]
    convert 'Опа'
    .should.be.eql [30, 4, 63, 4, 48, 4]
    convert '你好'
    .should.be.eql [96, 79, 125, 89]
