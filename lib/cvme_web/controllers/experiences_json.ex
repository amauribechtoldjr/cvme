defmodule CvmeWeb.ExperiencesJSON do
  def create(%{experience: experience}),
    do: %{data: render(experience)}

  def get(%{experience: experience}), do: %{data: render(experience)}

  def delete(%{experience: experience}),
    do: %{data: render(experience)}

  def update(%{experience: experience}),
    do: %{data: render(experience)}

  defp render(experience) do
    %{
      id: experience.id,
      user_id: experience.user_id,
      company: experience.company,
      description: experience.description,
      start_date: experience.start_date,
      end_date: experience.end_date
    }
  end
end
