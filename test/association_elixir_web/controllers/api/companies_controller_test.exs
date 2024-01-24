defmodule AssociationElixirWeb.Api.CompaniesControllerTest do
  use AssociationElixirWeb.ConnCase

  describe "list company" do
    setup [:include_normal_user_token]

    test "lists all companies", %{conn: conn} do
      conn = get(conn, Routes.api_companies_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
