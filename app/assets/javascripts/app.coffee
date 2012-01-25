GalleryView = require 'gallery'

# class GalleryView extends Backbone.View

class Gallery extends Backbone.Model
  constructor: (args) -> 
    super args
    @view = new GalleryView @attributes
  

class GalleryCollection extends Backbone.Collection
  model: Gallery
  url: '/gallery.json'
  
class GalleryListView extends Backbone.View
  constructor: (@galleries) -> 
    @el = $('div.container')
  
  render: -> 
    @el.fadeOut 400, => 
      @el.children('ul').html ''
      _(@galleries).each (gallery) => 
        gallery.view.render $ 'ul.gallery_container'
      @el.fadeIn 400


module.exports = class Application extends Backbone.Router
  routes: 
    '/index' : 'index'
    '/gallery/:title' : 'gallery'
    '*other': 'index'
  
  constructor: (args) -> 
      super args
      @attributes = args
      @galleries = new GalleryCollection()
      @render()
      
      galleryContainer = $ 'ul.gallery_container'
      
      # Wire up events.
      $('h1.title').bind 'click', (e) => 
        galleryContainer.fadeOut 400, =>
          galleryContainer.html ''
          window.app.navigate '/index'
          galleryInfo = $('.app_gallery_info')
          galleryInfo.fadeOut 400, => 
            galleryInfo.html ''
            galleryInfo.show()
            @index()
            galleryContainer.fadeIn 400
      
  render: -> 
    $('h1.title').html @attributes.title
 
  
  
  index: -> 
    @galleries.fetch 
      success: => new GalleryListView(@galleries.models).render()
      error: => console.log 'Error'

  gallery: (title) -> 
    @galleries.fetch
      success: => 
        gal = _(@galleries.models).find (gallery) -> return gallery.get('title') is title 
        gal.view.renderGallery $ 'ul.gallery_container'