class Player

  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :position, :projection, :team, :height, :weight, :age, :college, :rank, :url, :scraped

  @@all = []

  def initialize
    save
  end

  def self.all # Class variable reader
    @@all
  end

end
