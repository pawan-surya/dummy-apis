defmodule Systo.Embed.Profile do
  @moduledoc false
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "profile" do
    field :dob, :string
    field :email, :string

  end

  def changeset(profile, attrs)do
    profile
    |> cast(attrs, [:dob, :email])
    |> validate_required([:dob, :email])
  end
end
