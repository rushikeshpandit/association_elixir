defmodule AssociationElixir.LocationsTest do
  use AssociationElixir.DataCase
  import AssociationElixir.CompaniesFixtures
  alias AssociationElixir.Locations

  describe "locations" do
    alias AssociationElixir.Locations.Location

    import AssociationElixir.LocationsFixtures

    @invalid_attrs %{state: nil, address: nil, city: nil, country: nil, pincode: nil}

    test "list_locations/0 returns all locations" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})
      assert Locations.list_locations() == [location]
    end

    test "get_location!/1 returns the location with given id" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})
      assert Locations.get_location!(location.id) == location
    end

    test "create_location/1 with valid data creates a location" do
      company = product_company_fixture()

      valid_attrs = %{
        state: "some state",
        address: "some address",
        city: "some city",
        country: "some country",
        pincode: 560_066,
        company_id: company.id
      }

      assert {:ok, %Location{} = location} = Locations.create_location(valid_attrs)
      assert location.state == "some state"
      assert location.address == "some address"
      assert location.city == "some city"
      assert location.country == "some country"
      assert location.pincode == 560_066
    end

    test "create_location/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Locations.create_location(@invalid_attrs)
    end

    test "update_location/2 with valid data updates the location" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})

      update_attrs = %{
        state: "some updated state",
        address: "some updated address",
        city: "some updated city",
        country: "some updated country",
        pincode: 560_067
      }

      assert {:ok, %Location{} = location} = Locations.update_location(location, update_attrs)
      assert location.state == "some updated state"
      assert location.address == "some updated address"
      assert location.city == "some updated city"
      assert location.country == "some updated country"
      assert location.pincode == 560_067
    end

    test "update_location/2 with invalid data returns error changeset" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})
      assert {:error, %Ecto.Changeset{}} = Locations.update_location(location, @invalid_attrs)
      assert location == Locations.get_location!(location.id)
    end

    test "delete_location/1 deletes the location" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})
      assert {:ok, %Location{}} = Locations.delete_location(location)
      assert_raise Ecto.NoResultsError, fn -> Locations.get_location!(location.id) end
    end

    test "change_location/1 returns a location changeset" do
      company = product_company_fixture()
      location = location_fixture(%{company_id: company.id})
      assert %Ecto.Changeset{} = Locations.change_location(location)
    end

    test "list_locations_by/1 returns all locations that belongs to company" do
      company = product_company_fixture()
      locations = location_fixture(%{company_id: company.id})
      assert Locations.list_locations_by(company.id) == [locations]
    end
  end
end
