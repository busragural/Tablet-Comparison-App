from google.cloud import firestore
import os

current_directory = os.path.dirname(os.path.abspath(__file__))
cred_path= os.path.join(current_directory,"credentials.json" )

def initialize_firestore(cred_path):
    return firestore.Client.from_service_account_json(cred_path)


def is_tablet_exists(tablet_name, tablets_ref):
    for document in tablets_ref.stream():
        data = document.to_dict()  # Firestore belgesinin verilerini al
        code = data.get('product_code')  # 'code' yerine 'product_code' kullan
        if code and code in tablet_name:
            print("code", code)
            print("doc_id değeri: ",document.id)
            return document.id  #true değil kodu döndür
    return None


def add_tablet_to_firestore(tablet, site):

    db = initialize_firestore(cred_path)
    tablets_ref = db.collection('tablets')
    prices_ref = db.collection('prices')

    name = tablet['Name']
    photo = tablet['Photo']
    attributes = tablet['Attribute']
    price = tablet['Price']
    code = tablet.get('Code')

    isExist = is_tablet_exists(name, tablets_ref)
    if isExist:
        # Belirli bir ürün adına sahip tablet zaten varsa yeni bir fiyat ekleyin
        #existing_tablet = tablets_ref.where('product_name', '==', name).limit(1).stream().next() #yanlis
        #existing_tablet_id = existing_tablet.id
        print("daha oncekini buldu, ref tablosuna ekleyecek")
        prices_ref.add({
            'tablet_id': isExist,
            'site': site,
            'price': price
        })
    
        return 

    tablets_doc_ref = tablets_ref.add({
        'product_name': name,
        'product_img': photo,
        'product_attr': attributes,
        'product_code': code if code else None
    })
    
    tablet_id = tablets_doc_ref[1].id
    
    prices_ref.add({
        'tablet_id': tablet_id,
        'site': site,
        'price': price
    })