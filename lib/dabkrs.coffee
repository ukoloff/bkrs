#
# Special processing for zh->ru source
#
py = require './py'
s2t = require './s2t'
examples = require './examples'

@order = 1

@article = (arr)->
  return if '_'==arr[1]

  py.add arr
  s2t.add arr

  @queue arr.concat examples.for arr[0]
