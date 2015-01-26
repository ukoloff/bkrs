x = require '../lib/dsl'

parse = (s)->
  r = []
  x s, (tag, text)->r.push tag, text
  r

describe 'DSL parser', ->

  it 'Preserves text', ->

    parse ''
    .should.be.eql []

    parse s = 'Hello, world!'
    .should.be.eql [0, s]

  it 'Extract tags', ->

    parse '[a]'
    .should.be.eql [1, 'a']

    parse '[/b]'
    .should.be.eql [-1, 'b']

    parse '[]'
    .should.be.eql [1, '']

    parse '[/]'
    .should.be.eql [-1, '']

    parse '['
    .should.be.eql [1, '']

    parse '[/'
    .should.be.eql [-1, '']

  it 'Trim whitepspaces in tags', ->

    parse '[c ]'
    .should.be.eql [1, 'c']

    parse '[ / d ]'
    .should.be.eql [-1, 'd']

    parse '[ ]'
    .should.be.eql [1, '']

    parse '[/ ]'
    .should.be.eql [-1, '']

    parse '[  '
    .should.be.eql [1, '']

    parse '[ / '
    .should.be.eql [-1, '']

  it 'Mixes text and tags', ->

    parse 'Q[w]e[/r]t'
    .should.be.eql [0, 'Q', 1, 'w', 0, 'e', -1, 'r', 0, 't']

    parse 'Hello, [ i ]world[ / i'
    .should.be.eql [0, 'Hello, ', 1, 'i', 0, 'world', -1, 'i']

  it 'Quotes HTML in text and tags', ->

    parse 'a<b>c'
    .should.be.eql [0, "a&lt;b&gt;c"]

    parse '[ &x ]'
    .should.be.eql [1, "&amp;x"]

    parse '"[ p&g]"'
    .should.be.eql [0, '&quot;', 1, 'p&amp;g', 0, '&quot;']