# Purpose: to scrape ESPN.com for data about players and FF rankings

class Scraper

  def scrape_player(player_url)
    # scrapes ESPN.com for players listed in rankings
    # variable passed in is player_url
    # output is hash of player attributes
    doc = Nokogiri::HTML(open())
  end

  def scrape_rankings(position)
    # scrapes ESPN.com for top 20 players per position
    # variable pass in is position (string)
    # output is a hash with player names, rankings, and player url
    # positions.each do |k,v|
    #    doc = Nokogiri::HTML(open(""))
    #    k = Position.new()
    # end
    position = "qb"
    top = 20
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/rankings/#{position}.php"))
    table = doc.css('tbody tr') # Selects the table with player rankings
    build_ranking_hash(table)
  end

  def build_player_hash

  end

  def build_ranking_hash(table)
    # Input is table of player rankings, outputs
    rankings = {}
    rankings.tap {
    table.each_with_index do |t, i|
      if i < 20
        rankings[[t.text.split[1], t.text.split[3]].join(" ")] = t.text.split[0]
      end
    end
    }
  end


end

#pete mahomes node => doc.css('tbody tr')[0]
#drew brees node => doc.css('tbody tr')[1]
