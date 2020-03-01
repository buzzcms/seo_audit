%{body: body} = HTTPoison.get!("https://connected.com.vn/quang-cao-va-seo/")
SeoAudit.parse_html(body) |> IO.inspect()
