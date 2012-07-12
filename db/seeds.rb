# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Tweet.create(
  id_str:            "1",
  screen_name:       "shu_0115",
  profile_image_url: "http://a0.twimg.com/profile_images/52772112/sid_normal.jpg",
  post:              "テスト",
  tweet_at:          Time.now,
)
