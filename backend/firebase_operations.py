from google.cloud import firestore
import os

current_directory = os.path.dirname(os.path.abspath(__file__))
cred_path= os.path.join(current_directory,"credentials.json" )

def initialize_firestore(cred_path):
    return firestore.Client.from_service_account_json(cred_path)


def add_tablet_to_firestore(tablet, site):

    db = initialize_firestore(cred_path)
    tablets_ref = db.collection('tablets')
    # prices_ref = db.collection('prices')
    inverted_index_ref = db.collection('inverted_index')

    name = tablet['Name']
    photo = tablet['Photo']
    attributes = tablet['Attribute']
    price = tablet['Price']
    code = tablet.get('Code')


    tablets_doc_ref = tablets_ref.add({
        'product_name': name,
        'product_img': photo,
        'product_attr': attributes,
        'site': site,
        'product_price': price
        
    })
    name = tablet['Name'].lower()
    # tablet_id = tablets_doc_ref[1].id
    
    # prices_ref.add({
    #     'tablet_id': tablet_id,
    #     'site': site,
    #     'price': price
    # })

    # Update the inverted index
    for word in name.split():
        word = word.replace('/', '').replace('-', '')
        print ("ayrisan kelime: ", word)
        if word:
            word_doc_ref = inverted_index_ref.document(word)
            current_index = word_doc_ref.get().to_dict()
            print("test: ", current_index)
            if current_index is None:
                current_index = {'tablet_ids': []}

            current_index['tablet_ids'].append(tablets_doc_ref[1].id)

            word_doc_ref.set(current_index)
    