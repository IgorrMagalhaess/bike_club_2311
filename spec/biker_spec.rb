require './lib/ride'
require './lib/biker'

RSpec.describe Biker do
   it 'exists' do
      biker = Biker.new("Kenny", 30)

      expect(biker).to be_a Biker
   end

   describe '#initialize' do
      it 'has a name' do
         biker = Biker.new("Kenny", 30)

         expect(biker.name).to eq "Kenny"
      end

      it 'has a max_distance' do
         biker = Biker.new("Kenny", 30)

         expect(biker.max_distance).to eq 30
      end

      it 'starts with no rides' do
         biker = Biker.new("Kenny", 30)

         expect(biker.rides).to eq({})
      end

      it 'starts with no acceptable terrain' do
         biker = Biker.new("Kenny", 30)

         expect(biker.acceptable_terrain).to eq([])
      end
   end

   describe '#learn_terrain!' do
      it 'adds terrain to acceptable terrains' do
         biker = Biker.new("Kenny", 30)

         expect(biker.learn_terrain!(:gravel)).to eq [:gravel]

         biker.learn_terrain!(:hills)

         expect(biker.acceptable_terrain).to eq [:gravel, :hills]
      end
   end

   describe '#log_ride' do
      it 'will add the ride to rides if distance is doable for the biker' do
         biker = Biker.new("Kenny", 30)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         biker.learn_terrain!(:gravel)
         biker.learn_terrain!(:hills)

         expect(biker.log_ride(ride1, 92.5)).to eq({ride1 => [92.5]})
      end

      it 'will not add the ride to rides if distance is not doable for the biker' do
         biker2 = Biker.new("Athena", 15)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         biker2.learn_terrain!(:gravel)
         biker2.learn_terrain!(:hills)

         expect(biker2.log_ride(ride1, 97.0)).to eq({})
      end

      it 'will add the ride to rides if biker knows the terrain' do
         biker = Biker.new("Kenny", 30)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         biker.learn_terrain!(:gravel)
         biker.learn_terrain!(:hills)

         expect(biker.log_ride(ride1, 92.5)).to eq({ride1 => [92.5]})
      end

      it 'will not add the ride to rides if biker does not knows the terrain' do
         biker2 = Biker.new("Athena", 15)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         expect(biker2.log_ride(ride2, 97.0)).to eq({})
      end
   end

   describe '#personal_record(ride)' do
      it 'returns the best time biker had for that ride' do
         biker = Biker.new("Kenny", 30)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         biker.learn_terrain!(:gravel)
         biker.learn_terrain!(:hills)

         biker.log_ride(ride1, 92.5)
         biker.log_ride(ride1, 91.1)
         biker.log_ride(ride2, 60.9)
         biker.log_ride(ride2, 61.6)

         expect(biker.personal_record(ride1)).to eq 91.1
         expect(biker.personal_record(ride2)).to eq 60.9
      end

      it 'returns false if biker has no time for that ride' do
         biker2 = Biker.new("Athena", 15)
         ride1 = Ride.new({name: "Walnut Creek Trail", distance: 10.7, loop: false, terrain: :hills})
         ride2 = Ride.new({name: "Town Lake", distance: 14.9, loop: true, terrain: :gravel})

         biker2.learn_terrain!(:gravel)
         biker2.learn_terrain!(:hills)

         biker2.log_ride(ride1, 95.0)
         biker2.log_ride(ride2, 65.0)

         expect(biker2.rides).to eq({ride2=>[65.0]})
         expect(biker2.personal_record(ride2)).to eq 65.0
         expect(biker2.personal_record(ride1)).to eq false
      end
   end
end