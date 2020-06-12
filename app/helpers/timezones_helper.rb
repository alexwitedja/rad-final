module TimezonesHelper
  @@default = 'Melbourne'
  @@timezones = ['Melbourne', 'Tokyo', 'Hawaii']

  def isdefault(city)
    time = Time.use_zone(city) { Time.current }
    default = Time.use_zone(@@default) { Time.current }
    if time.zone == default.zone
      return true
    else
      return false
    end
  end
  
  def getmode(city)
    time = Time.use_zone(city) { Time.current }
    hour = time.hour
    
    if hour >= 9 and hour < 18
      return "Business_Time"
    elsif hour >= 18 and hour < 20
      return "Business_Overtime"
    elsif hour >= 8 and hour < 9
      return "Personal_Time"
    elsif hour >= 20 and hour < 23
      return "Personal_Time"
    else
      return "Sleeping_Time"
    end
  end

  def gettimezones
    return Clock.all
  end

  def formattime(city)
    time = Time.use_zone(city) { Time.current }
    hour = time.hour
    minutes = time.min

    return '%02d:%02d' % [hour, minutes]
  end

  def determinetoday(city)
    default_day = Time.use_zone(@@default) { Time.current }
    time_day = Time.use_zone(city) { Time.current }
    if time_day.day == default_day.day
      return "Today"
    elsif default_day.day < time_day.day
      return "Tomorrow"
    else
      return "Yesterday"
    end
  end

  def determinedifference(city)
    default_day = Time.use_zone(@@default) { Time.current }
    time_day = Time.use_zone(city) { Time.current }

    diff_in_seconds = time_day.utc_offset - default_day.utc_offset

    return (diff_in_seconds/60/60)
  end

  def checkifexists(city)
    cities = City.where("lower(city) LIKE '%#{city.downcase}%'")
  end

  def isUTC(utc)
    utc.include? "UTC"
  end

  def getUTC(utc)
    @utc = utc
    if utc.length == 6
      @utc = utc
    elsif utc.length == 5
      @utc.insert(-2, '0')
    else
      return "Error, wrong UTC format."
    end
    return @utc
  end

  def gettimezone(utc)
    timezone = Timezone.where("lower(text) LIKE '%#{utc.downcase}%'")
    return timezone[0].utc[0]
  end

  def validtimezone(city)
    city.strip!
    return city if ActiveSupport::TimeZone::MAPPING.key?(city)

    timezone = ActiveSupport::TimeZone::MAPPING.invert[city]
    timezone.present?
  end
end
