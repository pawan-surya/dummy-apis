defmodule Systo.Schemas.Eventuser do
  use Ecto.Schema
  import Ecto.Changeset

  schema "event_user" do
    field :event_id, :integer
    field :requested_users, {:array, :integer}
    field :cancelled_users, {:array, :integer}
    field :confirmed_users, {:array, :integer}

    timestamps()
  end

  def changeset_with_cast(type, attrs)do
    type
    |> cast(attrs, [:event_id, :requested_users])
  end

end
