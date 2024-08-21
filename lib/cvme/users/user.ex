defmodule Cvme.Users.User do
  use Ecto.Schema

  import EctoCommons.EmailValidator
  import Ecto.Changeset

  alias Ecto.Changeset
  alias Cvme.Experiences.Experience

  @cast_params [:password, :email]
  @update_params [:email]

  schema "users" do
    field :password, :string, virtual: true
    field :password_hash, :string
    field :email, :string
    has_many :experiences, Experience

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @cast_params)
    |> validate_required(@cast_params)
    |> do_validations()
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @cast_params)
    |> validate_required(@update_params)
    |> do_validations()
    |> add_password_hash()
  end

  def do_validations(changeset) do
    changeset
    |> unique_constraint(:email)
    |> validate_email(:email)
  end

  defp add_password_hash(%Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
