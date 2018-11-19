class FantasyFootball::Player

  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :position, :projection, :team, :height, :weight, :age, :college, :rank, :url, :week

  @@all = []

  def initialize
    save
  end

  def self.all # Class variable reader
    @@all
  end

end
