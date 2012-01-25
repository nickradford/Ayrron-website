Gallery = require 'gallery'

module.exports = class Application extends Backbone.View
  constructor: (args) -> 
      return unless args.title?
      return unless args.elTitle?
      return unless args.dataUrl?
      
      @title            = args.title
      @elTitle          = args.elTitle
      @dataUrl          = args.dataUrl
      @galleries        = []
      @elGallery        = $ 'ul.gallery_container'
      @elGalleryDetails = $ 'div.app_gallery_info'
      
      # Wire up events.
      @elTitle.click => 
        elements = $ 'div.app_gallery_info, ul.gallery_container'
        console.log 'elements', elements
        elements.fadeOut 400, => 
          @elGallery.html ''
          _(@galleries).each (gallery) =>
            @elGallery.append gallery.el
          @elGallery.fadeIn 600
        
  init: -> 
      
  render: () ->  
      @elTitle.html @title
      $.getJSON @dataUrl, (data) => 
        _(data).each (gallery) =>
           @galleries.push new Gallery(gallery).render @elGallery
