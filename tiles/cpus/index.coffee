exports.getData=()->
  os=require('os')
  {cpus: os.cpus()}
