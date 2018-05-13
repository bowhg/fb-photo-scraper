require 'koala'
require 'open-uri'

access_token = "your-access-token"

@fb = Koala::Facebook::API.new(access_token)

albums = @fb.get_connections("me","albums")
albums.each do |album|
  album_name = album["name"]
  images = fb.get_object("#{album["id"]}?fields=photos{picture,images}")
  count = images["photos"]["data"].count
  c = 1
  images["photos"]["data"].each do |image|
    url = image["images"].first["source"]
    download = open(url)
    IO.copy_stream(download, "./photo/#{album_name}-#{c}.jpg")
    puts "Album #{album_name} #{c} out of #{count} downloaded"
    c = c+1
  end
  puts "Album #{album_name} finished"
end
