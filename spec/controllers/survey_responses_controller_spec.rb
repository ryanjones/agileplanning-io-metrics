require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe SurveyResponsesController, type: :controller do
  let(:current_user) { create(:user) }

  let(:expected_mood) { Mood::GOOD }

  # This should return the minimal set of attributes required to create a valid
  # SurveyResponse. As you add validations to SurveyResponse, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    {
        survey_answers_attributes: {
            '0' => { :mood_id => expected_mood.id, :survey_question_id => survey_question.id }
        }

    }
  }

  let(:invalid_attributes) {
    {
        survey_answers_attributes: {
            '0' => { :survey_question_id => survey_question.id }
        }
    }
  }

  let(:survey_question) { build(:survey_question, title: 'Some Question') }
  let(:survey) { create(:survey, survey_questions: [survey_question]) }
  let(:survey_instance) { create(:survey_instance, survey: survey) }
  let!(:survey_response) { create(:survey_response, survey_instance: survey_instance) }

  before(:each) do
    sign_in current_user
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SurveyResponsesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns the survey instance" do
      get :index, { survey_instance_id: survey_instance.to_param }, valid_session
      expect(assigns(:survey_instance)).to eq(survey_instance)
    end
  end

  describe "GET #new" do
    it "assigns a new survey_response as @survey_response" do
      get :new, { survey_instance_id: survey_instance.to_param }, valid_session
      expect(assigns(:survey_response)).to be_a_new(SurveyResponse)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SurveyResponse" do
        expect {
          post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => valid_attributes }, valid_session
        }.to change(SurveyResponse, :count).by(1)
      end

      it "assigns a newly created survey_response as @survey_response" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => valid_attributes }, valid_session
        expect(assigns(:survey_response)).to be_a(SurveyResponse)
        expect(assigns(:survey_response)).to be_persisted
      end

      it "assigns the current user id" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => valid_attributes }, valid_session
        expect(assigns(:survey_response).user_id).to eq(current_user.id)
      end

      it "creates answers for each question" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => valid_attributes }, valid_session
        expect(assigns(:survey_response).survey_answers.first.mood).to eq(expected_mood)
      end

      it "redirects to the list of responses" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => valid_attributes }, valid_session
        expect(response).to redirect_to(survey_instance_survey_responses_path(survey_instance))
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved survey_response as @survey_response" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => invalid_attributes }, valid_session
        expect(assigns(:survey_response)).to be_a_new(SurveyResponse)
      end

      it "re-renders the 'new' template" do
        post :create, { :survey_instance_id => survey_instance.to_param, :survey_response => invalid_attributes }, valid_session
        expect(response).to render_template("new")
      end
    end
  end
end
