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

    tag 'm2'
    .should.be.equal '<div style="margin-left: 1em;">'

    tag 'm2', close: true
    .should.be.equal '</div>'

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
    .should.be.equal '<span x-tag="oops">'

    tag 'oops', close: true
    .should.be.equal '</span>'

    tag 'oops', default: 'none'
    .should.be.equal '<spam class="error" x-tag="oops">'

    tag 'oops', close: true, default: 'none'
    .should.be.equal '</spam>'

    tag 'oops', default: 'none2'
    .should.be.equal '<spam class="error" x-tag="oops"><diff id="fail" x-tag="oops">'

    tag 'oops', close: true, default: 'none2'
    .should.be.equal '</diff></spam>'

  it 'Uses different sets', ->

    tag 'b', group: 'others'
    .should.be.equal '<big>'

    tag 'b', group: 'others', close: true
    .should.be.equal '</big>'

    tag 'i', group: 'others'
    .should.be.equal '<it a=l><x>'

    tag 'i', group: 'others', close: true
    .should.be.equal '</x></it>'

    tag 'root', group: '-'
    .should.be.equal "<path base='/'>"

    tag 'root', group: '-', close: true
    .should.be.equal '</path>'
