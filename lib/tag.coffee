#
# Convert DSL [tag]s to zd <tag>s
#

fs = require 'fs'
path = require 'path'
yaml = require 'js-yaml'

defaults =
  path:  path.join __dirname, '../tags'
  default: process.env.npm_config_tags or 'default'
  group: 'tags'

ymls = {}

module.exports = tag = (tag, options)->
  options = merge defaults, options

  xa = ''
  file = "#{path.join options.path, options.default}.yml"
  yml = ymls[file] ||= yaml.safeLoad fs.readFileSync file

  t = yml
  t = t?[g] for g in options.group.split /\W+/
  unless t = t?[tag]
    t = yml.tag || 'span'
    xa = " x-tag: \"#{tag}\"" unless options.close

  unless Array.isArray t
    t = if t then [t] else []

  t.reverse() if options.close

  t.map (tag)->
    tag = '/'+tag.trim().replace /\s.*/, '' if options.close
    "<"+tag+xa+">"
  .join ''

tag.options = defaults

merge = ->
  r = {}
  for x in arguments when x
    for k, v of x
      r[k] = v
  r
