#
# Simple async loop
#

module.exports = (list)->
  fn = null
  done = null
  list = list.slice()
  do step = ->
    process.nextTick ->
      if list.length
        fn? list.shift(), step
      else
        done?()
  step: (cb)->
    fn = cb
    @
  done: (cb)->
    done = cb
    @
