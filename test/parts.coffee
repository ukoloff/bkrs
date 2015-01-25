parts = require '../lib/parts'

describe 'BKRS parts', ->

  it 'are three', ->
    Object.keys parts
    .length.should.be.equal 3

  it 'are hashes', ->
    for k, v of parts
      v.should.be.type 'object'
