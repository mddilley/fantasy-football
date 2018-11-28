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
    all.select {|i| i.position == position.upcase}
  end

  def self.find_by_rank_and_position(rank, position)
    all.find {|i| i.rank == rank && i.position == position.upcase}
  end

end
