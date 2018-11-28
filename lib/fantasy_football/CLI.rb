class FantasyFootball::CLI

  POSITIONS = ["qb", "rb", "te", "wr", "k"]

  def welcome
    puts " "
    puts "Welcome to NFL Fantasy Football Rankings and Players!"
    puts " "
  end

  def choose_list_size(position)
    puts "How many player rankings would you like see?"
    puts "Please enter a number between 1 and #{FantasyFootball::Player.find_by_position(position).size}:"
    @size = gets.strip.to_i
    if !@size.between?(1,FantasyFootball::Player.find_by_position(position).size)
      puts "Invalid entry - please enter a valid input:"
      choose_list_size(@position)
    end
  end

  def choose_position
    # Asks for position and lists top players ranked by Fantasypros
    puts "What position would you like to see rankings for?"
    puts "Please enter QB, RB, TE, WR, or K:"
    @position = gets.strip.downcase
    if POSITIONS.include?(@position)
      FantasyFootball::Scraper.scrape_rankings(@position) if FantasyFootball::Player.find_by_position(@position) == []
      choose_list_size(@position)
      print_rankings(@size)
      choose_player
    else
      puts "Invalid entry - please enter a valid input:"
      choose_position
    end
  end

  def print_rankings(size)
    # Iterates through Player instances to print player name and rankings by position
    puts " "
    FantasyFootball::Player.find_by_position(@position)[0..@size - 1].each_with_index {| p, i|
      puts "-- Top #{size} #{@position.upcase}s for Week #{p.week} of #{Time.new.year} --" if i == 0
      puts "#{p.rank}. #{p.name}"}
    puts " "
  end

  def choose_player
    # Prompts for player rank #, outputs player details
    puts "If you would like to see details about a player, enter their rank number. If not, enter N:"
    rank = gets.strip
    if rank.to_i.between?(1,@size)
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
    blank = " "
    p = FantasyFootball::Player.find_by_rank_and_position(rank, @position)
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
      print_rankings(@size)
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
    choose_position
    again?
  end

end
