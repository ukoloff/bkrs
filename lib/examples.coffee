#
# Special processing for examples
#
s2t = require './s2t'

@article = (arr)->
  # Require cyrillic in definition
  return unless arr.slice(1).some (s)->/[\u0400-\u04ff]/.test s

  s2t.add arr[0]

  @queue arr
