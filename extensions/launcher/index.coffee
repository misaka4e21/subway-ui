Extension=require('../index.coffee').Extension
class exports.Main extends Extension
  getTemplate: ->
    @makeTemplate ->
      div class:'metro span9', ->
        for {name,command,icon,color} in @programs
          div class:'metro-sections',->
            a class:'tile app'+(if color? then " bg-color-#{color}" else ''),href:'#','data-command':command,'data-name':name,->
              if icon?
                div class:'image-wrapper',->
                  img src:icon
              div class:'app-label',name
  afterInsert: ($,extId)->
    self=@
    $(extId).ready ->
      $(@).find('div.metro > div.metro-sections > a.tile').on 'click', ->
        self.run($(@).data('command'))
    return
  run: (command)->
    cp=require('child_process')
    cp.exec command,(error,stdout,stderr)->
      if error isnt null
        console.log 'Command Failed'+error
