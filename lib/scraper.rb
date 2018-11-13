# Purpose: to scrape ESPN.com for data about players and FF rankings

class Scraper

  def scrape_player(player_url)
    # scrapes ESPN.com for players listed in rankings
    # variable passed in is player_url
    # output is hash of player attributes
    doc = Nokogiri::HTML(open("https://www.fantasypros.com/nfl/players/patrick-mahomes.php"))
    # player :name => doc.css('.player-16413').text
    # player :position => doc.css('div .pull-left h5').text.strip.split(" - ")[0]
    # player :projection => doc.css('.clearfix.detail span.pull-right')[2].text.split[0]
    # player :team => doc.css('div .pull-left h5').text.strip.split(" - ")[1]
    # player :height => doc.css('span.bio-detail')[0].text[8,5]
    # player :weight => doc.css('span.bio-detail')[1].text[8,3]
    # player :age => doc.css('span.bio-detail')[2].text[5,2]
    # player :college => doc.css('span.bio-detail')[3].text.split(": ")[1]
    hash = {:name => doc.css('h1').text,
            :position => doc.css('div .pull-left h5').text.strip.split(" - ")[0],
            :projection => doc.css('.clearfix.detail span.pull-right')[2].text.split[0],
            :team => doc.css('div .pull-left h5').text.strip.split(" - ")[1],
            :height => doc.css('span.bio-detail')[0].text[8,5],
            :weight => doc.css('span.bio-detail')[1].text[8,3],
            :age => doc.css('span.bio-detail')[2].text[5,2],
            :college => doc.css('span.bio-detail')[3].text.split(": ")[1]
            }
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



  def build_ranking_hash(table)
    # Input is table of player rankings, outputs hash of players and their rankings
    rankings = {}
    rankings.tap {
    table.each_with_index do |t, i|
      if i < 20
        rankings[[t.text.split[1], t.text.split[3]].join(" ")] = {:rank => t.text.split[0],
                                                                  :url => "http://www.fantasypros.com" + t.css('a')[0]["href"]}
      end
    end
    }
  end

  def build_player_hash



  end

end

#pete mahomes node => doc.css('tbody tr')[0]
#drew brees node => doc.css('tbody tr')[1]
