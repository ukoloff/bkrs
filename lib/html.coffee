#
# HTML quoting
#

htmls =
  '&': '&amp;'
  '<': '&lt;'
  '>': '&gt;'
  '"': '&quot;'

module.exports = (s)->
  String s
  .replace /[&<>"]/g, (e)->htmls[e]
