defmodule Cvme.Users.User do
  use Ecto.Schema

  import EctoCommons.EmailValidator
  import Ecto.Changeset

  alias Cvme.Experiences.Experience

  @cast_params [:name, :email]
  @update_params [:email]

  @derive {
    Jason.Encoder,
    except: [:__meta__,  :experiences]
  }
  schema "users" do
    field :name, :string
    field :email, :string
    has_many :experiences, Experience

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @cast_params)
    |> validate_required(@cast_params)
    |> do_validations()
  end

  def changeset(user, params) do
    user
    |> cast(params, @cast_params)
    |> validate_required(@update_params)
    |> do_validations()
  end

  def do_validations(changeset) do
    changeset
    |> unique_constraint(:email)
    |> validate_email(:email)
  end
end
