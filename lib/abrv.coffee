#
# Convert abbreviations
#

fs = require 'fs'
split = require './split'
dumpz = require './dumpz'
log = require './log'

log "Converting abbreviations..."

fs.createReadStream "extras/abrv.dsl"
.pipe do split
.pipe dumpz 'abbr'
.on 'end', -> require './extras'
.pipe fs.createWriteStream "src/abbreviations.#{dumpz.ext}"
