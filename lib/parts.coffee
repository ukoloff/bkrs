for part in ['dabkrs', 'dabruks', 'examples']
  @[part] = try
    require "./#{part}"
  catch e
    {}
