class TimezonesController < ApplicationController
  include TimezonesHelper
  before_action :set_timezone, only: [:show, :edit, :update, :destroy]
  @@theme = "black-theme"

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

  private
    # Only allow a list of trusted parameters through.
    def timezone_params
      params.require(:timezone).permit(:value, :abbr, :offset, :isdst, :text, :utc)
    end
end
