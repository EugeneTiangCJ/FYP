import json
from flask import Flask, request, jsonify
import cv2
from camera import capture_image
from face_detection import detect_face
from feature_extraction import extract_features
from keras.models import load_model
from facenet_pytorch import InceptionResnetV1

from front_camera import receive_image

app = Flask(__name__)

@app.route('/capture', methods=['POST'])
def main():
    # Step 1: Capture an image from the camera
    receive_image()
    
    to_save_image = cv2.imread('data/save_image/save_image.jpg')


    # Step 2: Detect face in the image
    face = detect_face(to_save_image)
    if face is None:
        return jsonify({'error': 'No faces detected'}), 404

    model = InceptionResnetV1(pretrained='vggface2').eval()
    # Step 3: Extract features from the detected face
    features = extract_features(model, 'data/save_image/save_image.jpg')
    try:
        with open('database_features.json', 'w') as f:
            json.dump(features.tolist(), f)  # Assuming features is a numpy array
        print("Features saved successfully.")
    except Exception as e:
        print(f"Failed to save features: {str(e)}")

    return jsonify({'message': 'Image processed', 'faces': len(face), 'features': features.tolist()}), 200


if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')
