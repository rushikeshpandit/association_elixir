defmodule AssociationElixir.EmployeesTest do
  use AssociationElixir.DataCase
  import AssociationElixir.CompaniesFixtures
  import AssociationElixir.DeparmentsFixtures
  alias AssociationElixir.Employees
  alias AssociationElixir.Employees.Employee
  import AssociationElixir.EmployeesFixtures
  import AssociationElixir.LocationsFixtures

  describe "employees" do
    @invalid_attrs %{first_name: nil, last_name: nil}

    test "list_employees/0 returns all employees" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      assert Employees.list_employees() == [employee]
    end

    test "get_employee!/1 returns the employee with given id" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      assert Employees.get_employee!(employee.id) == employee
    end

    test "create_employee/1 with valid data creates a employee" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      valid_attrs = %{
        first_name: "some first_name",
        last_name: "some last_name",
        company_id: company.id,
        location_id: location.id,
        department_id: department.id
      }

      assert {:ok, %Employee{} = employee} = Employees.create_employee(valid_attrs)
      assert employee.first_name == "some first_name"
      assert employee.last_name == "some last_name"
    end

    test "create_employee/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Employees.create_employee(@invalid_attrs)
    end

    test "update_employee/2 with valid data updates the employee" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      update_attrs = %{first_name: "some updated first_name", last_name: "some updated last_name"}

      assert {:ok, %Employee{} = employee} = Employees.update_employee(employee, update_attrs)
      assert employee.first_name == "some updated first_name"
      assert employee.last_name == "some updated last_name"
    end

    test "update_employee/2 with invalid data returns error changeset" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      assert {:error, %Ecto.Changeset{}} = Employees.update_employee(employee, @invalid_attrs)
      assert employee == Employees.get_employee!(employee.id)
    end

    test "delete_employee/1 deletes the employee" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      assert {:ok, %Employee{}} = Employees.delete_employee(employee)
      assert_raise Ecto.NoResultsError, fn -> Employees.get_employee!(employee.id) end
    end

    test "change_employee/1 returns a employee changeset" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      location = location_fixture(%{company_id: company.id})

      employee =
        employee_fixture(%{
          company_id: company.id,
          location_id: location.id,
          department_id: department.id
        })

      assert %Ecto.Changeset{} = Employees.change_employee(employee)
    end
  end
end
