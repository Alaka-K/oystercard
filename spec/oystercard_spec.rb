# frozen_string_literal: true
require "oystercard"
 
 RSpec.describe Oystercard do
    subject(:oystercard) { described_class.new }
    let(:entry_station) { double(:entry_station) }
    let(:exit_station) { double(:exit_station) }
    let(:journey) { { entry_station: entry_station, exit_station: exit_station } }

    describe "#balance" do
      it { is_expected.to respond_to(:balance) }

      it "will initialize with with a default balance of 0" do
        expect(subject.balance).to eq 0
      end
    end

    describe "#top_up" do
      it { is_expected.to respond_to(:top_up).with(1).argument }

      it "will top up balance" do
        expect { subject.top_up(3) }.to change { subject.balance }.by(3)
      end

      it "it raises an error if we try to top up more than our limit" do
        limit = Oystercard::LIMIT
        subject.top_up(limit)
        expect { subject.top_up(4) }.to raise_error "you have reached your top up limit of #{limit}"
      end
    end

    describe "#touch_in" do
      it "can touch in" do
        subject.top_up(Oystercard::MINIMUM_AMOUNT)
        subject.touch_in(entry_station)
        expect(subject.in_journey?).to eq true
      end

      it "remembers entry station" do
        subject.top_up(Oystercard::MINIMUM_AMOUNT)
        subject.touch_in(entry_station)
        expect(subject.entry_station).to eq(entry_station)
      end

      it "raises an error if we touch in with funds less than minimum amount" do
        # allow(subject).to receive(:touch_in).and_return true
        # subject.balance
        minimum_amount = Oystercard::MINIMUM_AMOUNT
        expect { subject.touch_in(entry_station) }.to raise_error "Require £#{minimum_amount} to touch in"
      end
    end

    describe "#touch_out" do
      before(:each) do
        subject.top_up(Oystercard::MINIMUM_AMOUNT)
        subject.touch_in(entry_station)
      end

      it "can touch out" do
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq false
      end

      it "on touch out it will deduct from balance " do
        expect { subject.touch_out(exit_station) }.to change { subject.balance }.by(-Oystercard::MINIMUM_AMOUNT)
      end

      it "remembers exit station" do
        subject.touch_out(exit_station)
        expect(subject.exit_station).to eq(exit_station)
      end
    end

    describe "#journeys" do
      it "records journey" do
        subject.top_up(Oystercard::MINIMUM_AMOUNT)
        subject.touch_in(entry_station)
        subject.touch_out(exit_station)
        expect(subject.journeys).to include journey
      end
    
      it "journeys list empty by default" do
        expect(subject.journeys).to eq []
      end
    end
    # describe "#touch_in" do
    #   it { is_expected.to respond_to(:touch_in)}
    # end
 end
