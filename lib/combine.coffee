fs = require 'fs'
through = require 'through'
config = require '../package'
async = require './async'

result = fs.createWriteStream 'src/bkrs.txt'

async config.sources.concat(config.extras), (file, done)->
  fs.createReadStream "src/#{file}"
  .on 'end', done
  .pipe through(null, ->)
  .pipe result

console.log "That's all folks!"
