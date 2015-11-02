class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy, :add_to]

  def index
    @quizzes = Quiz.all
  end

  def show
    if params[:query]
      @characters = Character.full_search(params[:query]).paginate(page: params[:page], per_page: 10)
    else
      @characters = Character.paginate(page: params[:page], per_page: 10)
    end
  end

  def new
    @quiz = Quiz.new
  end

  def edit
  end

  def create
    @quiz = current_user.quizzes.build(quiz_params)

    if @quiz.save
      redirect_to @quiz, notice: "Quiz was successfully created."
    else
      render :new
    end
  end

  def update
    if @quiz.update(quiz_params)
      redirect_to @quiz, notice: "Quiz was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @quiz.destroy
    redirect_to quizzes_url, notice: "Quiz was successfully destroyed."
  end

  def add_to
    unless params[:characters].blank?
      characters = Character.where(id: params[:characters].map(&:to_i))
      characters.each do |character|
        @quiz.character_quizzes.find_or_create_by(character_id: character.id)
      end
    end
    redirect_to @quiz
  end

  private

    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    def quiz_params
      params.require(:quiz).permit(:name, :from_language_id, :to_language_id)
    end
end
