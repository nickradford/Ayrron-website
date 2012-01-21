Template = require 'template'

module.exports = class Image extends Backbone.View
  constructor: (obj) -> 
    @el = $ "<span></span>"
    @obj = obj
    
  render: (within) -> 
    @el.html new Tmpl(data: @obj).root()
    if within?
      within.append @el
  
  class Tmpl extends Template
    root:
      '''
        <image src='<%= tmpl.data.image_path %>'/>
      '''