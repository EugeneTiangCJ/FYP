import torch
from PIL import Image
from torchvision import transforms
from facenet_pytorch import InceptionResnetV1

def preprocess_image(image_path):
    # Load image and convert it to RGB
    image = Image.fromarray(image_path).convert('RGB')
    
    # Define transformations
    transform = transforms.Compose([
        transforms.Resize((160, 160)),  # Resize the image to 160x160 pixels
        transforms.ToTensor(),  # Convert the image to a PyTorch tensor
        transforms.Normalize(mean=[0.5, 0.5, 0.5], std=[0.5, 0.5, 0.5])  # Normalize the tensor
    ])
    
    # Apply transformations
    processed_image = transform(image).unsqueeze(0)  # Add batch dimension
    return processed_image

def extract_features(model, image):
    # Preprocess the image
    processed_image = preprocess_image(image)
    
    # Use no_grad to prevent tracking history in autograd
    with torch.no_grad():
        # Model inference to get embeddings
        features = model(processed_image)
    return features

# # Example usage:
# # Assuming you have an image at 'path/to/your/image.jpg'
# features = extract_features(InceptionResnetV1(pretrained='vggface2').eval(), 'data/save_image/save_image.jpg')
# print(features)
