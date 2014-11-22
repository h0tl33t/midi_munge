class Midi < ActiveRecord::Base
  extend Dragonfly::Model::Validations

  VALID_EXTENSIONS = %w(
    mid
    midi
  )

  validates :name, :file, presence: true

  validates_property :ext, of: :file, in: VALID_EXTENSIONS

  dragonfly_accessor :file

  def munged_format
    read_attribute(:munged_format) || { name: name }.merge(MidiMunge::Formatter.new(file.file).format).tap do |format|
      update_attributes(munged_format: format)
    end
  end
end
