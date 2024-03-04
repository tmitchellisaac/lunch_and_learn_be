class AirQuality 
  attr_reader :aqi,
              :datetime,
              :readable_aqi,
              :id

  def initialize(data)
    @id = nil
    @aqi = data[:main][:aqi]
    @datetime = data[:dt]
    @readable_aqi = readable_aqi_value[@aqi]
  end

  private

  def readable_aqi_value
    ["N/A", "Good", "Fair", "Moderate", "Poor", "Very Poor"]
  end

end