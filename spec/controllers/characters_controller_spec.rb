require 'rails_helper'

RSpec.describe CharactersController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_character) { assigns(:character) }
    let(:base_character) { create(:character) }
    let(:static_character) { create(:character, modern: 'spec-character') }
    let(:valid_attributes) { attributes_for(:character, modern: 'spec-character') }
    let(:invalid_attributes) { attributes_for(:character, modern: nil) }
  
    describe "GET #index" do
      it "populates an array of all @characters" do
        second_character = create :character
        get :index
        expect(assigns(:characters)).to match_array([base_character, second_character])
      end
    end
  
    describe "GET show" do
      it "assigns the requested character as @character" do
        get :show, id: base_character
        expect(instance_character).to eq(base_character)
      end
    end

    describe "GET new" do
      it "assigns a new character as @character" do
        get :new
        expect(instance_character).to be_a_new(Character)
      end
    end

    describe "GET edit" do
      it "assigns the requested character as @character" do
        get :edit, id: base_character
        expect(instance_character).to eq(base_character)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Character" do
          expect do
            post :create, character: valid_attributes
          end.to change(Character, :count).by(1)
        end

        it "assigns a newly created character as @character" do
          post :create, character: valid_attributes
          expect(instance_character).to be_a(Character)
          expect(instance_character).to be_persisted
        end

        it "redirects to the created character" do
          post :create, character: valid_attributes
          expect(response).to redirect_to(Character.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved character as @character" do
          post :create, character: invalid_attributes
          expect(instance_character).to be_a_new(Character)
        end

        it "re-renders the 'new' template" do
          post :create, character: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested character as @character" do
          put :update, id: static_character, character: valid_attributes
          static_character.reload
          expect(instance_character).to eq(static_character)
        end

        it "redirects to the character" do
          put :update, id: static_character, character: valid_attributes
          expect(response).to redirect_to(static_character)
        end
      end

      describe "with invalid params" do
        it "assigns the character as @character" do
          put :update, id: static_character, character: invalid_attributes
          expect(assigns(:character)).to eq(static_character)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_character, character: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested character" do
        new_character = create :character
        expect do
          delete :destroy, id: new_character
        end.to change(Character, :count).by(-1)
      end

      it "redirects to the character list" do
        delete :destroy, id: base_character
        expect(response).to redirect_to(characters_url)
      end
    end
  end
end
