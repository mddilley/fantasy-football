# Purpose: to scrape Fantasypros.com for data about players and FF rankings

class Scraper

  def scrape_rankings(position)
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/rankings/#{position}.php"))
    table = doc.css('tbody tr') # Selects the table with player rankings
    build_players(table)
    add_attr
  end

  def build_players(table)
    # Input is table of player rankings, outputs hash of players and their rankings
    top = 20 # Setting for # of players scraped
    table.each_with_index do |t, i|
      if i < top
        p = Player.new
        p.name = [t.text.split[1], t.text.split[3]].join(" ")
        p.rank = t.text.split[0]
        p.url = "https://www.fantasypros.com" + t.css('a')[0]["href"]
      end
    end
  end

  def add_attr
    # Scrapes Fantasypros.com for players listed in rankings
    # Variable passed in is player_url, output is hash of player attributes
    rescue_s = "n/a"
    Player.all.each do |i|
      doc = Nokogiri::HTML(open(i.url))
      i.position = doc.css('div .pull-left h5').text.strip.split(" - ")[0]
      i.projection = doc.css('.clearfix.detail span.pull-right')[2].text.split[0]
      i.team = doc.css('div .pull-left h5').text.strip.split(" - ")[1]
      i.height = doc.css('span.bio-detail')[0].text[8,6].strip
      i.weight = doc.css('span.bio-detail')[1].text[8,3]
      i.age = doc.css('span.bio-detail')[2].text[5,2]
      i.college = (doc.css('span.bio-detail')[3].text.split(": ")[1].to_s rescue rescue_s)
    end
  end

end
