module LoginHelper
  def login_user
    before do
      user = double("user")
      allow_message_expectations_on_nil
      allow(request.env["warden"]).to receive(:authenticate!).and_return(user)
      allow(controller).to receive(:current_user).and_return(user)
    end
  end
end
