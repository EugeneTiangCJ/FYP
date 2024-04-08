import cv2
import os

def capture_image():
    # Initialize the camera
    cap = cv2.VideoCapture(0)  # '0' is typically the default value for the front camera.

    if not cap.isOpened():
        raise IOError("Cannot open webcam")

    try:
        # Capture one frame
        ret, frame = cap.read()
        if not ret:
            print("Failed to grab frame")
            return None
        

        cv2.imwrite(os.path.join('data', 'input_image', 'input_image.jpg'), frame)


        return frame
    finally:
        # Release the camera
        cap.release()

def show_image(image):
    # Display the image
    cv2.imshow('Capture', image)
    cv2.waitKey(0)  # Wait for a key press to close the window
    cv2.destroyAllWindows()

if __name__ == "__main__":
    # Capture an image when this script is run directly
    img = capture_image()
    if img is not None:
        show_image(img)
    else:
        print("No image captured.")
