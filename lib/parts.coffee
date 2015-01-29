#
# Define BKRS sources
#

sources = require '../package'
  .sources

resolvable = (file)->
  try
    require.resolve file
    true
  catch

for part in sources
  @[part] = if resolvable file = "./#{part}"
    require file
  else
    {}
