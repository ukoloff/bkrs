#
# Special processing for zh->ru source
#

fs = require 'fs'
tongwen = require 'tongwen'
tag = require './tag'
py = require './py'

pinyin = {}

@article = (arr)->
  return if '_'==arr[1]

  py.split arr[1]
  .forEach (py)-> (pinyin[py]||=[]).push arr[0]

  @queue arr

tags = {}

getTags = ->
  for n in ['ref', 'wrap']
    for close in [0..1]
      tags["#{n}#{if close then 'x' else ''}"] = tag n, group: 'py', close: close

pyLine = (s)->
  r = "#{tags.ref}#{s}#{tags.refx}"
  st = tongwen.s2t s
  r+=" / #{st}" if st!=s
  "#{tags.wrap}#{r}#{tags.wrapx}"

@eof = ->
  do getTags
  all = for k, v of pinyin
    "#{k}  #{v.map(pyLine).join ''}"
  fs.writeFile "src/py", all.join "\n"
