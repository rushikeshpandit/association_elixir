defmodule AssociationElixir.CompaniesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `AssociationElixir.Companies` context.
  """

  def company_attrs(attrs \\ %{}) do
    valid_attrs = %{
      description: "Fintech company",
      name: "FIS Global"
    }

    Enum.into(attrs, valid_attrs)
  end

  @doc """
  Generate a company.
  """
  def product_company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> company_attrs()
      |> Map.put(:type, "PRODUCT")
      |> AssociationElixir.Companies.create_company()

    company
  end

  def service_company_fixture(attrs \\ %{}) do
    {:ok, company} =
      attrs
      |> company_attrs()
      |> Map.put(:type, "SERVICE")
      |> AssociationElixir.Companies.create_company()

    company
  end
end
