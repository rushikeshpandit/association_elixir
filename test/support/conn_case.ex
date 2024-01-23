defmodule AssociationElixirWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use AssociationElixirWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  alias AssociationElixir.Sessions
  use ExUnit.CaseTemplate
  import AssociationElixir.UserFixtures

  using do
    quote do
      # The default endpoint for testing
      @endpoint AssociationElixirWeb.Endpoint

      use AssociationElixirWeb, :verified_routes
      alias AssociationElixirWeb.Router.Helpers, as: Routes
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import AssociationElixirWeb.ConnCase
    end
  end

  setup tags do
    AssociationElixir.DataCase.setup_sandbox(tags)
    {:ok, conn: Phoenix.ConnTest.build_conn()}
  end

  def include_normal_user_token(%{conn: conn}) do
    user = user_fixture()
    password = "Rushi@7588"
    {:ok, _, token} = Sessions.create(user.email, password)
    conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer " <> token)
    {:ok, conn: conn, user: user, password: password, token: token}
  end

  def include_admin_token(%{conn: conn}) do
    user = admin_fixture()
    password = "Rushi@7588"
    {:ok, _, token} = Sessions.create(user.email, password)
    conn = Plug.Conn.put_req_header(conn, "authorization", "Bearer " <> token)
    {:ok, conn: conn, user: user, password: password, token: token}
  end
end
