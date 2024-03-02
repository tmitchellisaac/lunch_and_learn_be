class Recipe  
  attr_accessor :title,
                :url,
                :country,
                :image,
                :id

  def initialize(json_response, country)
    @id = nil
    @title = json_response[:recipe][:label]
    @url = json_response[:recipe][:url]
    @country = country
    @image = json_response[:recipe][:image]
  end
end