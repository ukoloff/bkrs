#
# Simple async loop
#

module.exports = (list)->
  fn = null
  done = null
  list = if Array.isArray list
    ([i, x] for x, i in list)
  else
    ([k, v] for k, v of list)
  do step = ->
    setImmediate ->
      if list.length
        pair = list.shift()
        fn? pair[0], pair[1], step
      else
        done?()
  step: (cb)->
    fn = cb
    @
  done: (cb)->
    done = cb
    @
