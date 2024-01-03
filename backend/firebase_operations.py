from google.cloud import firestore
import os
import re

current_directory = os.path.dirname(os.path.abspath(__file__))
cred_path= os.path.join(current_directory,"credentials.json" )

def initialize_firestore(cred_path):
    return firestore.Client.from_service_account_json(cred_path)

def sanitize_string(input_string):
    cleaned_string = ''.join(char if char.isalnum() or char in {'_', '-'} else '_' for char in input_string)
    result_string = cleaned_string + ' inç'
    return result_string


def tablet_exists(name, price, tablets_ref):
    query = tablets_ref.where('product_name', '==', name).where('product_price', '==', price).limit(1)
    result = list(query.stream())
    return len(result) > 0, result

def concatenate_gb_number(name):

    match = re.search(r'(\d+)\s*gb', name, re.IGNORECASE)
    if match:
        number = match.group(1)
 
        return name.replace(match.group(), f'{number}gb')
    return name

def add_tablet_to_firestore(tablet, site):

    db = initialize_firestore(cred_path)
    tablets_ref = db.collection('tablets')
    # prices_ref = db.collection('prices')
    inverted_index_ref = db.collection('inverted_index')

    name = tablet['Name']
    photo = tablet['Photo']
    attributes = tablet['Attribute']
    price = tablet['Price']
    link = tablet['Link']
    screenSize = tablet['ScreenSize']
    print("screennnn: ", screenSize)
    #code = tablet.get('Code')
    exists, existing_tablets = tablet_exists(name, price, tablets_ref)

    if exists:
        print(f"Tablet with the name '{name}' and price '{price}' already exists. Checking for updates...")

        # Check if the price needs to be updated
        for existing_tablet in existing_tablets:
            existing_data = existing_tablet.to_dict()

            if existing_data['product_price'] != price:
                print(f"Updating price for tablet '{name}' from '{existing_data['product_price']}' to '{price}'")
                existing_tablet.reference.update({'product_price': price})
            else:
                print(f"Tablet with the name '{name}' and price '{price}' already exists. Skipping...")
            return

    tablets_doc_ref = tablets_ref.add({
      'product_name': name,
        'product_img': photo,
        'product_attr': attributes,
        'site': site,
        'product_price': price,
        'link': link,
        'screenSize': screenSize  
        
    })
    name = tablet['Name'].lower()
    # print("ilk name: " , name)
    # name = concatenate_gb_number(name)
    # print("sonraki name: " , name)
    # tablet_id = tablets_doc_ref[1].id
    
    # prices_ref.add({
    #     'tablet_id': tablet_id,
    #     'site': site,
    #     'price': price
    # })


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

    sanitized_size = sanitize_string(screenSize)
    print("qwe:", sanitized_size)
    if sanitized_size:
        size_doc_ref = inverted_index_ref.document(sanitized_size)
        current_index = size_doc_ref.get().to_dict()
        if current_index is None:
            current_index = {'tablet_ids': []}
        current_index['tablet_ids'].append(tablets_doc_ref[1].id)
        size_doc_ref.set(current_index)
    
    site_doc_ref = inverted_index_ref.document(site)
    current_index = site_doc_ref.get().to_dict()
    if current_index is None:
        current_index = {'tablet_ids' : []}
    current_index['tablet_ids'].append(tablets_doc_ref[1].id)
    site_doc_ref.set(current_index)

    query = tablets_ref.where('product_name', '==', 'test')
    tablets = query.stream()

    for tablet in tablets:
        tablet.reference.delete()
        print(f"Tablet with product_name 'test' deleted.")
        
    query = inverted_index_ref.where('tablet_ids', 'array_contains', "test")
    indices = query.stream()   
    for index in indices:
        index.reference.delete()
        print(f"Index with tablet_id 'test' deleted.")
    