parts = require '../lib/parts'

describe 'BKRS parts', ->

  it 'are three', ->
    Object.keys parts
    .should.have.length 3

  it 'are hashes', ->
    for k, v of parts
      v.should.be.type 'object'
