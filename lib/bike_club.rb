class BikeClub
   attr_reader :name,
               :bikers
   
   def initialize(name)
      @name = name
      @bikers = []
   end

   def add_biker(biker)
      @bikers << biker
   end

   def most_rides
      biker_total_rides = Hash.new(0)
      @bikers.each do |biker|
         biker.rides.each do |ride|
            biker_total_rides[biker] += (ride[1].count)
         end
      end
      most_rides = biker_total_rides.max_by { |biker, rides| rides }
      most_rides[0]
   end

   def best_time(ride)
      biker_best_time_by_ride = Hash.new(0)
      @bikers.each do |biker|
         biker.rides.each do |rides|
            if rides[0] == ride
               biker_best_time_by_ride[biker] = (rides[1].min) 
            end
         end
      end
      biker_with_best_time = biker_best_time_by_ride.min_by {|biker, best_time| best_time }
      biker_with_best_time[0]
   end

   def bikers_elegible(ride)
      elegible_bikers = []
      @bikers.each do |biker|
         if biker.max_distance >= ride.total_distance && biker.acceptable_terrain.include?(ride.terrain)
            elegible_bikers << biker
         end
      end
      elegible_bikers
   end
end