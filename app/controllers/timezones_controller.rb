class TimezonesController < ApplicationController
  include TimezonesHelper
  before_action :set_timezone, only: [:show, :edit, :update, :destroy]
  @@theme = "black-theme"

  # GET /timezones
  # GET /timezones.json
  def search
    @cities = City.order(:city).where("lower(city) like ?", "%#{params[:term].downcase}%")
    render json: @cities.map(&:city)
  end

  def index
    @clock = Clock.new
    @timezones = gettimezones
    @theme = @@theme
  end

  def set
    @@theme = params[:theme]
    redirect_to root_path
  end

  # GET /timezones/1
  # GET /timezones/1.json
  def show
  end

  # GET /timezones/new
  def new
    @timezone = Timezone.new
  end

  # GET /timezones/1/edit
  def edit
  end

  # POST /timezones
  # POST /timezones.json
  def create
    @timezone = Timezone.new(timezone_params)

    respond_to do |format|
      if @timezone.save
        format.html { redirect_to @timezone, notice: 'Timezone was successfully created.' }
        format.json { render :show, status: :created, location: @timezone }
      else
        format.html { render :new }
        format.json { render json: @timezone.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /timezones/1
  # PATCH/PUT /timezones/1.json
  def update
    respond_to do |format|
      if @timezone.update(timezone_params)
        format.html { redirect_to @timezone, notice: 'Timezone was successfully updated.' }
        format.json { render :show, status: :ok, location: @timezone }
      else
        format.html { render :edit }
        format.json { render json: @timezone.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /timezones/1
  # DELETE /timezones/1.json
  def destroy
    @timezone.destroy
    respond_to do |format|
      format.html { redirect_to timezones_url, notice: 'Timezone was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_timezone
      @timezone = Timezone.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def timezone_params
      params.require(:timezone).permit(:value, :abbr, :offset, :isdst, :text, :utc)
    end
end
