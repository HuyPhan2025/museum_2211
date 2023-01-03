require './lib/museum'
require './lib/patron'
require './lib/exhibit'

RSpec.describe Museum do
    let(:dmns) { Museum.new("Denver Museum of Nature and Science") }
    let(:gems_and_minerals) { Exhibit.new({name: "Gems and Minerals", cost: 0}) }
    let(:dead_sea_scrolls) { Exhibit.new({name: "Dead Sea Scrolls", cost: 10}) }
    let(:imax) { Exhibit.new({name: "IMAX",cost: 15}) }
    let(:patron_1) { Patron.new("Bob", 20) }
    let(:patron_2) { Patron.new("Sally", 20) }
    let(:patron_3) { Patron.new("Johnny", 5) }

    before do
        patron_1.add_interest("Dead Sea Scrolls")
        patron_1.add_interest("Gems and Minerals")
        patron_2.add_interest("IMAX")
        patron_2.add_interest("Dead Sea Scrolls")
        patron_3.add_interest("Dead Sea Scrolls")
    end

    describe '#initialize' do
        it 'exists' do
            expect(dmns).to be_instance_of(Museum)
        end

        it 'has attributes' do
            expect(dmns.name).to eq("Denver Museum of Nature and Science")
            expect(dmns.exhibits).to eq([])
            expect(dmns.patrons_by_exhibit_interest).to eq({})
        end
    end

    describe '#add_exhibit' do
        it 'add exhibits to exhibits array' do
            dmns.add_exhibit(gems_and_minerals)
            dmns.add_exhibit(dead_sea_scrolls)
            dmns.add_exhibit(imax)

            expect(dmns.exhibits).to eq([gems_and_minerals,dead_sea_scrolls,imax])
        end
    end

    describe '#recommend_exhibits' do
        it 'recommend exhibit to patrons' do
            expect(dmns.recommend_exhibits(patron_1)).to eq(["Dead Sea Scrolls", "Gems and Minerals" ])
            expect(dmns.recommend_exhibits(patron_2)).to eq(["IMAX"])
        end
    end

    describe '#can_have_patrons' do
        it 'can have patrons' do
            expect(dmns.patrons).to eq([])
        end
    end

    describe '#can_admit_patrons' do
        it 'can add patrons to patrons array' do
            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.patrons).to eq([patron_1,patron_2, patron_3])
        end
    end

    describe '#can_be_added_even_if_they_dont_have enough money' do
        it ' can be added even if they dont have enough money' do
            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expected_hash = {
                'Gems and Minerals' => [patron_1],
                'Dead Sea Scrolls' => [patron_1, patron_2, patron_3]
                'IMAX' => []
            }
            expect(dmns.patrons_by_exhibit_interest).to eq(expected_hash)
        end
    end

    describe '#announce_lottery_winner' do
        it 'annouce the lottery winner for each exhibition' do
            dmns.admit(patron_1)
            dmns.admit(patron_2)
            dmns.admit(patron_3)

            expect(dmns.ticket_lottery_contestants(dead_sea_scrolls)).to eq ([patron_1,patron_2])
            expect(dmns.draw_lottery_winner(dead_sea_scrolls)).to eq("Johnny")
            expect(dmns.draw_lottery_winner(gems_and_minerals)).to eq(nil)
            expect(dmns.announce_lottery_winner(imax)).to eq("Bob")
            expect(dmns.announce_lottery_winner(gems_and_minerals)).to eq("No winners for this lottery")
        end
    end
end