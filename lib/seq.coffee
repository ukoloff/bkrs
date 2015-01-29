#
# Simple async loop
#

module.exports = (options)->
  list = options.list.slice()
  do step = ->
    if list.length
      options.step? list.shift(), step
    else
      options.end?()
