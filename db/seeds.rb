require 'yaml'

seed = File.open('db/seeds.yml') { |f| YAML.load(f) }
names = ["Tom", "Dorothy", "Jack", "Kate", "Agatha", "Peter", "Carl"]

Category.create!(seed["categories"])

seed["texts"].each do |text|
  for i in (0..text["categories"].size-1) do
    text["categories"][i] = Category.where(:name => text["categories"][i]).first
  end
end

Text.create!(seed["texts"])

texts_count = Text.count
100.times do
  text = Text.all[Random.new.rand(0..Text.count-1)]
  text.results.create(:name => names.shuffle.first, :time => text.words_count * 600 / Random.new.rand(20..80))
end
