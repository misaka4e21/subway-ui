Extension=require('../index.coffee').Extension
class exports.Main extends Extension
  constructor:(@options)->
    @options.cpus=require('os').cpus()
  getTemplate: ->
    @makeTemplate ->
     for cpu,i in @cpus
       h3 -> "CPU #{i}"
       table ->
         tr ->
           td -> "型號"
           td -> cpu.model
         tr ->
           td -> "頻率"
           td -> "#{cpu.speed} MHz"

  afterInsert: ($,extId)->
