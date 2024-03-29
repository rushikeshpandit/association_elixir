defmodule AssociationElixir.Sessions.ResetPassword do
  alias AssociationElixir.Accounts
  alias AssociationElixir.Shared.Tokenr

  def execute(params) do
    params
    |> Map.get("token")
    |> Tokenr.verify_forgot_email_token()
    |> perform(params)
  end

  defp perform({:error, _}, _params), do: {:error, "Invalid token"}

  defp perform({:ok, user}, params) do
    Accounts.update_user(user, params)
  end
end
