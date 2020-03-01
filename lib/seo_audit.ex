defmodule SeoAudit do
  def parse_html(html) do
    {:ok, doc} = html |> Floki.parse_document()

    %{
      head: parse_head(doc),
      og: parse_og(doc),
      twitter: parse_twitter(doc),
      links: doc |> Floki.find("a[href]") |> Floki.attribute("href") |> Enum.uniq(),
      h1: doc |> Floki.find("h1") |> Enum.map(&Floki.text/1) |> Enum.filter(&(&1 != "")),
      h2: doc |> Floki.find("h2") |> Enum.map(&Floki.text/1) |> Enum.filter(&(&1 != "")),
      h3: doc |> Floki.find("h3") |> Enum.map(&Floki.text/1) |> Enum.filter(&(&1 != "")),
      images:
        doc
        |> Floki.find("img[src]")
        |> Enum.map(fn node ->
          %{
            src: get_first_attr(node, "img", "src"),
            alt: get_first_attr(node, "img", "alt")
          }
        end)
    }
  end

  def parse_head(doc) do
    %{
      title: doc |> Floki.find("head > title") |> Floki.text(),
      canonical: doc |> get_first_attr("head > link[rel=canonical]", "href"),
      description: doc |> get_first_attr("head > meta[name=description]", "content"),
      keywords: doc |> get_first_attr("head > meta[name=keywords]", "content"),
      lang: doc |> get_first_attr("html", "lang"),
      favvicon: doc |> get_first_attr("head > [rel='shortcut icon']", "href"),
      viewport: doc |> get_first_attr("head > [name='viewport']", "content")
    }
  end

  def parse_twitter(doc) do
    %{
      card: doc |> get_first_attr("head > meta[name='twitter:card']", "content"),
      title: doc |> get_first_attr("head > meta[name='twitter:title']", "content"),
      description: doc |> get_first_attr("head > meta[name='twitter:description']", "content"),
      image: doc |> get_first_attr("head > meta[name='twitter:image']", "content")
    }
  end

  def parse_og(doc) do
    %{
      type: doc |> get_first_attr("head > meta[property='og:type']", "content"),
      title: doc |> get_first_attr("head > meta[property='og:title']", "content"),
      description: doc |> get_first_attr("head > meta[property='og:description']", "content"),
      url: doc |> get_first_attr("head > meta[property='og:url']", "content"),
      image: doc |> get_first_attr("head > meta[property='og:image']", "content"),
      site_name: doc |> get_first_attr("head > meta[property='og:site_name']", "content")
    }
  end

  defp get_first_attr(doc, selector, attr) do
    doc |> Floki.find(selector) |> Floki.attribute(attr) |> List.first()
  end
end
