# frozen_string_literal: true

class Journey
  attr_reader :journeys
  attr_accessor :exit_station, :entry_station
  
  PENALTY_FARE = 6
  MINIMUM_FARE = 1
  
  def initialize(entry_station)
    @journeys = []
    @entry_station = entry_station
  end

  def fare
    PENALTY_FARE unless complete? 
    MINIMUM_FARE
  end


  def complete?
    @other_station ? true : false
  end

  def finish(other_station)
    @other_station = other_station
  end
end

