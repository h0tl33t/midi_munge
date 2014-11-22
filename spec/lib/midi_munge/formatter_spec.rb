require 'rails_helper'

RSpec.describe MidiMunge::Formatter do
  let!(:sequence) { double('MIDI::Sequence', bpm: 190, ppqn: 96) }

  before do
    allow(MIDI::Sequence).to receive(:new).and_return(sequence)
    allow(sequence).to receive(:read)
  end

  subject { described_class.new('file') }

  describe "#sequence" do
    it "instantiates a new MIDI sequence and reads in the given file" do
      expect(sequence).to receive(:read).with('file')

      subject.sequence
    end
  end

  describe "#tracks" do
    let(:tracks) { %w(track1 track2 track3) }

    before do
      allow(sequence).to receive(:tracks).and_return(tracks)
    end

    it "converts the sequences tracks into MidiMunge::Formatter::Track objects" do
      tracks.each do |track|
        expect(MidiMunge::Formatter::Track).to receive(:new).with(track, 190, 96)
      end

      subject.tracks
    end
  end

  describe "#format" do
    let(:track1) { double('MIDI::Track', json: 'Track 1 JSON') }
    let(:track2) { double('MIDI::Track', json: 'Track 2 JSON') }
    let(:tracks) { [track1, track2] }

    before do
      allow(subject).to receive(:tracks).and_return(tracks)
    end

    it { expect(subject.format).to eq bpm: 190, tracks: ['Track 1 JSON', 'Track 2 JSON'] }
  end
end
