#
# Stream to output article(s)
#

through = require 'through'

module.exports = ->

  through (art)->
    word = art.shift().replace /\s+/, ' '
    if 1==art.length
      art = art[0]
    else
      art = art.map (s)-> "<div>#{s}</div>"
      .join ''
    @queue "#{word}  #{art}\n"
