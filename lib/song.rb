require 'pry'
class Song 
  
  attr_accessor :name, :artist, :song, :genre
  
  @@all = []
  
  def initialize(name, artist = nil, genre = nil)
    @name = name
    self.artist = artist if artist
    self.genre = genre if genre
  end
  
  def self.all
    @@all
  end
  
  def self.destroy_all
    self.all.clear
  end
  
  def save
    @@all << self
  end
  
  def self.create(song_name)
    song = Song.new(song_name)
    song.save
    song
  end
  
  def artist=(artist)
    @artist = artist
    artist.add_song(self)    
  end
  
  def genre=(genre)
    @genre = genre
    genre.songs << self unless genre.songs.include?(self)
  end

  def self.find_by_name(name)
    self.all.find{|song| song.name == name}
  end

  def self.find_or_create_by_name(name)
    self.find_by_name(name) ||
    self.create(name)
  end
    
  def self.new_from_filename(file_name)
     rows = file_name.split(/ - /)
       genre_name = rows[2].gsub(".mp3", "")
       artist_name = rows[0]
       song_name = rows[1]
       artist1 = Artist.find_or_create_by_name(artist_name)
       genre1 = Genre.find_or_create_by_name(genre_name)
       self.new(song_name, artist1, genre1)
  end
    
  def self.create_from_filename(file_name)
    self.new_from_filename(file_name).tap { |o| o.save }
  end
  
end