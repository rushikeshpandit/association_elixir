defmodule AssociationElixirWeb.UserJSON do
  alias AssociationElixir.Accounts.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      first_name: user.first_name,
      last_name: user.last_name,
      user_name: user.user_name,
      password: user.password,
      password_confirmation: user.password_confirmation,
      password_hash: user.password_hash,
      email: user.email,
      role: user.role
    }
  end
end
