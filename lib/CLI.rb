# Purpose: to instantiate a command line interface

class CLI

  attr_accessor :position #stores current state of position choice

  # Desired interface:
  # "What position would you like to see the top 20 players?"
  # => List of top 20 players for QB, WR, RB, TE, or K and team player is on
  # "Would you like to know more information about a player?"
  # => Show more detailed information about a specific player (enter #)
  # "Would you like to see more rankings, details about another player, or quit?"
  # => 1. Return to rankings, show different player, or quit
  def initialize
  end

  def welcome
    puts "Welcome to the NFL Fantasy Football Rankings and Players!"
  end

  def choose_rankings
    # asks for position (QB, WR, RB, TE, or K) and lists top 20 ranked by Fantasypros
    puts "What position would you like to see rankings for?"
    puts "Please enter QB, RB, TE, WR, or K:"
    position = gets.strip.downcase
    if position == "qb" || position == "rb" || position == "te" || position ==  "wr" || position == "k"
      Player.create_from_nested_hashes(Scraper.new.build_nested_player_hash(position))
      print_rankings(position)
      choose_player
    else
      puts "Invalid entry - please enter a valid input."
      choose_rankings
    end
  end

  def print_rankings(position)
    #iterates through position.all to print player name and rankings by position
    # puts "1. Todd Gurley II"
    # puts "2. Alvin Kamara"
    Player.all.sort {|a,b| a.rank.to_i <=> b.rank.to_i}.each {|i| puts "#{i.rank}. #{i.name}"}
  end

  def choose_player
    # prompts for player details
    # input is rank, output is player details
    puts "If you would like to see details about a player, enter their rank number. If not, enter N"
    rank = gets.strip
    if rank.to_i.between?(1,20)
      print_player(rank)
    elsif rank.downcase == "n"
      return
    else
      puts "Invalid entry - please enter a valid input."
      choose_player
    end
  end

  def print_player(list_number)
    puts "-------------------------------"
    puts "Name: Todd Gurley II           "
    puts "Position: RB                   "
    puts "Projection: 22.6 points        "
    puts "Team: LAR                      "
    puts "Height: 6' 1\"                 "
    puts "Weight: 224 lbs.               "
    puts "Age: 24                        "
    puts "College: Georgia               "
    puts "-------------------------------"
  end

  def again?
    # Allows user to see details about a different player on the current rank list, choose a different rank list, or quit
    puts "Would you like to: 1. see details about a different player, 2. see rankings for a different position, or quit?"
    puts "Please enter 1, 2, or quit."
    input = gets.strip.downcase
    if input == "1"
      print_rankings(position)
      choose_player
    elsif input == "2"
      choose_rankings
    elsif input == "quit"
      return
    else
      puts "Invalid entry - please enter a valid input."
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
