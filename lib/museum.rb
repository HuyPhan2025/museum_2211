class Museum
attr_reader :name,
            :exhibits,
            :patrons,
            :patrons_by_exhibit_interest

    def initialize(name)
        @name = name
        @exhibits = []
        @patrons = []
        @patrons_by_exhibit_interest = {}
    end

    def add_exhibit(name)
        @exhibits << name
    end

    def recommend_exhibits(patron)
        patron.interests
    end

    def admit(patron)
        @patrons << patron
    end

    

    
end