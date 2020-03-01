defmodule SeoAudit.Repo do
  use Ecto.Repo,
    otp_app: :seo_audit,
    adapter: Ecto.Adapters.Postgres
end
