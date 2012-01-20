Template = require 'template'

module.exports = class Image extends Backbone.View
  constructor: (obj) -> 
    @el = $ "<li></li>"
    @obj = obj
    
  render: (within) -> 
    @el.html new Tmpl().root()
    if within?
      within.append @el
  
  class Tmpl extends Template
    root:
      '''
        <image src='/assets/rails.png'/>
      '''