require_relative '../../lib/permissions'

describe Permissions do

before(:each) do
  # @user = mock_model()
  # @user.stub!(:email).and_return "max@gawker.com"
  # @user.stub!(:politburo).and_return false
  @user = instance_double("User", {
                                    email: "max@gawker.com",
                                    politburo: false
                                  }
                         )
  @politburo_user = instance_double("User", {
                                    email: "craggs@gawker.com",
                                    politburo: true
                                  }
                         )

  # @post = instance_double("Post", {
  #                                   domain: "gawker.com"
  #                                 }
  #                        )
end

  it "let's users with the same domain do things" do
    expect(Permissions.site_owner?(@user, "gawker.com")).to eq true
    expect(Permissions.site_owner?(@politburo_user, "gawker.com")).to eq false
  end
end
