defmodule SystoWeb.PageView do
  use SystoWeb, :view

  alias SystoWeb.PageView
  def render("event_user.json", %{event_user: event_user})do
    render_many(event_user, PageView, "event_list.json", as: :event_user)
  end

  def render("event_list.json", %{event_user: event_user})do
    event_user
  end
end
