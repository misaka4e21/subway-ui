exports.getData=(options={})->
  os=require('os')
  {cpus: os.cpus()}
