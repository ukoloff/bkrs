#
# Assemble generated files into single source
#
fs = require 'fs'
through = require 'through'
seq = require './seq'
log = require './log'

log "Creating full dictionary source..."

result = fs.createWriteStream 'src/bkrs.txt'

seq require './reorder'
.step (i, file, done)->
  fs.createReadStream "src/#{file}"
  .on 'end', done
  .pipe through(null, ->)
  .pipe result
.done ->
  do require './dumpz'
  .report
  log "That's all folks!"
