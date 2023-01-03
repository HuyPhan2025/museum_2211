class Museum
attr_reader :name,
            :exhibits,
            :patrons

    def initialize(name)
        @name = name
        @exhibits = []
        @patrons = []
    end

    def add_exhibit(name)
        @exhibits << name
    end

    def recommend_exhibits(patron)
        patron.interests
    end

    
end