
class PostsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :edit, :create, :destroy]
  before_filter :check_ownage, only: [:edit, :destroy]
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all



  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])
    f= open("#{root_url}#{@post.image}")
    @picture = EXIFR::JPEG.new(f)
    @latitude=convert_to_google(@picture.exif.to_hash[:gps_latitude],
                                @picture.exif.to_hash[:gps_latitude_ref])
    @longitude=convert_to_google(@picture.exif.to_hash[:gps_longitude],
                                 @picture.exif.to_hash[:gps_longitude_ref])

    if geo = Geocoder.search("#{@latitude},#{@longitude}").first
      @city = geo.city || ""
      @state = geo.state || ""
      @zipcode = geo.postal_code || ""
    end

    # and in the view : <% @picture.exif.to_hash.each do |key, value| %>
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post].merge!(:user => current_user))
    if @post.save
      flash[:notice] = 'Your post has been created.'
      redirect_to root_path
    else
      render action: "new"
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :no_content }
    end
  end

  private

    def check_ownage
      @post = Post.find(params[:id])
      unless @post.user == current_user
        flash[:error] = "You can only edit your own Posts!"
        redirect_to root_path
      end
    end

    def convert_to_google(gpsdata, gpsref)
      degree = gpsdata[0].to_f
      minutes = gpsdata[1].to_f/60
      seconds =gpsdata[2].to_f/3600

      gpsvalue = degree+minutes+seconds
      if gpsref == 'S'
        gpsvalue = gpsvalue  # bei Nord oder West sind die Grade negativ
      end
    end

end
