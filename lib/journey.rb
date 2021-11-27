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
    return PENALTY_FARE unless complete? 

    return MINIMUM_FARE
  end

  def complete?
    @exit_station ? true : false
  end

  def finish(other_station)
    @exit_station = other_station
  end
end

