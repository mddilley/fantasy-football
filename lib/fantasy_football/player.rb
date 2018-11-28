class FantasyFootball::Player

  attr_accessor :name, :position, :projection, :team, :height, :weight, :age, :college, :rank, :url, :week

  @@all = []

  def initialize
    save
  end

  def self.all # Class variable reader
    @@all
  end

  def save
    @@all << self
  end

  def self.find_by_position(position)
    all.select {|i| i.position == position.upcase}.sort {|a,b| a.rank.to_i <=> b.rank.to_i}
  end

  def self.find_by_rank_and_position(rank, position)
    all.find {|i| i.rank == rank && i.position == position.upcase}
  end

end
