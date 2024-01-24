defmodule AssociationElixirWeb.Api.SuperAdmin.CompanyJSON do
  alias AssociationElixir.Companies.Company

#   @doc """
#   Renders a list of companies.
#   """
#   def index(%{companies: companies}) do
#     %{data: for(company <- companies, do: data(company))}
#   end

  @doc """
  Renders a single company.
  """
  def show(%{company: company}) do
    %{data: data(company)}
  end

  defp data(%Company{} = company) do
    %{
      id: company.id,
      name: company.name,
      description: company.description,
      type: company.type
    }
  end
end
