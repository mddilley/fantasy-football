# Purpose: Instantiate players based on data scraped from Fantasypros.com

class Player

  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :position, :projection, :team, :height, :weight, :age, :college, :rank

  @@all = []

  def initialize(player_hash)
    # player_hash passed in contains player name and attributes
    # use metaprogramming to write attributes
    player_hash.each {|k,v| self.send("#{k}=", v)}
    save
  end

  def self.all # Class variable reader
    @@all
  end

  def self.create_from_nested_hashes(nested_hash)
    # Custom class constructor, accepts player objects nested in an array
    nested_hash.each do |p|
      Player.new(p)
    end
  end

end
