require "rails_helper"

RSpec.describe LanguagesController, type: :controller do
  describe "Standard CRUD" do
    let(:instance_language) { assigns(:language) }
    let(:base_language) { create(:language) }
    let(:static_language) { create(:language, name: "spec-language") }
    let(:valid_attributes) { attributes_for(:language, name: "spec-language") }
    let(:invalid_attributes) { attributes_for(:language, name: nil) }

    login_user

    describe "GET #index" do
      it "populates an array of all @languages" do
        second_language = create :language
        get :index
        expect(assigns(:languages)).to match_array([base_language, second_language])
      end
    end

    describe "GET show" do
      it "assigns the requested language as @language" do
        get :show, id: base_language
        expect(instance_language).to eq(base_language)
      end
    end

    describe "GET new" do
      it "assigns a new language as @language" do
        get :new
        expect(instance_language).to be_a_new(Language)
      end
    end

    describe "GET edit" do
      it "assigns the requested language as @language" do
        get :edit, id: base_language
        expect(instance_language).to eq(base_language)
      end
    end

    describe "POST create" do
      describe "with valid params" do
        it "creates a new Language" do
          expect do
            post :create, language: valid_attributes
          end.to change(Language, :count).by(1)
        end

        it "assigns a newly created language as @language" do
          post :create, language: valid_attributes
          expect(instance_language).to be_a(Language)
          expect(instance_language).to be_persisted
        end

        it "redirects to the created language" do
          post :create, language: valid_attributes
          expect(response).to redirect_to(Language.last)
        end
      end

      describe "with invalid params" do
        it "assigns a newly created but unsaved language as @language" do
          post :create, language: invalid_attributes
          expect(instance_language).to be_a_new(Language)
        end

        it "re-renders the 'new' template" do
          post :create, language: invalid_attributes
          expect(response).to render_template("new")
        end
      end
    end

    describe "PUT update" do
      describe "with valid params" do
        it "assigns the requested language as @language" do
          put :update, id: static_language, language: valid_attributes
          static_language.reload
          expect(instance_language).to eq(static_language)
        end

        it "redirects to the language" do
          put :update, id: static_language, language: valid_attributes
          expect(response).to redirect_to(static_language)
        end
      end

      describe "with invalid params" do
        it "assigns the language as @language" do
          put :update, id: static_language, language: invalid_attributes
          expect(assigns(:language)).to eq(static_language)
        end

        it "re-renders the 'edit' template" do
          put :update, id: static_language, language: invalid_attributes
          expect(response).to render_template("edit")
        end
      end
    end

    describe "DELETE destroy" do
      it "destroys the requested language" do
        new_language = create :language
        expect do
          delete :destroy, id: new_language
        end.to change(Language, :count).by(-1)
      end

      it "redirects to the language list" do
        delete :destroy, id: base_language
        expect(response).to redirect_to(languages_url)
      end
    end
  end
end
