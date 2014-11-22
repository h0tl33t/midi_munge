class Midi < ActiveRecord::Base
  extend Dragonfly::Model::Validations

  VALID_EXTENSIONS = %w(
    mid
    midi
  )

  validates :name, :file, presence: true

  validates_property :ext, of: :file, in: VALID_EXTENSIONS

  dragonfly_accessor :file
end
