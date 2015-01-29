#
# Special processing for zh->ru source
#
py = require './py'

@article = (arr)->
  return if '_'==arr[1]

  py.add arr[0], arr[1]

  @queue arr
