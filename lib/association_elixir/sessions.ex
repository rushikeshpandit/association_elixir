defmodule AssociationElixir.Sessions do
  alias AssociationElixir.Accounts.User
  alias AssociationElixir.Repo
  alias AssociationElixir.Sessions.ResetPassword
  alias AssociationElixir.Sessions.SendForgotPasswordToEmail
  alias AssociationElixir.Shared.Tokenr
  @error_invalid_credentials {:error, "Email or password is incorrect"}

  def me(token) do
    Tokenr.verify_auth_token(token)
  end

  def create(email, password) do
    User
    |> Repo.get_by(email: email)
    |> check_if_user_exists()
    |> validate_password(password)
  end

  def check_if_user_exists(nil), do: @error_invalid_credentials
  def check_if_user_exists(user), do: user

  defp validate_password({:error, _} = err, _password), do: err

  defp validate_password(user, password) do
    if Argon2.verify_pass(password, user.password_hash) do
      token = Tokenr.generate_auth_token(user)
      {:ok, user, token}
    else
      @error_invalid_credentials
    end
  end

  def forgot_password(email) do
    SendForgotPasswordToEmail.execute(email)
  end

  def reset_password(params) do
    ResetPassword.execute(params)
  end
end
