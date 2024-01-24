defmodule AssociationElixirWeb.Middleware.EnsureAuthenticated do
  import Plug.Conn
  alias AssociationElixir.Shared.Tokenr

  def init(opt), do: opt

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, user} = Tokenr.verify_auth_token(token),
         true <- user.role in [:USER, :ADMIN, :SUPER_ADMIN] do
      put_req_header(conn, "user_id", user.id)
    else
      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(401, Jason.encode!(%{error: "Invalid/Unauthenticated token"}))
        |> halt()
    end
  end
end
