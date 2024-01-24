defmodule AssociationElixirWeb.Api.DepartmentControllerTest do
  use AssociationElixirWeb.ConnCase

  describe "list department" do
    setup [:include_normal_user_token]

    test "lists all departments", %{conn: conn} do
      conn = get(conn, Routes.api_department_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end
end
