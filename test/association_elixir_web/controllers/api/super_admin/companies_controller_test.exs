defmodule AssociationElixirWeb.Api.SuperAdmin.CompaniesControllerTest do
  use AssociationElixirWeb.ConnCase
  import AssociationElixir.CompaniesFixtures

  test "throw error when try listing companies without permission", %{conn: conn} do
    conn = get(conn, Routes.api_companies_path(conn, :index))
    assert json_response(conn, 401)["error"] == "Invalid/Unauthenticated token"
  end

  describe "create company" do
    setup :include_super_admin_token

    test "renders company when data is valid", %{conn: conn} do
      attrs = company_attrs()
      conn = post(conn, Routes.api_super_admin_company_path(conn, :create, company: attrs))
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_companies_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "description" => "Fintech company",
               "name" => "FIS Global",
               "type" => "SERVICE"
             } = json_response(conn, 200)["data"]
    end
  end

  describe "update company" do
    setup [:create_company, :include_super_admin_token]

    test "renders company when data is valid", %{conn: conn, company: company} do
      conn =
        put(conn, Routes.api_super_admin_company_path(conn, :update, company.id),
          company: %{name: "FISERV"}
        )

      assert %{"id" => id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_companies_path(conn, :show, id))

      name = String.upcase("Fiserv")

      assert %{
               "id" => ^id,
               "name" => ^name
             } = json_response(conn, 200)["data"]
    end
  end

  describe "delete company" do
    setup [:create_company, :include_super_admin_token]

    test "deletes chosen company", %{conn: conn, company: company} do
      conn = delete(conn, Routes.api_super_admin_company_path(conn, :delete, company.id))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.api_companies_path(conn, :show, company.id))
      end
    end
  end

  defp create_company(_) do
    company = product_company_fixture()
    %{company: company}
  end
end
