class CharacterLanguagesController < ApplicationController
  before_action :set_character_language, only: [:show, :edit, :update, :destroy]

  # GET /character_languages
  def index
    @character_languages = CharacterLanguage.all
  end

  # GET /character_languages/1
  def show
  end

  # GET /character_languages/new
  def new
    @character_language = CharacterLanguage.new
  end

  # GET /character_languages/1/edit
  def edit
  end

  # POST /character_languages
  def create
    @character_language = CharacterLanguage.new(character_language_params)

    if @character_language.save
      redirect_to @character_language, notice: 'Character language was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /character_languages/1
  def update
    if @character_language.update(character_language_params)
      redirect_to @character_language, notice: 'Character language was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /character_languages/1
  def destroy
    @character_language.destroy
    redirect_to character_languages_url, notice: 'Character language was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_language
      @character_language = CharacterLanguage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def character_language_params
      params.require(:character_language).permit(:language_id, :character_id, :meaning, :pronunciation)
    end
end
