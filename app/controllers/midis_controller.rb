class MidisController < ApplicationController
  def new
    @midi = Midi.new
  end

  def create
    @midi = Midi.new(midi_params)

    if midi.save
      redirect_to midi, notice: 'MIDI uploaded and munged!'
    else
      flash.now[:error] = midi.errors.full_messages.join('; ')
      render 'new'
    end
  end

  def show
    respond_to do |format|
      format.html {}
      format.json { render json: midi.munged_format }
    end
  end

  private

  def midi_params
    params.require(:midi).permit(:name, :file, :file_url)
  end

  def midi
    @midi ||= Midi.find(params[:id])
  end
  helper_method :midi

  def midis
    @midis ||= Midi.last(10)
  end
  helper_method :midis
end
