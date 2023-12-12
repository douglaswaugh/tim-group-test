class Lap
	def initialize(lapTime)
		lapTimeUnits = lapTime.split(":")
		@minutes = Integer(lapTimeUnits[0])
		@seconds = Integer(lapTimeUnits[1])
		@hundredths = Integer(lapTimeUnits[2])
	end
	
	def to_hundredths
		return (@minutes * 6000) + (@seconds * 100) + @hundredths
	end
	
	def averageWith(otherLap)
		averageInHundredths = (to_hundredths + otherLap.to_hundredths) / 2
		
		averageMinutes = averageInHundredths / 6000
		averageSeconds = (averageInHundredths - (averageMinutes * 6000)) / 100
		averageHundredths = (averageInHundredths - (averageMinutes * 6000) - (averageSeconds * 100))
		
		return "#{formatUnit(averageMinutes)}:#{formatUnit(averageSeconds)}:#{formatUnit(averageHundredths)}"
	end
	
	def formatUnit(unit)
		return unit.to_s.rjust(2,"0")
	end
end

def average (lap1Time,lap2Time)
	lap1 = Lap.new(lap1Time)
	lap2 = Lap.new(lap2Time)
	
	return lap1.averageWith(lap2)
end

def average_time_equals(lap1,lap2,timeReturned,expectedAverage)
	if timeReturned == expectedAverage
		puts "Average of #{lap1} and #{lap2} returns #{timeReturned}"
	else
		puts "Average of #{lap1} and #{lap2} failed.  Returned #{timeReturned}, was expecting #{expectedAverage}" 
	end
end

lap1 = "00:00:00"
lap2 = "00:00:00"
averageLap = average(lap1, lap2)
average_time_equals(lap1,lap2, averageLap,"00:00:00")	

lap1 = "00:00:00"
lap2 = "00:00:80"
averageLap = average(lap1, lap2)
average_time_equals(lap1,lap2, averageLap,"00:00:40")

lap1 = "00:00:00"
lap2 = "00:30:00"
averageLap = average(lap1, lap2)
average_time_equals(lap1,lap2,averageLap,"00:15:00")

lap1 = "00:00:00"
lap2 = "24:00:00"
averageLap = average(lap1,lap2)
average_time_equals(lap1,lap2,averageLap,"12:00:00")

lap1 = "00:00:00"
lap2 = "15:00:00"
averageLap = average(lap1,lap2)
average_time_equals(lap1,lap2,averageLap,"07:30:00")

lap1 = "00:00:00"
lap2 = "00:07:00"
averageLap = average(lap1,lap2)
average_time_equals(lap1,lap2,averageLap,"00:03:50")