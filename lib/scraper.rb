class Scraper

  def scrape_rankings(position)
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/rankings/#{position}.php"))
    table = doc.css('tbody tr') # Selects the HTML table with player rankings
    build_players(table, position)
    # add_attr
  end

  def build_players(table,position)
    # Input is HTML table of player rankings, instantiates Players, assigns name, rank, and url
    top = 20 # Setting for # of players scraped
    table.each_with_index do |t, i|
      if i < top
        p = Player.new
        p.name = [t.text.split[1], t.text.split[3]].join(" ")
        p.rank = t.text.split[0]
        p.url = "https://www.fantasypros.com" + t.css('a')[0]["href"]
        p.position = position.upcase
      end
    end
  end

  def add_attr(player)
    # Scrapes player urls stored in Player instances
    # Assigns additional attributes
    rescue_s = "n/a"

    doc = Nokogiri::HTML(open(player.url))
    # player.position = doc.css('div .pull-left h5').text.strip.split(" - ")[0]
    player.projection = doc.css('.clearfix.detail span.pull-right')[2].text.split[0]
    player.team = doc.css('div .pull-left h5').text.strip.split(" - ")[1]
    player.height = doc.css('span.bio-detail')[0].text[8,6].strip
    player.weight = doc.css('span.bio-detail')[1].text[8,3]
    player.age = doc.css('span.bio-detail')[2].text[5,2]
    player.college = (doc.css('span.bio-detail')[3].text.split(": ")[1].to_s rescue rescue_s)
  end

end
