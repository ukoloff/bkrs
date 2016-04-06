#
# Stream to convert UTF-8 to UTF16-LE
#
through2 = require 'through2'

module.exports = ->
  through2 (data, enc, cb)->
    cb null, new Buffer data.toString('utf8'), 'utf16le'
