defmodule SystoWeb.PageController do
  use SystoWeb, :controller

  alias Systo.Repo
  alias Systo.Schemas.User

  def index(conn, _params) do
    render conn, "index.html"
  end

  def structural_data_with_cast_assoc(conn, params)do
    data = params["user"]
    address = params["user"]["address"]
    contacts = params["user"]["contacts"]
    profile = params["user"]["profile"]
    user = params["user"]["access"]
    category = params["user"]["access"]["type"]

    insert_user = %{
      "name" => data["name"],
      "profile" => %{
        "dob" => data["dob"],
        "email" => data["email"]
      },
      "profile" => profile,
      "addresses" => address,
      "contacts" => contacts,
      "access" => %{
        "username" => user["username"],
        "password" => user["password"],
        "type" => %{
          "category" => category["type"]
        }
      }
    }
    changeset = User.changeset_with_structural(%User{}, insert_user)

    case Repo.insert(changeset) do
      {:ok, data} -> json conn, "ok"
      {:error, changeset} -> text conn, "error"
    end
    #    json conn, "ok"
  end




  def structural_data_with_put_assoc(conn, params)do
    data = params["user"]
    addresses = data["addresses"]
    contacts = data["contacts"]
    user = params["user"]["access"]
    category = params["user"]["access"]["type"]
    insert_user = %{
      user: %{
        name: data["name"],
        profile: data["profile"],
        addresses: addresses,
        contacts: contacts,
      },
      access: %{
        username: user["username"],
        password: user["password"],
        type: %{
          category: category["type"]
        }
      }
    }

    changeset = User.changeset_with_put(%User{}, insert_user)
    IO.inspect(changeset)
    #    case Repo.insert(changeset) do
    #      {:ok, data} -> json conn, "ok"
    #      {:error, changeset} -> text conn, "error"
    #    end
  end






  #  def non_structural_data_with_cast_assoc(conn, params)do
  #    map = %{
  #      "name" => params["user"]["name"],
  #      "access" => %{
  #        "username" => params["access"]["username"],
  #        "password" => params["access"]["password"],
  #        "type" => %{
  #          "category" => params["type"]["type"]
  #        }
  #      }
  #    }
  #    changeset = User.changeset_with_structural(%User{}, map)
  #    case Repo.insert(changeset) do
  #      {:ok, data} -> json conn, "ok"
  #      {:error, changeset} -> text conn, "error"
  #    end
  #  end
  #
  #  def non_structural_data_with_put_assoc(conn, params)do
  #    map = %{
  #      name: params["user"]["name"],
  #      access: %{
  #        username: params["access"]["username"],
  #        password: params["access"]["password"],
  #
  #        type: %{
  #          category: params["type"]["type"]
  #        }
  #      }
  #    }
  #    changeset = User.changeset_with_put(%User{}, map)
  #    case Repo.insert(changeset) do
  #      {:ok, data} -> json conn, "ok"
  #      {:error, changeset} -> text conn, "error"
  #    end
  #  end
end
