class CLI

  def welcome
    puts "Welcome to the NFL Fantasy Football Rankings and Players!"
  end

  def show_rankings
    # asks for position (QB, WR, RB, TE, or K) and lists top 20 ranked by ESPN
  end

  def show_player
    # prompts for player details
    # input is rank, output is player details
  end

  def run
    welcome
    show_rankings
    show_player
    
  end

end
