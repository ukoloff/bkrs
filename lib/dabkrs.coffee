#
# Special processing for zh->ru source
#
py = require './py'
s2t = require './s2t'
examples = require './examples'

@article = (arr)->
  return if '_'==arr[1]

  py.add arr[0], arr[1]
  s2t.add arr[0]

  @queue arr.concat examples.for arr[0]
