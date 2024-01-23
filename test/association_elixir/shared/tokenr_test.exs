defmodule AssociationElixir.Shared.TokenrTest do
  use AssociationElixir.DataCase

  alias AssociationElixir.Shared.Tokenr
  import AssociationElixir.UserFixtures

  test "create auth token" do
    user = user_fixture()
    token = Tokenr.generate_auth_token(user)
    {:ok, returned_user} = Tokenr.verify_auth_token(token)

    assert user == returned_user
  end

  test "create forgot email token" do
    user = user_fixture()
    token = Tokenr.generate_forgot_email_token(user)
    {:ok, returned_user} = Tokenr.verify_forgot_email_token(token)

    assert user == returned_user
  end
end
