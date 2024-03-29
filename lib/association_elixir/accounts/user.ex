defmodule AssociationElixir.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  @role_values ~w/USER ADMIN SUPER_ADMIN/a
  @fields ~w/role/a
  @required_fields ~w/first_name last_name user_name password password_confirmation email/a
  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "users" do
    field :first_name, :string
    field :last_name, :string
    field :user_name, :string
    field :password, :string, virtual: true
    field :password_confirmation, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    field :role, Ecto.Enum, values: @role_values, default: :USER

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, @fields ++ @required_fields)
    |> validate_required(@required_fields)
    |> validate_format(:email, ~r/@/, message: "Enter valid email")
    |> update_change(:email, &String.downcase/1)
    |> validate_length(:password,
      min: 6,
      max: 100,
      message: "Password should be minimum 6 characters"
    )
    |> validate_confirmation(:password, message: "Password does not match")
    |> unique_constraint(:email)
    |> unique_constraint(:user_name)
    |> hash_password()
  end

  defp hash_password(%{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp hash_password(changeset), do: changeset

  def update_user(user, params) do
    changeset(user, params)
  end
end
