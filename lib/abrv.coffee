#
# Convert abbreviations
#

fs = require 'fs'
split = require './split'
dumpz = require './dumpz'
log = require './log'

log "Converting abbreviations..."

fs.createReadStream "extras/abrv.dsl"
.pipe split (arr)-> @queue arr
.pipe dumpz()
.on 'end', -> require './extras'
.pipe fs.createWriteStream "src/abbreviations.#{dumpz.ext}"
