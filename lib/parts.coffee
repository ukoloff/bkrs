resolvable = (file)->
  try
    require.resolve file = "./#{part}"
    true
  catch

for part in ['dabkrs', 'dabruks', 'examples']
  @[part] = if resolvable file = "./#{part}"
    require file
  else
    {}
