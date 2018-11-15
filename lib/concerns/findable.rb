module Findable

  module ClassMethods

    def find_by_rank_and_position(rank, position)
      self.all.find {|i| i.rank == rank && i.position == position.upcase}
    end

  end

end
