module MidiMunge
  class Formatter < Struct.new(:file)
    delegate :bpm, :ppqn, to: :sequence

    def format
      {
        bpm: bpm,
        tracks: tracks.map(&:json)
      }
    end

    def sequence
      @sequence ||= MIDI::Sequence.new.read(file)
    end

    def tracks
      @tracks ||= sequence.tracks.map { |track| Track.new(track, bpm, ppqn) }
    end

    private

    class Track < Struct.new(:track, :bpm, :ppqn)
      def json
        { notes: notes }
      end

      def notes
        @notes ||= track.events.select { |event| event.is_a? MIDI::NoteOn }.map do |note|
          {
            note: note.note,
            miliseconds_from_start: calculate_miliseconds_from_start(note.time_from_start)
          }
        end
      end

      private

      def calculate_miliseconds_from_start(tick_value)
        tick_value / ((ppqn * bpm) / 60000)
      end
    end
  end
end