exports.getData=(options={})->
  os=require('os')
  forDight=(dight,how)->
    Math.round(dight*Math.pow(10,how))/Math.pow(10,how)
  unless options.unit? then options.unit="MiB"
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
  freemem: "#{convertUnit["to#{options.unit}"](os.freemem())} #{options.unit}"
  totalmem: "#{convertUnit["to#{options.unit}"](os.totalmem())} #{options.unit}"
