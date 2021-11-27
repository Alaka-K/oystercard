# frozen_string_literal: true

require "journey"

RSpec.describe Journey do
  let(:exit_station) { double :station }
  let(:entry_station) { double :station }

  subject { Journey.new(entry_station) }

  it "journeys list empty by default" do
    expect(subject.journeys).to eq []
  end
 
  context "entry station" do

    it "has an entry station" do
      expect(subject.entry_station).to eq(entry_station)
    end

  end

  it "returns minimun fare" do
    subject.finish(exit_station) #
    expect(subject.fare).to eq (Journey::MINIMUM_FARE)
  end

  context "given an exit station" do
    
    it "respond penalty fare" do
        expect(subject).to respond_to(:fare)
    end
  end
 
    it "tell if the journey is not complete" do
      subject.exit_station = nil
      expect(subject).not_to be_complete
    end

    before do
      subject.finish(exit_station)
    end

    it "return penalty fare if no entry station" do
      subject.exit_station = nil
      expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
  
    it "complete the journey" do
      expect(subject.complete?).to eq true #
    end
 
end
