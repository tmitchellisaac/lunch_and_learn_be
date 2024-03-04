class AirQualityFacade

  def initialize(params)
    @params = params
    @country = params[:country]
  end

  def weather_service
    AirQualityService.new
  end

  def country_service
    CountryService.new
  end

  def big_air_quality
    get_coordinates # [77, 99]
    AirQuality.new(air_quality(get_coordinates))
  end

  def get_coordinates
    country_service.get_coordinates(@country)
  end


  def air_quality(coordinates)
    weather_service.get_air_quality(coordinates)
  end

end