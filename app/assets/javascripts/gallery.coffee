Template = require 'template'
Image    = require 'image'

module.exports = class Gallery extends Backbone.View  
  constructor: (@obj) -> 
    @el = $ "<li class='gallery' data-gallery-id='#{@obj.id}'></li>"
    @_images = @obj.images
    init_images @
    
    @el.mouseenter () => @extraInfo.slideDown()
    @el.mouseleave () => @extraInfo.slideUp()  

       
  render: (within)-> 
    @el.html new Tmpl(data: @obj, images: @images).root()
    if within?
      within.append @el
      
    @extraInfo = $ "li[data-gallery-id='#{@obj.id}'] span.gallery_num_images"
    @imageHolder = $ "li[data-gallery-id='#{@obj.id}'] div.gallery_image"
    
    # Put an image in!
    fixImage = => 
      console.log '@images', @images
      return if @images.length is 0
      image = @images[0]
      console.log 'image', image
      image.render @imageHolder
    
    fixImage()
    

  
  class Tmpl extends Template
    root:
      '''
      <div class='gallery_image'></div> 
      <div class='gallery_title'><%= tmpl.data.title %></div>
      <span class='gallery_num_images'><%= tmpl.data.images.length %>
      <% if (tmpl.data.images.length === 1) { %> image <% } else { %> images <% } %></span>      
      '''
      
init_images = (obj) -> 
  obj.images = []
  _(obj._images).each (image) -> 
    i = new Image(image)
    obj.images.push i