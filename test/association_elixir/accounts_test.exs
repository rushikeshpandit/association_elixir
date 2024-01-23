defmodule AssociationElixir.AccountsTest do
  use AssociationElixir.DataCase
  alias AssociationElixir.Accounts
  import AssociationElixir.UserFixtures

  describe "get user" do
    test "get_user/1" do
      user = user_fixture()

      assert Accounts.get_user!(user.id).email == user.email
    end
  end

  describe "create user" do
    test "creat_user/1 with valid data" do
      valid_attrs = %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rushi@7588",
        password_confirmation: "Rushi@7588",
        email: "RUSHIKESH.d.pandit@gmail.com"
      }

      assert {:ok, user} = Accounts.create_user(valid_attrs)

      assert user.first_name == valid_attrs.first_name
      assert user.last_name == valid_attrs.last_name
      assert user.user_name == valid_attrs.user_name
      assert user.email == String.downcase(valid_attrs.email)
    end

    test "creat_user/1 with invalid email" do
      valid_attrs = %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rushi@7588",
        password_confirmation: "Rushi@7588",
        email: "rushikesh.d.pandit"
      }

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "Enter valid email" in errors_on(changeset).email
    end

    test "creat_user/1 with short pasword" do
      valid_attrs = %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rus",
        password_confirmation: "Rushi@7588",
        email: "rushikesh.d.pandit"
      }

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "Password should be minimum 6 characters" in errors_on(changeset).password
    end

    test "therow error when password does not match creat_user/1" do
      valid_attrs = %{
        first_name: "rushikesh",
        last_name: "pandit",
        user_name: "rushikeshpandit",
        password: "Rushi@758",
        password_confirmation: "Rushi@7588",
        email: "rushikesh.d.pandit@gmail.com"
      }

      assert {:error, changeset} = Accounts.create_user(valid_attrs)
      assert "Password does not match" in errors_on(changeset).password_confirmation
    end
  end
end
