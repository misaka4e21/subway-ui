Extension=require('../index.coffee').Extension
class exports.Main extends Extension
  
  constructor: (@options)->
    super(@options)
    unless @options.unit? then @options.unit="MiB"
    @updateMem()
    setInterval (=>
      @updateMem()
    ),1000

  forDight=(dight,how)->
    Math.round(dight*Math.pow(10,how))/Math.pow(10,how)
  convertUnit=
    toMiB:(bytes)->
      forDight(bytes/1048576,2)
    toKiB:(bytes)->
      forDight(bytes/1024,2)
    toGiB:(bytes)->
      forDight(bytes/(1024*1024*1024),2)
    toBytes:(bytes)-> bytes
    toMB:(bytes) -> forDight(bytes/1000000,2)
    toKB:(bytes) -> forDight(bytes/1000,2)
    toGB:(bytes) -> forDight(bytes/1000000000,2)

  convertMem:(mem)-> "#{convertUnit["to#{@options.unit}"](mem)} #{@options.unit}"
  getTemplate: ->
    @makeTemplate ->
      h3 -> "內存"
      table ->
        tr ->
          td -> "剩餘內存"
          td class:'freemem',-> @freemem
        tr ->
          td -> "總內存"
          td class: 'totalmem',-> @totalmem

  updateMem: ->
    os=require('os')
    freemem=os.freemem()
    totalmem=os.totalmem()
    if not (@freemem? and @totalmem?)
      @freemem=freemem
      @totalmem=totalmem
      @options.freemem= @convertMem(@freemem)
      @options.totalmem=@convertMem(@totalmem)
    else
      if @freemem != freemem or @totalmem !=totalmem
        @freemem=freemem
        @totalmem=totalmem
        @options.freemem= @convertMem(@freemem)
        @options.totalmem=@convertMem(@totalmem)
        @emit('html-updated')
  afterInsert: ($,extId)->
    self=@
    @on 'html-updated', ->
      $(extId).ready ->
        $(@).find('td.freemem').html(self.options.freemem)
        $(@).find('td.totalmem').html(self.options.totalmem)

