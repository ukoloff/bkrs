path = require 'path'
tag = require '../lib/tag'

tag.options.path = path.join __dirname, 'tags'
tag.options.default = 'test'

describe 'Tag mapper', ->

  it 'Converts [] to <>', ->

    tag 'b'
    .should.be.equal '<b>'

    tag 'b', close: true
    .should.be.equal '</b>'

  it 'Uses configured mapping', ->

    tag 'ref'
    .should.be.equal '<r>'

    tag 'ref', close: true
    .should.be.equal '</r>'

    tag 'double'
    .should.be.equal '<u><sub>'

    tag 'double', close: true
    .should.be.equal '</sub></u>'

    tag 'attributed'
    .should.be.equal '<div class="none">'

    tag 'attributed', close: true
    .should.be.equal '</div>'

  it 'Marks unknown tags', ->

    tag 'oops'
    .should.be.equal '<span x-tag: "oops">'

    tag 'oops', close: true
    .should.be.equal '</span>'
