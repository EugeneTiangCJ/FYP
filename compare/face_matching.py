from sklearn.metrics.pairwise import cosine_similarity

def match_face(input_features, database_features):
    scores = cosine_similarity(input_features, database_features)
    if max(scores) > 0.8:  # Define a threshold
        return True  # Face matched
    else:
        return False