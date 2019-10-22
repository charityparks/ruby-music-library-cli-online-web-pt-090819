class Genre
  
  extend Concerns::Findable
  
  attr_accessor :name, :songs, :artist
  
  @@all = []
  
  def initialize(name)
    @name = name
    @songs = []
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
  
  def self.create(genre_name)
    genre = Genre.new(genre_name)
    genre.save
    genre
  end
    
  def artists
    @songs.collect{|song| song.artist}.uniq
  end
end