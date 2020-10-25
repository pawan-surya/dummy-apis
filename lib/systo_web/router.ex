defmodule SystoWeb.Router do
  use SystoWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SystoWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end


  scope "/", SystoWeb do
    pipe_through :api # Use the default browser stack

    post "/add_user/cast_structural", PageController, :structural_data_with_cast_assoc
    post "/add_user/put_structural", PageController, :structural_data_with_put_assoc
    post "/add_user/case_non_structural", PageController, :non_structural_data_with_cast_assoc
    post "/add_user/put_non_structural", PageController, :non_structural_data_with_put_assoc

    get  "event_user/list/:id", EventController, :get_event_list
  end

  # Other scopes may use custom stacks.
  # scope "/api", SystoWeb do
  #   pipe_through :api
  # end
end
