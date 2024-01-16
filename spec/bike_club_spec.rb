require './lib/ride'
require './lib/biker'
require './lib/bike_club'

RSpec.describe BikeClub do
   it 'exists' do
      bike_club = BikeClub.new("Asphalt Burners")

      expect(bike_club).to be_a BikeClub
   end

   describe '#initialize' do
      it 'has a name' do
         bike_club = BikeClub.new("Asphalt Burners")

         expect(bike_club.name).to eq "Asphalt Burners"
      end

      it 'starts with an empty bikers array' do
         bike_club = BikeClub.new("Asphalt Burners")

         expect(bike_club.bikers).to eq([])
      end
   end

   describe '#add_biker(biker)' do
      it 'adds bikers to bike club' do
         bike_club = BikeClub.new("Asphalt Burners")
         biker = Biker.new("Kenny", 30)

         expect(bike_club.add_biker(biker)).to eq([biker])
         expect(bike_club.bikers).to eq([biker])
      end
   end

   describe '#most_rides' do
      it 'returns the biker with most rides' do
         bike_club = BikeClub.new("Asphalt Burners")
         biker = Biker.new("Kenny", 30)
         biker2 = Biker.new("Athena", 15)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         bike_club.add_biker(biker)
         bike_club.add_biker(biker2)

         biker.learn_terrain!(:gravel)
         biker.learn_terrain!(:hills)

         biker.log_ride(ride1, 92.5)
         biker.log_ride(ride1, 91.1)
         biker.log_ride(ride2, 60.9)
         biker.log_ride(ride2, 61.6)

         biker2.learn_terrain!(:gravel)
         biker2.learn_terrain!(:hills)

         biker2.log_ride(ride2, 65.0)
         biker2.log_ride(ride2, 64.0)

         expect(bike_club.most_rides).to eq biker
      end
   end

   describe '#best_time(ride)' do
      it 'returns the biker with most rides' do
         bike_club = BikeClub.new("Asphalt Burners")
         biker = Biker.new("Kenny", 30)
         biker2 = Biker.new("Athena", 30)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         bike_club.add_biker(biker)
         bike_club.add_biker(biker2)

         biker.learn_terrain!(:gravel)
         biker.learn_terrain!(:hills)

         biker.log_ride(ride1, 92.5)
         biker.log_ride(ride1, 91.1)
         biker.log_ride(ride2, 60.9)
         biker.log_ride(ride2, 61.6)

         biker2.learn_terrain!(:gravel)
         biker2.learn_terrain!(:hills)

         biker2.log_ride(ride1, 93.0)
         biker2.log_ride(ride1, 92.0)
         biker2.log_ride(ride2, 65.0)
         biker2.log_ride(ride2, 60.0)

         expect(bike_club.best_time(ride1)).to eq biker
         expect(bike_club.best_time(ride2)).to eq biker2
      end
   end         

   describe '#bikers_elegible(ride)' do
      it 'returns which bikers are elegible for a given ride' do
         bike_club = BikeClub.new("Asphalt Burners")
         biker = Biker.new("Kenny", 30)
         biker2 = Biker.new("Athena", 15)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         bike_club.add_biker(biker)
         bike_club.add_biker(biker2)

         biker.learn_terrain!(:hills)
         biker2.learn_terrain!(:gravel)

         expect(bike_club.bikers_elegible(ride1)).to eq [biker]
         expect(bike_club.bikers_elegible(ride2)).to eq [biker2]

         biker.learn_terrain!(:gravel)
         expect(bike_club.bikers_elegible(ride2)).to eq [biker, biker2]
      end
   end
end