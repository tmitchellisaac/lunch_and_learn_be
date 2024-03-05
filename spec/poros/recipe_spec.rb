require 'rails_helper'

describe "Recipe PORO" do
  it "creates a Recipe PORO with correct data" do

    country = "Ethiopia"
    json_input = {:recipe=>
    {:uri=>"http://www.edamam.com/ontologies/edamam.owl#recipe_c4a41126c298c233bd8fe30444405670",
     :label=>"Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes",
     :image=>
      "https://edamam-product-images.s3.amazonaws.com/web-img/92d/92de05b764a18716ac07104001b89788?X-Amz-Security-Token=IQoJb3JpZ2luX2VjEFUaCXVzLWVhc3QtMSJHMEUCIQDO3NJhuGGzKWY41iqHerz9jm%2BHEL%2BbiWa9RmFGVe9AOAIgJReazNwVYc7PIERtoMoHtMiLqqsJerYcViUiQYyIWjYquQUIThAAGgwxODcwMTcxNTA5ODYiDDkTXnSyP%2B99WZEKXiqWBagEJRzrpscDQyNugPDinHIsCxPGj9OBr%2B7ZkZRHR8PNtfNUO6o8AjOACwtmTkXsU8yjZpkvqyDgXPPfDHPrO4Jkndhx%2Fqh%2FWR%2BHTgvKDZdNNxZuqQIafqsxzLFgddwNjFQiOD21TdjIYJAPwwftiDHPOpvXtJlfdu1VbqU%2FqPJXM9sJO%2BoKSxExE4ENrruXWiAmPIjHCRLw0AzE7u63EGROyIcx5Y4JcG5l4jyE%2BbwPGsplT04TFHeq%2FesmOQKWOSwVHavfuJQZgNhs9W4VjTFgjadpZdxQ5%2F7GRSKhSNPUvKQcD2x0P2AHFMinta5sAYH%2Bev7Li96ulGfg73JfhOXY7zgg1hDpgMPhKqUg1WR0715WOxneOzvvpsjGbmWFM1VUKbVT6gGZZU2oEN2dZd4iuzhQCLZoErt6On0rwNnHNquvDm1o14BJNsDyIn%2BmgAH6QNzNp4UfxRq2WXxapRKEdtN3Sqzn3bOVCJMeyk6M9jWfwz6x7bvYoWANXTcKc%2BQD%2B3s4WuJ8UcEJYgl0Z8gdQicJzXfgG4xssgC%2B18L9VOWnYc4CjW0o6kwWUZnwczNYKHC374i7ZABJ7NdI5%2B3YBEI0kHuX9VVKCbKRsR%2FlpuW1H3VS08se004WPNB4PlExWdzhjTtsDFcpI9qFczYDzuTweSGhZ9FiEcODAB%2BVjfqDtazDQPvvGvGOu4a%2Bm4EoqW2kdoNbiw%2FNKEJPrYKsKjEUM92FXJFeo3nkpq05v0wtkkg14NcS4Wp2eM5xQjdIGDm9GGeH3NqfuokifXP6s9wwv1AvBNAAVgIYMDG3rqgXm6OaaMpFQCTnccHPZv9gHCVC4tjTNGUHKvxMn9S0OZa4XnRbSr7032%2BvigG0%2FstmtMlNMKudjq8GOrEBsa9MtIs6eC7H4pZfiK87ubN%2BJkKHQN15H3EVVFwbDy%2F5uS6ZAqCNB8awmdzQ7mlqx6kpynXUJYz2cmsxsx125I8MRAE5Y1mgm1jmeHQcMpCU9U9aaWiMW9bmEZs22%2B1%2FGhvKa2fypwJtMgmfZfYSqmNY%2FN1HxtI%2Blwcbi4%2BirmDVhFTQRv5wQ0fY31GBNYttIBY1frjWopQywz6kLJcTaTezKSUR8ZAjrsDhwJvIrlcN&X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240302T215248Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3600&X-Amz-Credential=ASIASXCYXIIFA2XOAUXZ%2F20240302%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Signature=25fedf8694583abe5681749b8fa18f86ab35d4e68852d6161eb55df22a49901f",
     :url=>"http://dadwithapan.com/recipe/ethiopia-coffee-pancakes-with-blueberry-maple-syrup/"}}
    
    poro = Recipe.new(json_input, country)
    expect(poro).to be_a(Recipe)
    expect(poro.id).to eq(nil)
    expect(poro.title).to eq("Ethiopia Coffee Pancakes With Blueberry Maple Syrup recipes")
    expect(poro.url).to_not eq(nil)
    expect(poro.country).to eq("Ethiopia")
    expect(poro.image).to_not eq(nil)
  end
end