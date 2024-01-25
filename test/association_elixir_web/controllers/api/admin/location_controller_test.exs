defmodule AssociationElixirWeb.Api.Admin.LocationControllerTest do
  use AssociationElixirWeb.ConnCase
  import AssociationElixir.CompaniesFixtures
  import AssociationElixir.LocationsFixtures

  alias AssociationElixir.Locations.Location

  @create_attrs %{
    state: "Karnataka",
    address: "Whitefield",
    city: "Bangalore",
    country: "India",
    pincode: 560_066
  }
  @update_attrs %{
    state: "Karnataka",
    address: "Varthur",
    city: "Bangalore",
    country: "India",
    pincode: 560_067
  }
  @invalid_attrs %{state: nil, address: nil, city: nil, country: nil, pincode: nil}

  describe "index" do
    test "throw error when try listing departments without permission", %{conn: conn} do
      conn = get(conn, Routes.api_location_path(conn, :index))
      assert json_response(conn, 401)["error"] == "Invalid/Unauthenticated token"
    end
  end

  describe "create location" do
    setup :include_admin_token

    test "renders location when data is valid", %{conn: conn} do
      company = product_company_fixture()

      conn =
        post(
          conn,
          Routes.api_admin_location_path(conn, :create,
            location: @create_attrs |> Map.put(:company_id, company.id)
          )
        )

      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.api_location_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "Whitefield",
               "city" => "Bangalore",
               "country" => "India",
               "pincode" => 560_066,
               "state" => "Karnataka"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.api_admin_location_path(conn, :create, location: @invalid_attrs))
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update location" do
    setup [:create_location, :include_admin_token]

    test "renders location when data is valid", %{
      conn: conn,
      location: %Location{id: id} = _
    } do
      conn = put(conn, Routes.api_admin_location_path(conn, :update, id), location: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.api_location_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "address" => "Varthur",
               "city" => "Bangalore",
               "country" => "India",
               "pincode" => 560_067,
               "state" => "Karnataka"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, location: location} do
      conn =
        put(conn, Routes.api_admin_location_path(conn, :update, location.id),
          location: @invalid_attrs
        )

      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete location" do
    setup [:create_location, :include_admin_token]

    test "deletes chosen location", %{conn: conn, location: location} do
      conn = delete(conn, Routes.api_admin_location_path(conn, :delete, location))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        _ = get(conn, Routes.api_location_path(conn, :show, location.id))
      end
    end
  end

  defp create_location(_) do
    company = product_company_fixture()
    location = location_fixture(%{company_id: company.id})
    %{location: location}
  end
end
