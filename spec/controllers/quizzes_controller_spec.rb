require 'rails_helper'

RSpec.describe QuizzesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_quiz) { assigns(:quiz) }
    let(:base_quiz) { create(:quiz) }
    let(:static_quiz) { create(:quiz, name: 'spec-quiz') }
    let(:valid_attributes) { attributes_for(:quiz, name: 'spec-quiz') }
    let(:invalid_attributes) { attributes_for(:quiz, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @quizzes" do
        second_quiz = create :quiz
        get :index
        expect(assigns(:quizzes)).to match_array([base_quiz, second_quiz])
      end
    end
  
    describe "GET show" do
      it "assigns the requested quiz as @quiz" do
        get :show, id: base_quiz
        expect(instance_quiz).to eq(base_quiz)
      end
    end

    describe "GET new" do
      it "assigns a new quiz as @quiz" do
        get :new
        expect(instance_quiz).to be_a_new(Quiz)
      end
    end

    describe "GET edit" do
      it "assigns the requested quiz as @quiz" do
        get :edit, id: base_quiz
        expect(instance_quiz).to eq(base_quiz)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Quiz" do
          expect do
            post :create, quiz: valid_attributes
          end.to change(Quiz, :count).by(1)
        end

        it "assigns a newly created quiz as @quiz" do
          post :create, quiz: valid_attributes
          expect(instance_quiz).to be_a(Quiz)
          expect(instance_quiz).to be_persisted
        end

        it "redirects to the created quiz" do
          post :create, quiz: valid_attributes
          expect(response).to redirect_to(Quiz.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved quiz as @quiz" do
          post :create, quiz: invalid_attributes
          expect(instance_quiz).to be_a_new(Quiz)
        end

        it "re-renders the 'new' template" do
          post :create, quiz: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested quiz as @quiz" do
          put :update, id: static_quiz, quiz: valid_attributes
          static_quiz.reload
          expect(instance_quiz).to eq(static_quiz)
        end

        it "redirects to the quiz" do
          put :update, id: static_quiz, quiz: valid_attributes
          expect(response).to redirect_to(static_quiz)
        end
      end

      describe "with invalid params" do
        it "assigns the quiz as @quiz" do
          put :update, id: static_quiz, quiz: invalid_attributes
          expect(assigns(:quiz)).to eq(static_quiz)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_quiz, quiz: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested quiz" do
        new_quiz = create :quiz
        expect do
          delete :destroy, id: new_quiz
        end.to change(Quiz, :count).by(-1)
      end

      it "redirects to the quiz list" do
        delete :destroy, id: base_quiz
        expect(response).to redirect_to(quizzes_url)
      end
    end
  end
end
