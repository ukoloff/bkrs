#
# Get parts in the order for concatenation
#
parts = require './parts'
config = require '../package'

r = []

for k, v of parts
  at = v.order
  if at?
    at = 0 if --at<0
    at = r.length if at>r.length
  else
    at = r.length
  r.splice at, 0, k

module.exports = r.concat config.extras
