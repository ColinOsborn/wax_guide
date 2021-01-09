require 'rails_helper'

RSpec.describe "users/edit", type: :view do
  before(:each) do
    @user = assign(:user, User.create!(
      username: "MyString",
      email: "MyString",
      first_name: "MyString",
      last_name: "MyString",
      password: "",
      password_confirmation: ""
    ))
  end

  it "renders the edit user form" do
    render

    assert_select "form[action=?][method=?]", user_path(@user), "post" do

      assert_select "input[name=?]", "user[username]"

      assert_select "input[name=?]", "user[email]"

      assert_select "input[name=?]", "user[first_name]"

      assert_select "input[name=?]", "user[last_name]"

      assert_select "input[name=?]", "user[password]"

      assert_select "input[name=?]", "user[password_confirmation]"
    end
  end
end
