class AirQualitySerializer
  include JSONAPI::Serializer

  attributes  :aqi,
              :datetime,
              :readable_aqi

end