# from google.cloud import firestore
# import os

# current_directory = os.path.dirname(os.path.abspath(__file__))
# cred_path = os.path.join(current_directory, "credentials.json")

# def initialize_firestore(cred_path):
#     return firestore.Client.from_service_account_json(cred_path)

# def query_inverted_index(word):
#     db = initialize_firestore(cred_path)
#     inverted_index_ref = db.collection('inverted_index')
    
#     word_doc_ref = inverted_index_ref.document(word)
#     current_index = word_doc_ref.get().to_dict()

#     if current_index and 'tablet_ids' in current_index:
#         return current_index['tablet_ids']
#     else:
#         return []

# def get_tablet_details(tablet_ids):
#     db = initialize_firestore(cred_path)
#     tablets_ref = db.collection('tablets')

#     tablet_details = []

#     for tablet_id in tablet_ids:
#         tablet_doc = tablets_ref.document(tablet_id)
#         tablet_data = tablet_doc.get().to_dict()

#         if tablet_data:
#             tablet_details.append({
#                 'product_name': tablet_data['product_name'],
#                 'product_price': tablet_data['product_price'],
#                 'site': tablet_data['site']
#             })

#     return tablet_details

# if __name__ == "__main__":
#     # Query the inverted index for tablets containing the word 'apple'
#     target_word = 'samsung'
#     tablet_ids_with_word = query_inverted_index(target_word)

#     # Get tablet details based on the retrieved tablet IDs
#     tablet_details = get_tablet_details(tablet_ids_with_word)

#     # Print the results
#     print(f"Tablets containing the word '{target_word}':")
#     for tablet_detail in tablet_details:
#         print(f"Name: {tablet_detail['product_name']}, Price: {tablet_detail['product_price']}, Site: {tablet_detail['site']}")

from google.cloud import firestore
import os

current_directory = os.path.dirname(os.path.abspath(__file__))
cred_path = os.path.join(current_directory, "credentials.json")

def initialize_firestore(cred_path):
    return firestore.Client.from_service_account_json(cred_path)

def delete_all_documents(collection_ref):
    # Get all documents in the collection
    docs = collection_ref.stream()

    # Delete each document
    for doc in docs:
        doc.reference.delete()

def create_collections_with_initial_data(db):
    # Create 'tablets' collection
    tablets_ref = db.collection('tablets')

    # Create 'inverted_index' collection with the 'tablets_id' field
    inverted_index_ref = db.collection('inverted_index')

    # Create initial document for 'inverted_index' with a field 'tablets_id'
    inverted_index_ref.add({'tablets_id': "test"})

    # Create initial documents for 'tablets' with null values for string fields and 0 for product_price
    tablets_ref.add({
        'product_name': "test",
        'product_img': "test",
        'product_attr': "test",
        'site': "test",
        'product_price': 0,
        'link': "test",
        'screenSize': "test"
    })

if __name__ == "__main__":
    # Initialize Firestore client
    db = initialize_firestore(cred_path)

    # Reference to the "tablets" collection
    tablets_ref = db.collection('tablets')

    # Reference to the "inverted_index" collection
    inverted_index_ref = db.collection('inverted_index')

    # Delete all documents in the "tablets" collection
    delete_all_documents(tablets_ref)
    
    # Delete all documents in the "inverted_index" collection
    delete_all_documents(inverted_index_ref)

    print("All documents in the 'tablets' and 'inverted_index' collections have been deleted.")

    # Recreate collections with initial data
    create_collections_with_initial_data(db)

    print("Collections 'tablets' and 'inverted_index' have been recreated with initial data.")
