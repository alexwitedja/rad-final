class ClocksController < ApplicationController
    include TimezonesHelper
  
    def create
      @clock = Clock.new(clock_params)
      if !@clock.valid?
        # Check uniqueness
        flash[:danger] = "You already have that clock."
      else
        if isUTC(@clock.city)
          utc = getUTC(@clock.city)
          @timezone = Timezone.where("lower(text) LIKE '%#{utc.downcase}%'")
          if @timezone.empty?
            flash[:danger] = "UTC not found"
          else
            @clock.save
            flash[:success] = "UTC clock added"
          end
        else
          cities = checkifexists(@clock.city)
          if @clock.city.empty?
            flash[:danger] = "Don't enter empty."
          elsif cities.empty?
            flash[:danger] = "No city found."
          elsif cities.length > 1
            flash[:danger] = "Too many match, failed to add."
          else
            if validtimezone(@clock.city)
              @clock.save
            else
              @clock.city = cities[0].city
              @clock.save
            end
            flash[:success] = "Found City, added clock."
          end
        end
      end
      
      redirect_to root_path
    end

    def add
      @clock = Clock.new(params.permit(:city))
      cities = checkifexists(@clock.city)
      if !@clock.valid?
        flash[:danger] = "You already have that clock."
      elsif cities.empty?
        flash[:danger] = "No city found."
      else
        if validtimezone(@clock.city)
          @clock.save
        else
          @clock.city = cities[0].city
          @clock.save
        end
        flash[:success] = "Found City, added clock."
      end

      redirect_to root_path
    end
  
    def destroy
      Clock.find(params[:id]).destroy
      flash[:success] = "Clock Deleted"
      redirect_back(fallback_location: root_path)
    end
  
    private
  
      # Only allow a list of trusted parameters through.
      def clock_params
        params.require(:clock).permit(:city)
      end
  end
  