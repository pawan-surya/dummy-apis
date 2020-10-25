defmodule Systo.Schemas.Type do
  use Ecto.Schema
  import Ecto.Changeset
  alias  Systo.Schemas.Access
  alias  Systo.Schemas.Type

  schema "type" do
    field :category, :string

    has_one :type, Type
    belongs_to :access, Access
  end

  def changeset_with_cast(type, attrs)do
    IO.inspect(attrs)
    type
    |> cast(attrs, [:category, :access_id])
    |> validate_required(:category)
  end

  def changeset_with_put(type, attrs)do
    type
    |> cast(attrs, [:category, :access_id])
    |> validate_required(:category)
  end
end
