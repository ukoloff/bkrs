through = require 'through'
utf16 = require '../lib/utf16'

convert = (buf)->
  r = new Buffer 0
  x = through()
  x
  .pipe utf16()
  .pipe through (data)->
    r = Buffer.concat [r, data]
  x.write buf
  x.write null
  r.toJSON()

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
