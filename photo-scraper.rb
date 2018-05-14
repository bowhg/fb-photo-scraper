require 'koala'
require 'open-uri'

access_token = "access-token"


@fb = Koala::Facebook::API.new(access_token)

albums = @fb.get_connections("me","albums")
albums.each do |album|
  album_name = album["name"]
  images = fb.get_connection(album["id"],"photos",fields: "images",limit: 100)
  c = 1
  until images.nil?
    images.each do |image|
      url = image["images"].first["source"]
      download = open(url)
      IO.copy_stream(download, "./photo/#{album_name}-#{c}.jpg")
      puts "Album #{album_name} #{c} downloaded"
      c = c+1
    end
    images = images.next_page
  end
  puts "Album #{album_name} finished"
end
