class AirQualityFacade

  def initialize(country)
    @country = country
  end

  def air_quality_service
    AirQualityService.new
  end

  def country_service
    CountryService.new
  end

  def big_air_quality
    AirQuality.new(air_quality(get_coordinates))
  end

  def get_coordinates
    country_service.get_coordinates(@country)
  end

  def air_quality(coordinates)
    air_quality_service.get_air_quality(coordinates)
  end

end