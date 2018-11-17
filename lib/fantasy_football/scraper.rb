class Scraper

  extend Findable::ClassMethods
  include Memorable::InstanceMethods

  attr_accessor :name, :week

  @@all = []

  def self.all # Class variable reader
    @@all
  end

  def self.size #Determines how many players to scrape per position
    20
  end

  def self.new_with_name(name) #Custom class constructor
    if !Scraper.find_by_name(name)
      s = Scraper.new
      s.name = name
      s.save
      s.scrape_rankings(name)
    else
    Scraper.find_by_name(name)
    end
  end

  def scrape_rankings(position)
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/rankings/#{position}.php"))
    # binding.pry
    @week = doc.css('h1').text.split[5]
    table = doc.css('tbody tr') # Selects the HTML table with player rankings
    build_players(table, name)
  end

  def build_players(table,position)
    # Input is HTML table of player rankings, instantiates Players, assigns name, rank, and url
    table.each_with_index do |t, i|
      if i < Scraper.size
        p = Player.new
        p.name = [t.text.split[1], t.text.split[3]].join(" ")
        p.rank = t.text.split[0]
        p.url = "https://www.fantasypros.com" + t.css('a')[0]["href"]
        p.position = position.upcase
      end
    end
  end

  def add_attr(player)
    # Scrapes player url stored in Player instance and assigns additional attributes
    if player.scraped == nil
      rescue_s = "n/a"
      doc = Nokogiri::HTML(open(player.url))
      player.projection = doc.css('.clearfix.detail span.pull-right')[2].text.split[0]
      player.team = doc.css('div .pull-left h5').text.strip.split(" - ")[1]
      player.height = doc.css('span.bio-detail')[0].text[8,6].strip
      player.weight = doc.css('span.bio-detail')[1].text[8,3]
      player.age = doc.css('span.bio-detail')[2].text[5,2]
      player.college = (doc.css('span.bio-detail')[3].text.split(": ")[1].to_s rescue rescue_s)
      player.scraped = "Y"
    end
  end

end
