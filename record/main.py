import json
import cv2
from camera import capture_image
from face_detection import detect_face
from feature_extraction import extract_features
from keras.models import load_model
from facenet_pytorch import InceptionResnetV1

def main():
    # Step 1: Capture an image from the camera
    image = capture_image()
    if image is None:
        print("No image captured.")
        return
    
    to_save_image = cv2.imread('data/save_image/save_image.jpg')


    # Step 2: Detect face in the image
    # face = detect_face(to_save_image)
    # if face is None:
    #     print("No face detected.")
    #     return

    model = InceptionResnetV1(pretrained='vggface2').eval()
    # Step 3: Extract features from the detected face
    features = extract_features(model, 'data/save_image/save_image.jpg')
    if features is None:    
        print("Feature extraction failed.")
        return

    # Step 4: Save the features to a JSON file
    try:
        with open('database_features.json', 'w') as f:
            json.dump(features.tolist(), f)  # Assuming features is a numpy array
        print("Features saved successfully.")
    except Exception as e:
        print(f"Failed to save features: {str(e)}")

if __name__ == "__main__":
    main()
