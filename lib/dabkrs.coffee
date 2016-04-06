#
# Special processing for zh->ru source
#
py = require './py'
s2t = require './s2t'
examples = require './examples'

@order = 1

@article = (arr)->
  return if arr[1] in ['_', '-']
  return if 3==arr.length and arr[2] in ['-', '[m1]-[/m]']

  py.add arr
  s2t.add arr

  @push arr.concat examples.for arr[0]
