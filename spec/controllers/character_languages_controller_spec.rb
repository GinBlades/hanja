require 'rails_helper'

RSpec.describe CharacterLanguagesController, type: :controller do

  
  describe "Standard CRUD" do
    let(:instance_character_language) { assigns(:character_language) }
    let(:base_character_language) { create(:character_language) }
    let(:static_character_language) { create(:character_language, name: 'spec-character_language') }
    let(:valid_attributes) { attributes_for(:character_language, name: 'spec-character_language') }
    let(:invalid_attributes) { attributes_for(:character_language, name: nil) }
  
    describe "GET #index" do
      it "populates an array of all @character_languages" do
        second_character_language = create :character_language
        get :index
        expect(assigns(:character_languages)).to match_array([base_character_language, second_character_language])
      end
    end
  
    describe "GET show" do
      it "assigns the requested character_language as @character_language" do
        get :show, id: base_character_language
        expect(instance_character_language).to eq(base_character_language)
      end
    end

    describe "GET new" do
      it "assigns a new character_language as @character_language" do
        get :new
        expect(instance_character_language).to be_a_new(CharacterLanguage)
      end
    end

    describe "GET edit" do
      it "assigns the requested character_language as @character_language" do
        get :edit, id: base_character_language
        expect(instance_character_language).to eq(base_character_language)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new CharacterLanguage" do
          expect do
            post :create, character_language: valid_attributes
          end.to change(CharacterLanguage, :count).by(1)
        end

        it "assigns a newly created character_language as @character_language" do
          post :create, character_language: valid_attributes
          expect(instance_character_language).to be_a(CharacterLanguage)
          expect(instance_character_language).to be_persisted
        end

        it "redirects to the created character_language" do
          post :create, character_language: valid_attributes
          expect(response).to redirect_to(CharacterLanguage.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved character_language as @character_language" do
          post :create, character_language: invalid_attributes
          expect(instance_character_language).to be_a_new(CharacterLanguage)
        end

        it "re-renders the 'new' template" do
          post :create, character_language: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested character_language as @character_language" do
          put :update, id: static_character_language, character_language: valid_attributes
          static_character_language.reload
          expect(instance_character_language).to eq(static_character_language)
        end

        it "redirects to the character_language" do
          put :update, id: static_character_language, character_language: valid_attributes
          expect(response).to redirect_to(static_character_language)
        end
      end

      describe "with invalid params" do
        it "assigns the character_language as @character_language" do
          put :update, id: static_character_language, character_language: invalid_attributes
          expect(assigns(:character_language)).to eq(static_character_language)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_character_language, character_language: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested character_language" do
        new_character_language = create :character_language
        expect do
          delete :destroy, id: new_character_language
        end.to change(CharacterLanguage, :count).by(-1)
      end

      it "redirects to the character_language list" do
        delete :destroy, id: base_character_language
        expect(response).to redirect_to(character_languages_url)
      end
    end
  end
end
