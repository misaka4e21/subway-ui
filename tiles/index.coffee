fs=require('fs')
coffeekup=require('coffeekup')
class Tile
  constructor:(@name,@div,@options={})->
    @path=__dirname+'/'+@name
  getTemplate:(data={},tplFileName='template.coffee')->
    code=fs.readFileSync(@path+'/'+tplFileName)
    coffeekup.render(code.toString(),data)
  updateDiv:->
    main=require(@path+'/index.coffee')
    @div.html(@getTemplate(main.getData(@options)))
exports.Tile=Tile
