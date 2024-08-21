defmodule CvmeWeb.ExperiencesJSON do
  def create(%{experience: experience}),
    do: %{data: experience}

  def get(%{experience: experience}), do: %{data: experience}

  def delete(%{experience: experience}),
    do: %{data: experience}

  def update(%{experience: experience}),
    do: %{data: experience}
end
