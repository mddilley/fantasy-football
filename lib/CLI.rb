class CLI

  attr_accessor :position, :scraper # Stores current state of position choice

  def welcome
    puts "Welcome to the NFL Fantasy Football Rankings and Players!"
  end

  def choose_rankings
    # Asks for position and lists top players ranked by Fantasypros
    puts "What position would you like to see rankings for?"
    puts "Please enter QB, RB, TE, WR, or K:"
    @position = gets.strip.downcase
    if @position == "qb" || @position == "rb" || @position == "te" || @position ==  "wr" || @position == "k"
      @scraper = Scraper.new
      @scraper.scrape_rankings(@position)
      print_rankings(@position)
      choose_player
    else
      puts "Invalid entry - please enter a valid input:"
      choose_rankings
    end
  end

  def print_rankings(position)
    # Iterates through Player.all to print player name and rankings by position
    Player.find_by_position(position).sort {|a,b| a.rank.to_i <=> b.rank.to_i}.each {|i| puts "#{i.rank}. #{i.name}"}
  end

  def choose_player
    # Prompts for player rank #, outputs player details
    puts "If you would like to see details about a player, enter their rank number. If not, enter N:"
    rank = gets.strip
    if rank.to_i.between?(1,20)
      print_player(rank)
    elsif rank.downcase == "n"
      return
    else
      puts "Invalid entry - please enter a valid input:"
      choose_player
    end
  end

  def print_player(list_number)
    # Prints specific player using a custom class finder
    p = Player.find_by_rank_and_position(list_number, @position)
    @scraper.add_attr(p)
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
  end

  def again?
    # Allows user to see details about a different player on the current rank list, choose a different rank list, or quit
    puts "Would you like to: 1. see details about a different player, 2. see rankings for a different position, or quit?"
    puts "Please enter 1, 2, or quit."
    input = gets.strip.downcase
    if input == "1"
      print_rankings(@position)
      choose_player
    elsif input == "2"
      choose_rankings
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
    choose_rankings
    again?
  end

end
