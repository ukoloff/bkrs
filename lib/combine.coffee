#
# Assemble generated files into single source
#
fs = require 'fs'
through = require 'through'
dumpz = require './dumpz'
seq = require './seq'
log = require './log'

log "Creating full dictionary source..."

result = fs.createWriteStream "src/articles.#{dumpz.ext}"

seq require './reorder'
.step (i, file, done)->
  fs.createReadStream "src/#{file}"
  .on 'end', done
  .pipe through(null, ->)
  .pipe result
.done ->
  do dumpz.report
  log "That's all folks!"
