#
# Show benchmark
#

start = new Date()

module.exports = (msg)->
  sec = Math.round (new Date()-start)/1000
  min = Math.floor sec/60
  sec -= min*60
  console.log "[#{min}:#{i2 sec}]#{msg}"

i2 = (n)->
  r = String n
  "#{if r.length<2 then '0' else ''}#{r}"
