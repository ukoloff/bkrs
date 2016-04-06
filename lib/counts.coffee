#
# Report articles counts
#

yaml = require 'js-yaml'

counts = false

module.exports = fn = (k, v)->
  counts = start: new Date  unless counts
  counts[k] = v

  fn.report = ->
    console.log yaml.dump counts
