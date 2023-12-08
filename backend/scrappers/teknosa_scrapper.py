import requests
import pandas as pd
from bs4 import BeautifulSoup
import sys
sys.path.append( 'backend' ) 
import firebase_operations

baseUrl = "https://www.teknosa.com/tablet-c-116012"
header = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/119.0.0.0 Safari/537.36"
}


tablets = []
for pageNum in range(0, 10):
    httpRequest = requests.get(f"{baseUrl}/?page={pageNum}", headers=header)
    parsedHtml = BeautifulSoup(httpRequest.text, "html.parser")
    tabletArr = parsedHtml.find_all("div", {"id": "product-item"})
  
    for iterTablet in tabletArr:
        attributes_list = []
        for link in iterTablet.find_all("a", {"class": "prd-link"}):
            tabletHref = link.get("href")
            tabletReq = requests.get(baseUrl + tabletHref, headers=header)
            tabletHtml = BeautifulSoup(tabletReq.text, "html.parser")
            
            attribute_tables = tabletHtml.find("div", {"id" : "pdp-technical"})
            if attribute_tables:
                tables = attribute_tables.find_all("table")
                for table in tables:
                    headers = [th.text.strip() for th in table.find("tr").find_all("th")]
                    rows = table.find_all("tr")[1:]
                    for row in rows:
                        values = [td.text.strip() for td in row.find_all("td")]
                        attributes = dict(zip(headers, values))
                        attributes_list.append(attributes)

            tablet = {
                "Name" : tabletHtml.find("h1", {"class": "pdp-title"}).get_text(strip=True),
                "Price" : tabletHtml.find("span", {"class": "prc prc-last"}).text.strip(),
                "Photo" : tabletHtml.find("div", {"class": "swiper-slide responsive-image-swiper-slide"})["data-zoom"],
                "Attributes" : attributes_list
            }
            tablets.append(tablet)

for tablet in tablets:
    firebase_operations.add_tablet_to_firestore(tablet, 'T')
    print("bitti")


            
            