module.exports = class Store
  store = {}

  @set: (key, value) ->
    store[key] = value
  
  @get: (key) ->
    store[key]


