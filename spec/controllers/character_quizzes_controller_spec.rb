require 'rails_helper'

RSpec.describe CharacterQuizzesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_character_quiz) { assigns(:character_quiz) }
    let(:base_character_quiz) { create(:character_quiz) }
    let(:static_character_quiz) { create(:character_quiz, name: 'spec-character_quiz') }
    let(:valid_attributes) { attributes_for(:character_quiz, name: 'spec-character_quiz') }
    let(:invalid_attributes) { attributes_for(:character_quiz, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @character_quizzes" do
        second_character_quiz = create :character_quiz
        get :index
        expect(assigns(:character_quizzes)).to match_array([base_character_quiz, second_character_quiz])
      end
    end
  
    describe "GET show" do
      it "assigns the requested character_quiz as @character_quiz" do
        get :show, id: base_character_quiz
        expect(instance_character_quiz).to eq(base_character_quiz)
      end
    end

    describe "GET new" do
      it "assigns a new character_quiz as @character_quiz" do
        get :new
        expect(instance_character_quiz).to be_a_new(CharacterQuiz)
      end
    end

    describe "GET edit" do
      it "assigns the requested character_quiz as @character_quiz" do
        get :edit, id: base_character_quiz
        expect(instance_character_quiz).to eq(base_character_quiz)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new CharacterQuiz" do
          expect do
            post :create, character_quiz: valid_attributes
          end.to change(CharacterQuiz, :count).by(1)
        end

        it "assigns a newly created character_quiz as @character_quiz" do
          post :create, character_quiz: valid_attributes
          expect(instance_character_quiz).to be_a(CharacterQuiz)
          expect(instance_character_quiz).to be_persisted
        end

        it "redirects to the created character_quiz" do
          post :create, character_quiz: valid_attributes
          expect(response).to redirect_to(CharacterQuiz.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved character_quiz as @character_quiz" do
          post :create, character_quiz: invalid_attributes
          expect(instance_character_quiz).to be_a_new(CharacterQuiz)
        end

        it "re-renders the 'new' template" do
          post :create, character_quiz: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested character_quiz as @character_quiz" do
          put :update, id: static_character_quiz, character_quiz: valid_attributes
          static_character_quiz.reload
          expect(instance_character_quiz).to eq(static_character_quiz)
        end

        it "redirects to the character_quiz" do
          put :update, id: static_character_quiz, character_quiz: valid_attributes
          expect(response).to redirect_to(static_character_quiz)
        end
      end

      describe "with invalid params" do
        it "assigns the character_quiz as @character_quiz" do
          put :update, id: static_character_quiz, character_quiz: invalid_attributes
          expect(assigns(:character_quiz)).to eq(static_character_quiz)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_character_quiz, character_quiz: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested character_quiz" do
        new_character_quiz = create :character_quiz
        expect do
          delete :destroy, id: new_character_quiz
        end.to change(CharacterQuiz, :count).by(-1)
      end

      it "redirects to the character_quiz list" do
        delete :destroy, id: base_character_quiz
        expect(response).to redirect_to(character_quizzes_url)
      end
    end
  end
end
