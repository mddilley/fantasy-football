# Purpose: to instantiate a command line interface

class CommandLine

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

  def show_rankings
    # asks for position (QB, WR, RB, TE, or K) and lists top 20 ranked by ESPN
    puts "Top 20 Players for QB"
  end

  def show_player
    # prompts for player details
    # input is rank, output is player details
    puts "Player Details"
  end

  def run
    welcome
    show_rankings
    show_player

  end

end
