defmodule AssociationElixirWeb.Api.CompaniesController do
  use AssociationElixirWeb, :controller

  alias AssociationElixir.Companies

  action_fallback AssociationElixirWeb.FallbackController

  def index(conn, _params) do
    companies = Companies.list_companies()
    render(conn, :index, companies: companies)
  end

  def show(conn, %{"id" => id}) do
    company = Companies.get_company!(id)
    render(conn, :show, company: company)
  end
end
