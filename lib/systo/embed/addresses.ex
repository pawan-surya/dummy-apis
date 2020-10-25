defmodule Systo.Embed.Addresses do
  use Ecto.Schema
  import Ecto.Changeset


  @primary_key false
  schema "addresses" do
    field :id, :integer
    field :address1, :string
    field :address2, :string
    field :address3, :string
    field :town, :string
    field :city, :string
    field :state, :string
    field :country, :string
    field :zipcode, :string
    field :type, :string

  end

  @doc """
    Changeset to add validations.
  """
  def changeset(address, attrs) do
    IO.inspect(attrs)
    address
    |> cast(attrs, [:id, :address1, :address2, :address3, :town, :city, :state, :country, :zipcode, :type])
    |> validate_required([:id, :address1, :city, :state, :zipcode, :type, :country])
  end
end
