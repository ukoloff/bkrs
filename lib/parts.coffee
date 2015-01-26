#
# Define BKRS sources
#

resolvable = (file)->
  try
    require.resolve file
    true
  catch

for part in ['dabkrs', 'dabruks', 'examples']
  @[part] = if resolvable file = "./#{part}"
    require file
  else
    {}
