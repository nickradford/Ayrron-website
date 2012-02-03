class GalleryController < ApplicationController
  # GET /galleries
  # GET /galleries.json
  def index
    @galleries = Gallery.all
    
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @gallery.to_json(:include => :images) }
    # end
  end

  def show
  end

  def new
  end

  def edit
  end

  def create
  end

  def update
  end

  def destroy
  end

end
