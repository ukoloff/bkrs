#
# Assemble generated files into single source
#
fs = require 'fs'
multistream = require 'multistream'

parts = require './reorder'
dumpz = require './dumpz'
log = require './log'
counts = require './counts'

log "Creating Dictan source..."

multistream parts.map (file)->
  fs.createReadStream "src/#{file}"
.pipe fs.createWriteStream "src/articles.#{dumpz.ext}"
.on 'finish', ->
  do dumpz.report
  log "That's all folks!"
  do counts.report
