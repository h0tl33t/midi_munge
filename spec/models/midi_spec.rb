require 'rails_helper'

RSpec.describe Midi, :type => :model do
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:file) }

  it "does not allow files in non-MIDI formats" do
    midi = build(:midi, file: './spec/fixtures/example.txt')

    expect(midi.valid?).to eq false
    expect(midi.errors[:file]).to include "ext is incorrect. It needs to be one of 'mid', 'midi'"
  end
end
