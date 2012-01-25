Template = require 'template'
Image    = require 'image'

module.exports = class GalleryView extends Backbone.View  
  constructor: (@obj) -> 
    @el = $ "<li class='gallery' data-gallery-id='#{@obj.id}'></li>"
    @_images = @obj.images
    init_images @
    
    # Wire up events.
    @el.mouseenter () => @elDescription.slideDown(400)
    @el.mouseleave () => @elDescription.slideUp(400)
    
    # @el.on 'click', -> alert 'Click'
    @el.click () => 
      @within.fadeOut 600, =>
        window.app.navigate '/gallery/' + @obj.title
        galleryInfo = $('.app_gallery_info')
        galleryInfo.html @tmpl.info()
        galleryInfo.fadeIn 400, =>
          @within.html @tmpl.gallery()
          @within.fadeIn 400
      
      
  reset: -> 
    @within.fadeOut()
    @within.html('')
       
  render: (@within)-> 
    @tmpl = new Tmpl(data: @obj, images: @images)
    @el.hide()
    @el.html @tmpl.overview()
    if @within?
      @within.append @el
      
    @elDescription = $ "li[data-gallery-id='#{@obj.id}'] div.gallery_description"
    @imageHolder = $ "li[data-gallery-id='#{@obj.id}'] div.gallery_image"
    
    # Put an image in!
    fixImage = (callback) => 
      return callback?() if @images.length is 0
      image = @images[0]
      image.render @imageHolder
      
      callback?()
    
    fixImage => @el.fadeIn(1000)
    
    @
    
  renderGallery: (@within) -> 
    @tmpl = new Tmpl(data: @obj, images: @images)
    @within.html @tmpl.gallery()
    

  
  class Tmpl extends Template
    overview:
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
    info:
      '''
      <div class='gallery_title'><%= tmpl.data.title %></div>
      <div class='gallery_description'><%= tmpl.data.description %></div>
      '''
    gallery:
      '''
      <% _(tmpl.images).each(function(image) { %>
        <%= image.renderGallery() %>
      <% }); %>
      '''
      
      
      
      
init_images = (obj) -> 
  obj.images = []
  _(obj._images).each (image) -> 
    i = new Image(image)
    obj.images.push i