#
# Show benchmark
#

start = null

module.exports = ->
  start ||= new Date()
  sec = Math.round (new Date()-start)/1000
  min = Math.floor sec/60
  sec -= min*60
  "[#{i2 min}:#{i2 sec}]"

i2 = (n)->
  r = String n
  "#{if r.length<2 then '0' else ''}#{r}"
