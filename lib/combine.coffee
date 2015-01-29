fs = require 'fs'
through = require 'through'
config = require '../package'
async = require './async'

console.log 'Creating full dictionary source...'

result = fs.createWriteStream 'src/bkrs.txt'

async
  list: config.sources.concat config.extras
  step: (file, done)->
    fs.createReadStream "src/#{file}"
    .on 'end', done
    .pipe through(null, ->)
    .pipe result
  end: ->
