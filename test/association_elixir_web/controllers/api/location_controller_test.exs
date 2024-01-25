defmodule AssociationElixirWeb.Api.LocationControllerTest do
  use AssociationElixirWeb.ConnCase

  describe "list location" do
    setup [:include_normal_user_token]

    test "lists all locations", %{conn: conn} do
      conn = get(conn, Routes.api_location_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
