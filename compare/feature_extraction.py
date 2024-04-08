from keras.models import load_model
import numpy as np

# Assuming model is loaded: model = load_model('facenet_keras.h5')

def extract_features(model, face_image):
    face_image = face_image.astype('float32')
    mean, std = face_image.mean(), face_image.std()
    face_image = (face_image - mean) / std
    samples = np.expand_dims(face_image, axis=0)
    features = model.predict(samples)
    return features