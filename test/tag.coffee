path = require 'path'
tag = require '../lib/tag'

tag.options.path = path.join __dirname, 'tags'
tag.options.default = 'test'

describe 'Tag mapper', ->

  it '...', ->

