class FantasyFootball::CLI

  POSITIONS = ["qb", "rb", "te", "wr", "k"]

  attr_accessor :position, :size # Stores current state of position choice

  def welcome
    puts "Welcome to the NFL Fantasy Football Rankings and Players!"
  end

  def choose_list_size
    puts "How many player rankings would you like see per position?"
    puts "Please enter a number between 1 and 25:"
    self.size = gets.strip.to_i
    if size.between?(1,25)
      return
    else
      puts "Invalid entry - please enter a valid input:"
      choose_list_size
    end
  end

  def choose_position
    # Asks for position and lists top players ranked by Fantasypros
    puts "What position would you like to see rankings for?"
    puts "Please enter QB, RB, TE, WR, or K:"
    self.position = gets.strip.downcase
    if POSITIONS.include?(position)
      FantasyFootball::Scraper.scrape_rankings(position, size) if FantasyFootball::Player.find_by_position(position) == []
      print_rankings
      choose_player
    else
      puts "Invalid entry - please enter a valid input:"
      choose_position
    end
  end

  def print_rankings
    # Iterates through Player.all to print player name and rankings by position
    puts " "
    FantasyFootball::Player.find_by_position(position).sort {|a,b| a.rank.to_i <=> b.rank.to_i}.each_with_index {| p, i|
      puts "-- Top #{size} #{position.upcase}s for Week #{p.week} of #{Time.new.year} --" if i == 0
      puts "#{p.rank}. #{p.name}"}
    puts " "
  end

  def choose_player
    # Prompts for player rank #, outputs player details
    puts "If you would like to see details about a player, enter their rank number. If not, enter N:"
    rank = gets.strip
    if rank.to_i.between?(1,size)
      print_player(rank)
    elsif rank.downcase == "n"
      return
    else
      puts "Invalid entry - please enter a valid input:"
      choose_player
    end
  end

  def print_player(rank)
    # Prints specific player using a custom class finder
    blank = "                                   "
    p = FantasyFootball::Player.find_by_rank_and_position(rank, position)
    FantasyFootball::Scraper.add_attr(p)
    puts blank
    puts "         Player Stats              "
    puts "-------------------------------    "
    puts "Name: #{p.name}                    "
    puts "Position: #{p.position}            "
    puts "Projection: #{p.projection} points "
    puts "Team: #{p.team}                    "
    puts "Height: #{p.height}                "
    puts "Weight: #{p.weight} lbs.           "
    puts "Age: #{p.age}                      "
    puts "College: #{p.college}              "
    puts "-------------------------------    "
    puts blank
  end

  def again?
    # Allows user to see details about a different player on the current rank list, choose a different rank list, or quit
    puts "Would you like to: 1. see details about a different player, 2. see rankings for a different position, or quit?"
    puts "Please enter 1, 2, or quit."
    input = gets.strip.downcase
    if input == "1"
      print_rankings
      choose_player
    elsif input == "2"
      choose_position
    elsif input == "quit"
      exit
    else
      puts "Invalid entry - please enter a valid input:"
      again?
    end
    again?
  end

  def run
    welcome
    choose_list_size
    choose_position
    again?
  end

end
