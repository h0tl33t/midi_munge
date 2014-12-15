module MidiMunge
  class Formatter < Struct.new(:file)
    delegate :bpm, :ppqn, to: :sequence

    def sequence
      @sequence ||= MIDI::Sequence.new.tap do |sequence|
        sequence.read(file)
      end
    end

    def tracks
      @tracks ||= sequence.tracks.map { |track| Track.new(track, bpm, ppqn) }
    end

    def format
      {
        bpm:    bpm,
        tracks: tracks.map(&:json)
      }
    end

    private

    class Track < Struct.new(:track, :bpm, :ppqn)
      def json
        { notes: notes }
      end

      def notes
        @notes ||= track.events.select { |event| event.is_a? MIDI::NoteOn }.map do |note|
          {
            note: MidiNotes::VALUES.fetch(note.note),
            milliseconds_from_start: calculate_milliseconds_from_start(note.time_from_start)
          }
        end
      end

      private

      def calculate_milliseconds_from_start(tick_value)
        tick_value / ((ppqn * bpm) / 60000)
      end
    end
  end
end
