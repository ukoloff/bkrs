py = require '../lib/py'

split = py.split

describe 'PY splitter', ->

  it 'converts string to array', ->
    split 'abc'
    .should.eql ['abc']

    split ' abc def '
    .should.eql ['abcdef']

    split 'abc, def'
    .should.eql ['abc', 'def']

    split 'qwe, a s d; zxc'
    .should.eql ['qwe', 'asd', 'zxc']

  it 'ignores DSL [tag]s', ->

    split 'hi [b] there [/b]'
    .should.eql ['hi']

    split 'one, two [i] or [/i] three'
    .should.eql ['one', 'two', 'three']
