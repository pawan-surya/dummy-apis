defmodule SystoWeb.EventController do
  use SystoWeb, :controller

  import Ecto.Query
  alias Systo.Repo
  alias Systo.Schemas.Eventuser


  def get_event_list(conn, params) do
    IO.inspect(params)
    all = Eventuser
          |> where(^event_user_filter(params))
          |> select([d], %{event_id: d.event_id})
          |> order_by([d], [desc: d.id])
          |> Repo.all
    conn
    |> put_status(:ok)
    |> put_view(SystoWeb.PageView)
    |> render("event_user.json", event_user: all)
  end


  def event_user_filter(params)do
    Enum.reduce(
      params,
      dynamic(true),
      fn
        {"id", value}, dynamic -> id = String.to_integer(value)
                                  dynamic([d], ^dynamic and fragment("? @> ?", d.requested_users, ^[id]))
        {_, _}, dynamic -> dynamic
      end
    )
  end
end
