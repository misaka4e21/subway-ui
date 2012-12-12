fs=require('fs')
events=require('events')
#coffeekup=require('coffeekup')
ck=require('ck')
###
class Extension extends events.EventEmitter
  constructor:(@name,@div,@options={})->
    @path=__dirname+'/'+@name
  #getTemplate:(data={},tplFileName='template.coffee')->
    #code=fs.readFileSync(@path+'/'+tplFileName)
    #coffeekup.render(code.toString(),data)

  getHtml:->
    @main=require(@path+'/index.coffee')
    data=@main.getData(@options)
    data.ext=this
    #data.main=@main
    ck.compileFile(@path+'/template.coffee')(context:data)
###

class Extension extends events.EventEmitter
  constructor: (@options)->

  makeTemplate: (template)->
    ck=require 'ck'
    ck.compile(template)(context:@options)
  afterInsert: ->

Extension.factory = ($,extContainer,opts)->
  extName=opts.module
  extClass=require(__dirname+"/#{extName}/index.coffee").Main
  Extension.exts ?= []
  extIndex=Extension.exts.push(new extClass(opts)) - 1
  ext=@exts[extIndex]
  extId="ext-#{extName}-#{extIndex}"
  extContainer.append "<div id='#{extId}' "+
     (if opts.style? then "style='#{opts.style}' " else '')+
                      "class='span3 ext-div' >#{ext.getTemplate()}</div>"
  ext.afterInsert($,extId)

exports.Extension=Extension
