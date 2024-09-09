defmodule CvmeWeb.ExperiencesJSON do
  def experiences(%{experiences: experiences}), do: %{data: experiences}

  def create(%{experience: experience}),
    do: %{data: experience}

  def get(%{experience: experience}), do: %{data: experience}

  def delete(%{experience: experience}),
    do: %{data: experience}

  def update(%{experience: experience}),
    do: %{data: experience}
end
