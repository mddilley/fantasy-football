module Findable

  module ClassMethods

    def find_by_position(position)
      self.all.select {|i| i.position == position.upcase}
    end

    def find_by_rank_and_position(rank, position)
      self.all.find {|i| i.rank == rank && i.position == position.upcase}
    end

    def find_by_name(name)
      self.all.find {|i| i.name == name}
    end

  end

end
