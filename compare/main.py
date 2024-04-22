import cv2
from flask import Flask, request, jsonify
from camera import capture_image
from face_detection import detect_face
from feature_extraction import extract_features
from face_matching import match_face
from database import load_database_features
from facenet_pytorch import InceptionResnetV1
import numpy as np


app = Flask(__name__)

@app.route('/compare', methods=['POST'])
def main():
    file = request.files['image']
    npimg = np.frombuffer(file.read(), np.uint8)  # Use frombuffer instead of fromstring
    img = cv2.imdecode(npimg, cv2.IMREAD_COLOR)
    face_image = detect_face(img)
    if face_image is not None:
        model = InceptionResnetV1(pretrained='vggface2').eval()
        features = extract_features(model, img)
        database_features = load_database_features()
        match_result = match_face(features, database_features)
        if match_result == True:
            print("Access Granted")
            return jsonify({'Match': match_result})
        else:
            print("Face Error: Access Denied")
            return jsonify({'Match': match_result})
    else:
        print("No face detected")

if __name__ == "__main__":
    app.run(debug=True, host='0.0.0.0')
