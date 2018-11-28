class FantasyFootball::Scraper

  def self.scrape_rankings(position)
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/rankings/#{position}.php"))
    week = doc.css('h1').text.split[5]
    table = doc.css('tbody tr') # Selects the HTML table with player rankings
    build_players(table, position, week)
  end

  def self.build_players(table, position, week)
    # Input is HTML table of player rankings, instantiates Players, assigns name, rank, and url

    table.each_with_index do |t, i|
      begin
        if t.css('td')[0].text.to_i > 0
          p = FantasyFootball::Player.new
          p.name = t.css('span.full-name').text
          p.rank = t.css('td')[0].text
          p.url = "https://www.fantasypros.com" + t.css('a')[0]["href"]
          p.week = week
          p.position = position.upcase
        end
      rescue NoMethodError
      end
    end
  end

  def self.add_attr(player)
    # Scrapes player url stored in Player instance and assigns additional attributes
    if player.height == nil
      rescue_s = "n/a"
      doc = Nokogiri::HTML(open(player.url))
      player.projection = doc.css('.clearfix.detail span.pull-right')[2].text.split[0]
      player.team = doc.css('div .pull-left h5').text.strip.split(" - ")[1]
      player.height = doc.css('span.bio-detail')[0].text[8,6].strip
      player.weight = doc.css('span.bio-detail')[1].text[8,3]
      player.age = doc.css('span.bio-detail')[2].text[5,2]
      player.college = (doc.css('span.bio-detail')[3].text.split(": ")[1].to_s rescue rescue_s)
    end
  end

end
