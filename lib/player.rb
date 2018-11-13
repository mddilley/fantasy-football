# Purpose: Instantiate players based on data scraped from ESPN.com (BELONGS TO a team, HAS a position)

class Player

  attr_accessor :name, :position, :projection, :team, :team, :height, :weight, :age, :college, :rank

  @@all = []

  def initialize(player_hash)
    # player_hash passed in contains player name and attributes
    # use metaprogramming to instantiate new classes and create attributes
    player_hash.each {|k,v| self.send("#{k}=", v)}
    save
  end

  def save
    @@all << self
  end

  def self.all
    @@all
  end

  def create_from_nested_hashes(nested_hash)

  end

end
