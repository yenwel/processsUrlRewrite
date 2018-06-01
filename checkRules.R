require(xml2)
require(RCurl)

data <- read_xml('rules.xml')

xml_path(xml_find_all(data,"//rule/@name"))

rules <- xml_find_all(data,"//rule")
df <- data.frame(
  name = unlist(as_list(xml_find_all(data,"//rule/@name"))),
  from_match =  unlist(as_list(xml_find_all(rules,"//match/@url"))),
  to_url = unlist(as_list(xml_find_all(rules,"//action/@url"))),
  type =  unlist(as_list(xml_find_all(rules,"//action/@type")))
)

urlexists <- list()
for(url in df$to_url)
{
  print(url)
  urlexists <- rbind(urlexists,list(url.exists(url)))
}
urlexists <- unlist(urlexists)

df <- cbind(df, urlexists)


write.csv(df, "rules.csv")
