class CharacterQuizzesController < ApplicationController
  before_action :set_character_quiz, only: [:show, :edit, :update, :destroy]

  # GET /character_quizzes
  def index
    @character_quizzes = CharacterQuiz.all
  end

  # GET /character_quizzes/1
  def show
  end

  # GET /character_quizzes/new
  def new
    @character_quiz = CharacterQuiz.new
  end

  # GET /character_quizzes/1/edit
  def edit
  end

  # POST /character_quizzes
  def create
    @character_quiz = CharacterQuiz.new(character_quiz_params)

    if @character_quiz.save
      redirect_to @character_quiz, notice: 'Character quiz was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /character_quizzes/1
  def update
    if @character_quiz.update(character_quiz_params)
      redirect_to @character_quiz, notice: 'Character quiz was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /character_quizzes/1
  def destroy
    @character_quiz.destroy
    redirect_to character_quizzes_url, notice: 'Character quiz was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_character_quiz
      @character_quiz = CharacterQuiz.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def character_quiz_params
      params.require(:character_quiz).permit(:quiz_id, :character_id)
    end
end
