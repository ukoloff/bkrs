#
# Special processing for examples
#

@article = (arr)->
  # Require cyrillic in definition
  return unless arr.slice(1).some (s)->/[\u0400-\u04ff]/.test s

  @queue arr
