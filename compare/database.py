import json

def load_database_features():
    try:
        with open('database_features.json', 'r') as file:
            features = json.load(file)
        return features
    except FileNotFoundError:
        print("Database file not found.")
        return {}
    except json.JSONDecodeError:
        print("Error decoding JSON from the database file.")
        return {}
