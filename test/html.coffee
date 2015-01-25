q = require '../lib/html'

describe 'HTML quoting', ->

  it 'escapes <, >, & and "', ->

    q 'a < b > c & d " e'
    .should.equal "a &lt; b &gt; c &amp; d &quot; e"

    q 'a > b > c'
    .should.equal "a &gt; b &gt; c"

    q s=' !@#$%^*()_-+=\'[]{};:?/.,'
    .should.equal s
