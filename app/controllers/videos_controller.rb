class VideosController < ApplicationController
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  require 'open-uri'
  require 'json'
  def random
    if params["duration"] == nil
      req_duration = "short"
    else
      req_duration = params["duration"]
    end

    videos = Video.where(duration: req_duration)
    
    video_ids = videos.pluck(:id)
    random_id = video_ids.sample 
    @video = Video.find_by_id(random_id)        
  end
  
  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.all
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)
    youtube_id = @video.link.split("v=")[1]
    url = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails%2Cstatistics&id=#{youtube_id}&key=AIzaSyA--GAhoSyhLvaaZrzLvwYIqPxI6WEf0N4&id=dYw4meRWGd4"
    # url = "https://www.googleapis.com/youtube/v3/videos?part=contentDetails%2Cstatistics&id=#{random_id}&key=AIzaSyA--GAhoSyhLvaaZrzLvwYIqPxI6WEf0N4&id=dYw4meRWGd4"
    response = open(url).read
    parsed_data = JSON.parse(response)
    unformatted_duration = parsed_data['items'][0]['contentDetails']['duration']
    if unformatted_duration.include? "H"
      @video.duration = "long"  
    elsif unformatted_duration.include? "M"
      if unformatted_duration.split("T")[1].split("M")[0].to_i > 4
        @video.duration = "long"
      else
        @video.duration = "medium"
      end
    else
      @video.duration = "short"
    end

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:link, :duration)
    end
end
