require 'station'

RSpec.describe Station do
  let(:name) { double("name") }
  let(:zone) { double(1) }
  subject {described_class.new(name, zone)}

  describe "#initialize" do
    
    it "initialize with name" do
      expect(subject.name).to eq(name)
    end

    it "initialize with zone" do
      expect(subject.zone).to eq(zone)
    end
  end
end