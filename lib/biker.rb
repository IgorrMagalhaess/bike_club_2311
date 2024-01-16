class Biker
   attr_reader :name,
               :max_distance,
               :rides,
               :acceptable_terrain

   def initialize(name, max_distance)
      @name = name
      @max_distance = max_distance
      @rides = Hash.new { |hash, key| hash[key] = [] }
      @acceptable_terrain = []
   end

   def learn_terrain!(terrain)
      @acceptable_terrain << terrain
   end

   def log_ride(ride, time)
      if @acceptable_terrain.include?(ride.terrain) && @max_distance >= ride.total_distance
         @rides[ride] << (time)
      end
      @rides
   end

   def personal_record(chosen_ride)
      record = false
      @rides.each do |ride|
          (ride[0] == chosen_ride) ? record = (ride[1].min) : next
      end
      record
   end
end