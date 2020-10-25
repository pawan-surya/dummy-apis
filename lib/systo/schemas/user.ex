defmodule Systo.Schemas.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Systo.Schemas.Access
  alias Systo.Embed.Profile
  alias Systo.Embed.Addresses
  alias Systo.Embed.Contacts

  schema "user" do
    embeds_one :profile, Profile, on_replace: :delete
    embeds_many :addresses, Addresses, on_replace: :delete
    embeds_many :contacts, Contacts, on_replace: :delete
    field :name, :string

    has_one :access, Access
  end

  def changeset_with_structural(user, attrs)do
    user
    |> cast(attrs, [:name])
    |> validate_required(:name)
    |> cast_assoc(:access, with: &Access.changeset_with_cast/2)
    |> cast_embed(:profile, with: &Profile.changeset/2)
    |> cast_embed(:addresses, with: &Addresses.changeset/2)
    |> cast_embed(:contacts, with: &Contacts.changeset/2)
  end

  def changeset_with_put(user, attrs)do
    IO.inspect attrs.user.contacts
    user
    |> cast(attrs.user, [:name])
    |> validate_required(:name)
    |> put_assoc(:access, Access.changeset_with_put(%Access{}, attrs.access))
    |> put_embed(:profile, Profile.changeset(%Profile{}, attrs.user.profile))
    |> put_embed(:addresses, [Addresses.changeset(%Addresses{}, attrs.user.addresses)])
    |> put_embed(:contacts, [Contacts.changeset(%Contacts{}, attrs.user.contacts)])
  end

end
