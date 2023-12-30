import requests
import pandas as pd
from bs4 import BeautifulSoup
import sys
sys.path.append( 'backend' ) 
import firebase_operations


baseUrl = "https://www.teknosa.com/tablet-c-116012"
header = {
    "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
                 "AppleWebKit/537.36 (KHTML, like Gecko) "
                 "Chrome/119.0.0.0 Safari/537.36"
}


tablets = []
for pageNum in range(0, 1):
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
            
            screen_size_value = next((attr.get('Ekran Boyutu') for attr in attributes_list if 'Ekran Boyutu' in attr), None)
            if screen_size_value:
                screen_size_value = screen_size_value.replace('inç', '').strip()


            name_element = tabletHtml.find("h1", {"class": "pdp-title"})
            a_tag = name_element.find("a")
            a_text = a_tag.text.strip() if a_tag else ""
            outside_a_text = " ".join([text.strip() for text in name_element.contents if isinstance(text, str)])
            tablet_name = f"{a_text} {outside_a_text}"

            price_text = tabletHtml.find("span", {"class": "prc prc-last"}).text.strip()
            price_value = price_text.replace('TL', '').replace('.', '').strip()

            tablet = {
                "Name": tablet_name,
                "Price" : price_value,
                "Photo" : tabletHtml.find("div", {"class": "swiper-slide responsive-image-swiper-slide"})["data-zoom"],
                "ScreenSize": screen_size_value,
                "Attribute" : attributes_list,
                "Link" : baseUrl + tabletHref
            }
            print(tablet["Price"])
            tablets.append(tablet)

for tablet in tablets:
    firebase_operations.add_tablet_to_firestore(tablet, 'Teknosa')
    print("bitti")


            
            