class CharactersController < ApplicationController
  before_action :set_character, only: [:show, :edit, :update, :destroy, :add_languages]

  def index
    @q = Character.ransack(params[:q])
    @characters = @q.result(uniq: true).paginate(page: params[:page], per_page: 50)
  end

  def show
  end

  def new
    @character = Character.new
  end

  def edit
  end

  def create
    @character = Character.new(character_params)

    if @character.save
      redirect_to @character, notice: 'Character was successfully created.'
    else
      render :new
    end
  end

  def update
    if @character.update(character_params)
      redirect_to @character, notice: 'Character was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @character.destroy
    redirect_to characters_url, notice: 'Character was successfully destroyed.'
  end

  def add_languages
    als = AddLanguageService.new(params)
    als.add_languages
    redirect_to @character
  end

  private
    def set_character
      @character = Character.find(params[:id])
    end

    def character_params
      params.require(:character).permit(:modern, :traditional, :radical, :strokes, :grade)
    end
end
