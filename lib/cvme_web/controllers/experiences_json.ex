defmodule CvmeWeb.ExperiencesJSON do
  def create(%{experience: experience}), do: %{message: "Experience created with success.", data: experience}
  def get(%{experience: experience}), do: %{data: experience}
  def delete(%{experience: experience}), do: %{message: "Experience deleted with success.", data: experience}
  def update(%{experience: experience}), do: %{message: "Experience updated with success.", data: experience}
end
