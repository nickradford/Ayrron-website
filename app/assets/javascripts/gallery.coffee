Template = require 'template'
Image    = require 'image'

module.exports = class Gallery extends Backbone.View  
  constructor: (@obj) -> 
    @el = $ "<li class='gallery' data-gallery-id='#{@obj.id}'></li>"
    @_images = @obj.images
    init_images @
    
    @el.mouseenter () => @elDescription.slideDown(400)
    @el.mouseleave () => @elDescription.slideUp(400)  

       
  render: (within)-> 
    @el.html new Tmpl(data: @obj, images: @images).root()
    if within?
      within.append @el
      
    @elDescription = $ "li[data-gallery-id='#{@obj.id}'] div.gallery_description"
    @imageHolder = $ "li[data-gallery-id='#{@obj.id}'] div.gallery_image"
    
    # Put an image in!
    fixImage = => 
      return if @images.length is 0
      image = @images[0]
      image.render @imageHolder
    
    fixImage()
    

  
  class Tmpl extends Template
    root:
      '''
      <div class='gallery_image'></div> 
      <div class='gallery_title'><%= tmpl.data.title %></div>
      <div class='gallery_description'>
        <div>
          <%= tmpl.data.images.length %><% if (tmpl.data.images.length === 1) { %> image <% } else { %> images <% } %>
        </div>
        <div>
          <%= tmpl.data.description %>
        </div>
        </div> 
      '''
      
init_images = (obj) -> 
  obj.images = []
  _(obj._images).each (image) -> 
    i = new Image(image)
    obj.images.push i