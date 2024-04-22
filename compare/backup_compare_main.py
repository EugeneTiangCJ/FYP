import cv2

from camera import capture_image
from face_detection import detect_face
from feature_extraction import extract_features
from face_matching import match_face
from keras.models import load_model
from database import load_database_features
from facenet_pytorch import InceptionResnetV1

def main():
    image = capture_image()
    to_read_image = cv2.imread('data/input_image/input_image.jpg')
    face_image = detect_face(to_read_image)
    if face_image is not None:
        model = InceptionResnetV1(pretrained='vggface2').eval()
        features = extract_features(model, 'data/input_image/input_image.jpg')
        database_features = load_database_features()
        if match_face(features, database_features):
            print("Access Granted")
        else:
            print("Face Error: Access Denied")
    else:
        print("No face detected")

if __name__ == "__main__":
    main()