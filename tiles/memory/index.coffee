exports.getData=()->
  os=require('os')
  forDight=(dight,how)->
    Math.round(dight*Math.pow(10,how))/Math.pow(10,how)
  toMiB=(bytes)->
    forDight(bytes/1048576,2)
  freemem: "#{toMiB(os.freemem())} MiB"
  totalmem: "#{toMiB(os.totalmem())} MiB"
