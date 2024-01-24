defmodule AssociationElixir.DeparmentsTest do
  import AssociationElixir.CompaniesFixtures
  use AssociationElixir.DataCase
  alias AssociationElixir.Deparments
  alias AssociationElixir.Deparments.Department
  import AssociationElixir.DeparmentsFixtures

  describe "departments" do
    test "list_departments/0 returns all departments" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      assert Deparments.list_departments() == [department]
    end

    test "get_department!/1 returns the department with given id" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      assert Deparments.get_department!(department.id) == department
    end

    test "create_department/1 with valid data creates a department" do
      company = product_company_fixture()
      valid_attrs = %{name: "some name", budget: 42, company_id: company.id}

      assert {:ok, %Department{} = department} = Deparments.create_department(valid_attrs)
      assert department.name == "some name"
      assert department.budget == 42
    end

    test "create_department/1 with invalid data returns error changeset" do
      company = product_company_fixture()

      department = %{
        budget: 10_000,
        name: "Human Resource",
        companu_id: company.id
      }

      assert {:error, %Ecto.Changeset{}} = Deparments.create_department(department)
    end

    test "update_department/2 with valid data updates the department" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      update_attrs = %{name: "some updated name", budget: 43}

      assert {:ok, %Department{} = department} =
               Deparments.update_department(department, update_attrs)

      assert department.name == "some updated name"
      assert department.budget == 43
    end

    test "update_department/2 with invalid data returns error changeset" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})

      assert {:error, %Ecto.Changeset{}} =
               Deparments.update_department(department, %{name: ""})

      assert department == Deparments.get_department!(department.id)
    end

    test "delete_department/1 deletes the department" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      assert {:ok, %Department{}} = Deparments.delete_department(department)
      assert_raise Ecto.NoResultsError, fn -> Deparments.get_department!(department.id) end
    end

    test "change_department/1 returns a department changeset" do
      company = product_company_fixture()
      department = department_fixture(%{company_id: company.id})
      assert %Ecto.Changeset{} = Deparments.change_department(department)
    end
  end
end
