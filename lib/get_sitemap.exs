import SweetXml
%{body: body} = HTTPoison.get!("https://connected.com.vn/sitemap.xml")
body |> xpath(~x"//url/loc/text()"l) |> IO.inspect()
