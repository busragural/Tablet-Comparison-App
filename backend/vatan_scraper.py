import requests
import pandas as pd
from bs4 import BeautifulSoup
import firebase_operations

baseUrl = "https://www.vatanbilgisayar.com/tabletler/"
header = {
    "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
                 "AppleWebKit/537.36 (KHTML, like Gecko) "
                 "Chrome/119.0.0.0 Safari/537.36"
}

tablets = []
inverted_index = {}

for pageNum in range(1, 2):
    httpRequest = requests.get(f"{baseUrl}/?page={pageNum}", headers=header)
    parsedHtml = BeautifulSoup(httpRequest.text, "html.parser")
    tabletArr = parsedHtml.find_all("div", {"class": "product-list product-list--list-page"})

    for index, iterTablet in enumerate(tabletArr):
        for link in iterTablet.find_all("a", {"class": "product-list__image-safe-link sld"}):
            tabletReq = requests.get(baseUrl + link["href"], headers=header)
            tabletHtml = BeautifulSoup(tabletReq.text, "html.parser")

            attribute_tables = tabletHtml.find_all("div", {"class": "row masonry-tab"})
            for attribute_table in attribute_tables:
                rows = attribute_table.find_all("tr")
                tabletAttributes = {}
                for row in rows:
                    columns = row.find_all("td")
                    key = columns[0].text.strip()
                    value = columns[1].find("p").text.strip()  
                    tabletAttributes[key] = value
            screen_size_value = tabletAttributes.get('Ekran Boyutu', '')
            screen_size_value = screen_size_value.replace('inch', '').strip()

            price_text = tabletHtml.find("span", {"class": "product-list__price"}).text.strip()
            price_value = price_text.replace('.', '').strip()

            tablet = {
                "Name": tabletHtml.find("h1", {"class": "product-list__product-name"}).text.strip(),
                #"Code" : tabletHtml.find("div", {"class" : "product-list__product-code pull-left product-id"}).text.split("/")[0].strip(),
                "Price": price_value,
                "Photo" : tabletHtml.find("a",  {"data-fancybox": "images"}).get("href", {}),
                "Attribute" : tabletAttributes,
                "ScreenSize": screen_size_value,
                "Link" : baseUrl + link["href"]
            }

            print(tablet["Price"] )
            tablets.append(tablet)
     
for tablet in tablets:
    firebase_operations.add_tablet_to_firestore(tablet, 'Vatan')
    print("bitti")
