defmodule AssociationElixirWeb.Api.SuperAdmin.DepartmentControllerTest do
  use AssociationElixirWeb.ConnCase
  import AssociationElixir.CompaniesFixtures
  import AssociationElixir.DeparmentsFixtures

  alias AssociationElixir.Deparments.Department

  describe "index" do
    test "throw error when try listing departments without permission", %{conn: conn} do
      conn = get(conn, Routes.api_department_path(conn, :index))
      assert json_response(conn, 401)["error"] == "Invalid/Unauthenticated token"
    end
  end

  describe "create department" do
    setup :include_super_admin_token

    test "renders department when data is valid", %{conn: conn} do
      company = product_company_fixture()
      attr = department_attrs(%{company_id: company.id})

      conn =
        post(conn, Routes.api_super_admin_department_path(conn, :create, department: attr))

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_department_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "budget" => 100_000,
               "name" => "Human Resource"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      company = product_company_fixture()
      attr = department_attrs(%{company_id: company.id})
      invalid_department = attr |> Map.put(:name, "")

      conn =
        post(
          conn,
          Routes.api_super_admin_department_path(conn, :create, department: invalid_department)
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update department" do
    setup [:create_department, :include_super_admin_token]

    test "renders department when data is valid", %{
      conn: conn,
      department: %Department{id: id} = department
    } do
      conn =
        put(conn, Routes.api_super_admin_department_path(conn, :update, department.id),
          department: %{name: "FINANCE"}
        )

      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_department_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "budget" => 100_000,
               "name" => "FINANCE"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete department" do
    setup [:create_department, :include_super_admin_token]

    test "deletes chosen department", %{conn: conn, department: department} do
      conn = delete(conn, Routes.api_super_admin_department_path(conn, :delete, department.id))

      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/departments/#{department}")
      end
    end
  end

  defp create_department(_) do
    company = product_company_fixture()
    department = department_fixture(%{company_id: company.id})
    %{department: department}
  end
end
