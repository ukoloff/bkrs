#
# Convert DSL [tag]s to zd <tag>s
#

path = require 'path'
yaml = require 'js-yaml'

defaults =
  path:  path.join __dirname, '../tags'
  default: process.env.npm_config_tags or 'default'
  group: 'tags'

module.exports = tag = (tag, options)->

  options = merge defaults, options

tag.options = defaults

merge = ->
  r = {}
  for x in arguments when x
    for k, v of x
      r[k] = v
  r
