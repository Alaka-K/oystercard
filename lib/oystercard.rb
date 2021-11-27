# frozen_string_literal: true

require_relative "oystercard"
class Oystercard
  LIMIT = 90
  MINIMUM_AMOUNT = 1
  attr_reader :balance, :entry_station, :exit_station, :journeys

  def initialize
    @balance = 0
    # @journeys = []
  end

  def top_up(money)
    raise "you have reached your top up limit of #{LIMIT}" if money + @balance > LIMIT

    @balance += money
  end

  def touch_in(entry_station)
    raise "Require £#{MINIMUM_AMOUNT} to touch in" if under_minimum_amount

    @entry_station = entry_station
  end

  def touch_out(exit_station)
    deduct(MINIMUM_AMOUNT)
    @exit_station = exit_station
    # @journeys << { entry_station: @entry_station, exit_station: exit_station }
    @entry_station = nil
  end

  def under_minimum_amount
    @balance < MINIMUM_AMOUNT
  end

  def in_journey?
    @entry_station.nil? ? false : true
  end

  private

  def deduct(money)
    @balance -= money
  end
end
