defmodule AssociationElixir.Sessions.SendForgotPasswordToEmailTest do
  use AssociationElixir.DataCase
  alias AssociationElixir.Sessions.SendForgotPasswordToEmail
  import AssociationElixir.UserFixtures

  test "send email to reset password" do
    user = user_fixture()

    assert {:ok, returned_user, _token} = SendForgotPasswordToEmail.execute(user.email)
    assert user.email == returned_user.email
  end

  test "throw error when user does not exists" do
    assert {:error, message} = SendForgotPasswordToEmail.execute("somewrongemail&gmail.com")
    assert "User does not exists" == message
  end
end
