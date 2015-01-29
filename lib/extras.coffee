#
# Run extras generations
#
seq = require './seq'
extras = require '../package'
  .extras

seq extras
.step (x, done)->
  console.log "Creating #{x}..."
  require "./#{x}"
  .save done
.done ->
  require './combine'
