defmodule Systo.Embed.Contacts do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "contacts" do
    field :id, :integer
    field :type, :string
    field :is_primary, :string
    field :info, :string
    field :isdcode, :string
    field :landline, :string

  end

  @doc """
    Changeset for add contacts.
  """
  def changeset(contact, attrs) do
    contact
    |> cast(attrs, [:id, :type, :is_primary, :isdcode, :info, :landline])
    |> validate_required([:id, :type, :is_primary, :isdcode])
  end
end
