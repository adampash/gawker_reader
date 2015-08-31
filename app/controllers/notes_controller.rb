class NotesController < ApplicationController
  include ActionView::Helpers::TextHelper
  def show
    @note = Note.find_by month_and_year: params[:month_and_year], site: params[:site]
    if @note
      if params[:editable] == "true"
        text = @note.text
      else
        text = "#{raw(simple_format(@note.text))}"
      end
      render json: {text: text}.to_json
    else
      render json: {text: ''}.to_json
    end
  end

  def create
    @note = Note.find_by(
      month_and_year: params[:month_and_year],
      site: params[:site],
    )

    unless @note
      @note = Note.new(
        month_and_year: params[:month_and_year],
        site: params[:site],
      )
    end

    @note.update_attributes text: params[:text]

    if @note
      render json: {success: true}
    else
      render json: {success: false}
    end
  end
end
