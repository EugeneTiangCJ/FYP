import cv2
from face_detection import detect_face

# Load the image
image = cv2.imread('data/save_image/save_image.jpg')

# Perform face detection
result_image, faces = detect_face(image)

# Display the result
cv2.imshow('Face Detection Result', result_image)
cv2.waitKey(0)
cv2.destroyAllWindows()
