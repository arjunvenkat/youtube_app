# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

Video.destroy_all
Video.create([{link: 'https://www.youtube.com/watch?v=47YClVMlthI'}, 
  {link: 'https://www.youtube.com/watch?v=oSGEGZf0KJo'},
  {link: 'https://www.youtube.com/watch?v=N6oTKHj8WJQ'},
  {link: 'https://www.youtube.com/watch?v=nwupK0ljVWQ' }])
  
puts "#{Video.count} videos in the database"