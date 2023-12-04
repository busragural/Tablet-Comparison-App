import requests
import pandas as pd
from bs4 import BeautifulSoup

baseUrl = "https://www.vatanbilgisayar.com/tabletler/"
header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) "
                  "AppleWebKit/537.36 (KHTML, like Gecko) "
                  "Chrome/118.0.0.0 Safari/537.36"
}

tablets = []
for pageNum in range(1, 7):
    httpRequest = requests.get(f"https://www.vatanbilgisayar.com/tabletler/?page={pageNum}", headers=header)
    parsedHtml = BeautifulSoup(httpRequest.text, "html.parser")
    tabletArr = parsedHtml.find_all("div", {"class": "product-list product-list--list-page"})

    for iterTablet in tabletArr:
        for link in iterTablet.find_all("a", {"class": "product-list__image-safe-link sld"}):
            tabletReq = requests.get(baseUrl + link["href"], headers=header)
            tabletHtml = BeautifulSoup(tabletReq.text, "html.parser")
            tablet = {
                "Name": tabletHtml.find("h1", {"class": "product-list__product-name"}).text.strip(),
                "Price": tabletHtml.find("span", {"class": "product-list__price"}).text.strip()
            }
            print("Saving: ", tablet["Name"])
            tablets.append(tablet)

df = pd.DataFrame(tablets)
print(df.head(15))
