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
      opts = 
        lines: 12 # The number of lines to draw
        length: 7 # The length of each line
        width: 4 # The line thickness
        radius: 10 # The radius of the inner circle
        color: '#AAA' # rgb or #rrggbb
        speed: 1 # Rounds per second
        trail: 60 # Afterglow percentage
        shadow: false # Whether to render a shadow
      @spinner = new Spinner opts
      @target = $('#spinner')[0]

      
      galleryContainer = $ 'ul.gallery_container'
      
      # Wire up events.
      $('h1.title').bind 'click', (e) => 
        @spin => 
          galleryContainer.fadeOut 400, =>
            galleryContainer.html ''
            window.app.navigate '/index'
            galleryInfo = $('.app_gallery_info')
            galleryInfo.fadeOut 400, => 
              galleryInfo.html ''
              galleryInfo.show()
              @index()
              galleryContainer.fadeIn 400, => @stop()
      
  render: -> 
    $('h1.title').html @attributes.title
 
  spin: (callback) =>
    @spinner.spin @target
    callback?()
    
  stop: => 
    @spinner.stop()
  
  index: ->
    @spin => 
      @galleries.fetch 
        success: => 
          new GalleryListView(@galleries.models).render()
          @stop()
        error: => 
          console.log 'Error'
          @stop()

  gallery: (title) -> 
    @spin => 
      @galleries.fetch
        success: => 
          gal = _(@galleries.models).find (gallery) -> return gallery.get('title') is title 
          gal.view.renderGallery $ 'ul.gallery_container'
          @stop()