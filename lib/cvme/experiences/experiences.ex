defmodule Cvme.Experiences.Experience do
  use Ecto.Schema

  import Ecto.Changeset

  alias Ecto.Changeset
  alias Cvme.Users.User

  @cast_params [:company, :description, :start_date, :end_date, :user_id]
  @required_params [:company, :description, :start_date, :user_id]

  schema "experiences" do
    field :company, :string
    field :description, :string
    field :start_date, :date
    field :end_date, :date
    belongs_to :user, User

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @cast_params)
    |> validate_required(@required_params)
    |> validate_dates(%__MODULE__{})
  end

  def changeset(experience, params) do
    experience
    |> cast(params, @cast_params)
    |> validate_required(@required_params)
    |> validate_dates(experience)
  end

  defp validate_dates(%Changeset{valid?: true, changes: %{start_date: start_date, end_date: end_date}} = changeset, _experience) do
    changeset
    |> compare_start_with_end_date(start_date, end_date)
    |> validate_date_range(start_date, :start_date)
    |> validate_date_range(end_date, :end_date)
  end

  defp validate_dates(%Changeset{valid?: true, changes: %{start_date: start_date}} = changeset, %{end_date: end_date} = _experience) do
    case end_date do
      nil -> changeset
              |> validate_date_range(start_date, :start_date)

      value -> changeset
                |> compare_start_with_end_date(start_date, value)
                |> validate_date_range(start_date, :start_date)
    end
  end

  defp validate_dates(%Changeset{valid?: true, changes: %{end_date: end_date}} = changeset, experience) do
    changeset
    |> compare_start_with_end_date(experience.start_date, end_date)
    |> validate_date_range(end_date, :end_date)
  end

  defp validate_dates(changeset, _experience) do
    changeset
  end

  defp compare_start_with_end_date(changeset, start_date, end_date) do
    valid_start_date = Date.diff(start_date, end_date) <= 0

    case valid_start_date do
      false -> changeset
              |> add_error(:start_date, "Should be smaller than end_date")

      true -> changeset
    end
  end

  defp validate_date_range(changeset, date, field) do
    valid_date_range = Date.diff(date, Date.utc_today()) <= 0

    case valid_date_range do
      false -> changeset
              |> add_error(field, "Should be smaller or equal today")

      true -> changeset
    end
  end
end
