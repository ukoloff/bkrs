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

    parse '*[*]*[/*]*'
    .should.be.eql [0, '*', 1, '*', 0, '*', -1, '*', 0, '*']

    parse s = '[]'
    .should.be.eql [0, s]

    parse s = '[/]'
    .should.be.eql [0, s]

    parse s = '['
    .should.be.eql [0, s]

    parse s = '[/'
    .should.be.eql [0, s]

  it 'Trim whitepspaces in tags', ->

    parse '[c ]'
    .should.be.eql [1, 'c']

    parse '[ / d ]'
    .should.be.eql [-1, 'd']

    parse s = '[ ]'
    .should.be.eql [0, s]

    parse '[/ ]'
    .should.be.eql [0, '[/ ]']

    parse s = '[  '
    .should.be.eql [0, s]

    parse s = '[ / '
    .should.be.eql [0, s]

    parse '[c red]'
    .should.be.eql [1, 'c red']

    parse '[ c  red ]'
    .should.be.eql [1, 'c red']

    parse '[/c red]'
    .should.be.eql [-1, 'c red']

    parse '[  /  c  red  ]'
    .should.be.eql [-1, 'c red']


  it 'Mixes text and tags', ->

    parse 'Q[w]e[/r]t'
    .should.be.eql [0, 'Q', 1, 'w', 0, 'e', -1, 'r', 0, 't']

    parse 'Hello, [ i ]world[ / i'
    .should.be.eql [0, 'Hello, ', 1, 'i', 0, 'world', -1, 'i']

  it 'Quotes HTML in text and tags', ->

    parse 'a<b>c'
    .should.be.eql [0, "a&lt;b&gt;c"]

    parse '[ x&x ]'
    .should.be.eql [1, "x&amp;x"]

    parse '"[ p&g]"'
    .should.be.eql [0, '&quot;', 1, 'p&amp;g', 0, '&quot;']

  it 'uses backslashes to quote', ->

    parse 'x\\[y\\]z'
    .should.be.eql [0, 'x[y]z']

    parse 'word\\'
    .should.be.eql [0, 'word']

    parse 'x[y\\i]z'
    .should.be.eql [0, 'x', 1, 'y\\i', 0, 'z']

  it 'requires tag start with letter or asterisk', ->

    parse s = ' а [я] против! '
    .should.be.eql [0, s]

    parse s = ' и [я'
    .should.be.eql [0, s]

    parse s = ' numbers [4]'
    .should.be.eql [0, s]

    parse s = ' dots [...]'
    .should.be.eql [0, s]

    parse  '<[*a]![/*a]>'
    .should.be.eql [0, '&lt;', 1 , '*a', 0, '!', -1, '*a', 0, '&gt;']
