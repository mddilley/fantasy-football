# Purpose: Instantiate players based on data scraped from ESPN.com (BELONGS TO a team, HAS a position)

class Player

  def initialize
    # player_hash passed in contains player name and attributes
    # use metaprogramming to instantiate new classes and create attributes
  end

  def create_from_hash(player_hash)
    player = Player.new
    player_hash.each do |k,v|
      player.send("#{k}=", v)
    end
  end

  def create_from_nested_hashes(nested_hash)

  end

end
