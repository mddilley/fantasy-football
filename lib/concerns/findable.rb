module Findable

  module ClassMethods

    def find_by_rank(rank)
      self.all.find {|i| i.rank == rank}
    end

  end

end
