defmodule SeoAuditWeb.Router do
  use SeoAuditWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SeoAuditWeb do
    pipe_through :api
  end
end
