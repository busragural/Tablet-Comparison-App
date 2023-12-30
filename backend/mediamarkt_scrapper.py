import requests
import pandas as pd
from bs4 import BeautifulSoup
import sys
sys.path.append( 'backend' ) 
import firebase_operations


baseUrl = "https://www.mediamarkt.com.tr/tr/category/_tabletler-639520.html"
mainPageUrl = "https://www.mediamarkt.com.tr"
header = {
    "User-Agent":"Mozilla/5.0 (Windows NT 10.0; Win64; x64)"
                 "AppleWebKit/537.36 (KHTML, like Gecko) "
                 "Chrome/119.0.0.0 Safari/537.36"
}


tablets = []
for pageNum in range(1, 2):
    httpRequest = requests.get(f"{baseUrl}?searchParams=&sort=suggested&view=&page={pageNum}", headers=header)
    parsedHtml = BeautifulSoup(httpRequest.text, "html.parser")
    tabletArr = parsedHtml.find_all("div", {"class": lambda x: x and "product-wrapper" in x.split()})
    for iterTablet in tabletArr:
         attributes_list = []
         for link in iterTablet.find_all("span", {"class": "photo clickable"}):
                
            tabletHref = link.get("data-clickable-href")
            tabletReq = requests.get(mainPageUrl + tabletHref, headers=header)
            tabletHtml = BeautifulSoup(tabletReq.text, "html.parser")

            tablet = {
                "Name": tabletHtml.find("h1", {}).text.strip(),
                "Photo": 'https:'+tabletHtml.find("img", {"class":"img-preview"}).get("src"),
                "Price" : None,
                "Attribute": [],
                "ScreenSize": None,
                "Link": mainPageUrl+tabletHref
                
            }
            price_meta_tag = tabletHtml.find("meta", {"itemprop": "price"})
            if price_meta_tag:
                tablet["Price"] = price_meta_tag.get("content")       
            sections = tabletHtml.find_all("section")
            for section in sections:
                h2 = section.find("h2")
                if h2:
                    section_title = h2.text.strip()
                    dt_dd_pairs = section.find_all(["dt", "dd"])
                    for dt, dd in zip(dt_dd_pairs[::2], dt_dd_pairs[1::2]):
                        dt_text = dt.text.strip()
                        dd_text = dd.text.strip()
                        attribute = {dt_text: dd_text}  # Create a dictionary for each attribute
                        tablet["Attribute"].append(attribute)
            
            screen_size_value = next((attr['Ekran Boyutu (inç):'].replace('inç', '').strip() for attr in tablet["Attribute"] if 'Ekran Boyutu (inç):' in attr), None)
            tablet["ScreenSize"] = screen_size_value

            print(tablet["Photo"])
            tablets.append(tablet)

for tablet in tablets:
    firebase_operations.add_tablet_to_firestore(tablet, 'MediaMarkt')
    print("bitti")
            