defmodule AssociationElixir.CompaniesTest do
  use AssociationElixir.DataCase
  alias AssociationElixir.Companies
  import AssociationElixir.CompaniesFixtures
  alias AssociationElixir.Companies.Company

  describe "companies" do
    test "list_companies/0 returns all companies" do
      company = product_company_fixture()
      assert Companies.list_companies() == [company]
    end

    test "get_company!/1 returns the company with given id" do
      company = product_company_fixture()
      assert Companies.get_company!(company.id) == company
    end

    test "create_company/1 with valid data creates a company" do
      valid_attrs = %{
        name: "FIS Global",
        description: "Fintech company"
      }

      assert {:ok, %Company{} = company} = Companies.create_company(valid_attrs)
      assert company.name == "FIS Global"
      assert company.type == :SERVICE
      assert company.description == "Fintech company"
    end

    test "create_company/1 with invalid data returns error changeset" do
      invalid_attrs = %{
        name: "FIS",
        description: "Fintech company"
      }

      assert {:error, %Ecto.Changeset{}} = Companies.create_company(invalid_attrs)
    end

    test "update_company/2 with valid data updates the company" do
      company = product_company_fixture()

      update_attrs = %{
        name: "some updated name",
        type: "SERVICE",
        description: "some updated description"
      }

      assert {:ok, %Company{} = company} = Companies.update_company(company, update_attrs)
      assert company.name == "some updated name"
      assert company.type == :SERVICE
      assert company.description == "some updated description"
    end

    # test "update_company/2 with invalid data returns error changeset" do
    #   company = product_company_fixture()

    #   assert {:error, changeset} =
    #            Companies.update_company(company, %{name: "FIS"})

    #   assert "Company name should be minimum 6 characters" in errors_on(changeset).description
    # end

    test "delete_company/1 deletes the company" do
      company = product_company_fixture()
      assert {:ok, %Company{}} = Companies.delete_company(company)
      assert_raise Ecto.NoResultsError, fn -> Companies.get_company!(company.id) end
    end

    test "change_company/1 returns a company changeset" do
      company = product_company_fixture()
      assert %Ecto.Changeset{} = Companies.change_company(company)
    end
  end
end
