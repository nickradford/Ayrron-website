Template = require 'template'

module.exports = class Image extends Backbone.View
  constructor: (obj) -> 
    @el = $ "<span></span>"
    @obj = obj
    @tmpl = new Tmpl(data: @obj)
    @el.html @tmpl.root()
    
    
  render: (within) => 
    if within?
      within.append @el
    else
      @el.html()
  
  renderGallery:  => 
    @tmpl.gallery_full()
  
  class Tmpl extends Template
    root:
      '''
        <image class='gallery_image' src='<%= tmpl.data.image_path %>'/>
      '''
    gallery_full:
      '''
        <li class='gallery_full_image'>
          <%= tmpl.root() %>
        </li>
      '''
      
    info:
      '''
        Image info goes here.
      '''
      