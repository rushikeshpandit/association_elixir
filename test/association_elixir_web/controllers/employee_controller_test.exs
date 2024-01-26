defmodule AssociationElixirWeb.EmployeeControllerTest do
  use AssociationElixirWeb.ConnCase
  import AssociationElixir.CompaniesFixtures
  import AssociationElixir.EmployeesFixtures

  alias AssociationElixir.Employees.Employee

  @create_attrs %{
    first_name: "John",
    last_name: "Smith"
  }
  @update_attrs %{
    first_name: "James",
    last_name: "Sandy"
  }
  @invalid_attrs %{first_name: nil, last_name: nil}

  describe "index" do
    setup :include_normal_user_token

    test "lists all employees", %{conn: conn} do
      conn = get(conn, ~p"/api/employees")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create employee" do
    setup :include_normal_user_token

    test "renders employee when data is valid", %{conn: conn} do
      company = product_company_fixture()

      conn =
        post(conn, ~p"/api/employees",
          employee: @create_attrs |> Map.put(:company_id, company.id)
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")

      assert %{
               "id" => ^id,
               "first_name" => "John",
               "last_name" => "Smith"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/employees", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update employee" do
    setup [:create_employee, :include_normal_user_token]

    test "renders employee when data is valid", %{
      conn: conn,
      employee: %Employee{id: id} = employee
    } do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/employees/#{id}")

      assert %{
               "id" => ^id,
               "first_name" => "James",
               "last_name" => "Sandy"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, employee: employee} do
      conn = put(conn, ~p"/api/employees/#{employee}", employee: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete employee" do
    setup [:create_employee, :include_normal_user_token]

    test "deletes chosen employee", %{conn: conn, employee: employee} do
      conn = delete(conn, ~p"/api/employees/#{employee}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/employees/#{employee}")
      end
    end
  end

  defp create_employee(_) do
    company = product_company_fixture()
    employee = employee_fixture(%{company_id: company.id})
    %{employee: employee}
  end
end
