#
# Simple async loop
#

module.exports = (list, fn)->
  list = list.slice()
  do step = ->
    fn list.shift(), step if list.length
