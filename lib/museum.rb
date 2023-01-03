class Museum
attr_reader :name,
            :exhibits

    def initialize(name)
        @name = name
        @exhibits = []
    end

    def add_exhibit(name)
        @exhibits << name
    end

    def recommend_exhibits(patron)
        patron.interests
    end
end