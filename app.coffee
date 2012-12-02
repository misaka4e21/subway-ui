#!/home/xyh/bin/coffee --nodejs --harmony
app=require "appjs"
require("coffee-script")
app.serveFilesFrom(__dirname+'/content')
window = app.createWindow(
  width:640
  height:480
  icons: __dirname+'/content/icons'
)
window.on 'create',->
  console.log 'Window Created'
  window.frame.show()
  window.frame.center()
window.on 'ready', ->
  @require=require
  @process = process
  @module=module
  console.log 'Window Ready'
  F12=(e)->e.keyIdentifier is 'F12'
  window.addEventListener 'keydown', (e)->
    if F12(e)
      window.frame.openDevTools()
window.on 'close', ->
  console.log 'Window Close'
