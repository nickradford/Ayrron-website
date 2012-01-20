Template = require 'template'
Image    = require 'image'

module.exports = class Gallery extends Backbone.View  
  constructor: (@obj) -> 
    @el = $ "<div class='gallery' data-gallery-id='#{@obj.id}'></div>"
    @_images = @obj.images
    init_images @
    
  render: (within)-> 
    @el.html new Tmpl(data: @obj, images: @images).root()
    if within?
      within.append @el
      
    @elImages = $ "div[data-gallery-id='#{@obj.id}'] ul.images"
    _(@images).each (image) =>
      image.render(@elImages)
  
  class Tmpl extends Template
    root:
      '''
      <h1><%= tmpl.data.title %></h1>
      <h2><%= tmpl.data.description %></h2>
      <ul class='images'></ul>
      <hr/>
      '''
      
init_images = (obj) -> 
  obj.images = []
  _(obj._images).each (image) -> 
    i = new Image(image)
    obj.images.push i