from google.cloud import firestore
import os

current_directory = os.path.dirname(os.path.abspath(__file__))
cred_path = os.path.join(current_directory, "credentials.json")

def initialize_firestore(cred_path):
    return firestore.Client.from_service_account_json(cred_path)

def query_inverted_index(word):
    db = initialize_firestore(cred_path)
    inverted_index_ref = db.collection('inverted_index')
    
    word_doc_ref = inverted_index_ref.document(word)
    current_index = word_doc_ref.get().to_dict()

    if current_index and 'tablet_ids' in current_index:
        return current_index['tablet_ids']
    else:
        return []

def get_tablet_details(tablet_ids):
    db = initialize_firestore(cred_path)
    tablets_ref = db.collection('tablets')

    tablet_details = []

    for tablet_id in tablet_ids:
        tablet_doc = tablets_ref.document(tablet_id)
        tablet_data = tablet_doc.get().to_dict()

        if tablet_data:
            tablet_details.append({
                'product_name': tablet_data['product_name'],
                'product_price': tablet_data['product_price'],
                'site': tablet_data['site']
            })

    return tablet_details

if __name__ == "__main__":
    # Query the inverted index for tablets containing the word 'apple'
    target_word = 'samsung'
    tablet_ids_with_word = query_inverted_index(target_word)

    # Get tablet details based on the retrieved tablet IDs
    tablet_details = get_tablet_details(tablet_ids_with_word)

    # Print the results
    print(f"Tablets containing the word '{target_word}':")
    for tablet_detail in tablet_details:
        print(f"Name: {tablet_detail['product_name']}, Price: {tablet_detail['product_price']}, Site: {tablet_detail['site']}")