%{body: body} = HTTPoison.get!("https://connected.com.vn/")
SeoAudit.parse_html(body) |> IO.inspect()
