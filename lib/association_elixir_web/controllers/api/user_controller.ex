defmodule AssociationElixirWeb.Api.UserController do
  use AssociationElixirWeb, :controller
  alias AssociationElixir.Accounts
  alias AssociationElixirWeb.Router.Helpers, as: Routes
  action_fallback AssociationElixirWeb.FallbackController

  def create(conn, %{"user" => user}) do
    with {:ok, user} <- Accounts.create_user(user) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.api_user_path(conn, :show, user))
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  # def update(conn, %{"id" => id, "user" => user_params}) do
  #   user = Accounts.get_user(id)

  #   with {:ok, user} <- Accounts.update_user(user, user_params) do
  #     render(conn, :show, user: user)
  #   end
  # end

  # def delete(conn, %{"id" => id}) do
  #   user = Accounts.get_user(id)

  #   with {:ok, _user} <- Accounts.delete_user(user) do
  #     send_resp(conn, :no_content, "")
  #   end
  # end
end
