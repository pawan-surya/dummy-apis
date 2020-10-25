defmodule Systo.Schemas.Access do
  use Ecto.Schema
  import Ecto.Changeset

  alias Systo.Schemas.User
  alias Systo.Schemas.Type

  schema "access" do
    field :username, :string
    field :password, :string

    has_one :type, Type
    belongs_to :user, User
  end

  def changeset_with_cast(access, attrs)do
    IO.inspect(attrs)
    access
    |> cast(attrs, [:username, :password, :user_id])
    |> validate_required([:username, :password])
    |> cast_assoc(:type, with: &Type.changeset_with_cast/2)
  end

  def changeset_with_put(access, attrs)do
    access
    |> cast(attrs, [:username, :password, :user_id])
    |> validate_required([:username, :password])
    |> put_assoc(:type, Type.changeset_with_put(%Type{}, attrs.type))
  end
end
