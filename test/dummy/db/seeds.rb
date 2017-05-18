ActiveRecord::Base.transaction do
  [
  	{name: "Item1", note: "sample text. this is awesome item!", price: 1000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date},
  	{name: "Item2", note: "sample text. this is awesome item!", price: 2000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date},
  	{name: "Item3", note: "sample text. this is awesome item!", price: 5000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date},
  	{name: "Item4", note: "sample text. this is awesome item!", price: 10000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date},
  	{name: "Item5", note: "sample text. this is awesome item!", price: 19000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date},
  	{name: "Item6", note: "sample text. this is awesome item!", price: 40000, image_url: "https://placehold.jp/150x150.png",  expired_at: Time.now.to_date}
  ].each do |row|
  	p Item.create!(row)
  end
end