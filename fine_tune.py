import os
import torch
import torchvision.models as models
import torch.nn as nn
import torch.optim as optim
from torchvision import transforms
from torch.utils.data import DataLoader, Dataset
from PIL import Image
from torchvision.models import vgg16_bn, VGG16_BN_Weights

# Define your custom dataset
class CustomDataset(Dataset):
    def __init__(self, data_dir, targets, transform=None):
        self.data_dir = data_dir
        self.transform = transform
        self.images = [os.path.join(data_dir, f) for f in os.listdir(data_dir) if f.endswith('.jpg')]
        if len(self.images) != len(targets):
            raise ValueError("The number of targets does not match the number of images")
        self.targets = targets

    def __len__(self):
        return len(self.images)

    def __getitem__(self, idx):
        image_path = self.images[idx]
        image = Image.open(image_path).convert('RGB')
        target = self.targets[idx]

        if self.transform:
            image = self.transform(image)

        return image, target

# Load the pretrained VGG16 model with batch normalization
vgg_face2 = vgg16_bn(weights=VGG16_BN_Weights.IMAGENET1K_V1)

# Replace the last layer with a new layer that matches the number of classes in your dataset
num_classes = 10
vgg_face2.classifier = nn.Sequential(
    nn.Linear(25088, 4096),  # Adjusted for the correct input feature size
    nn.ReLU(True),
    nn.Dropout(),
    nn.Linear(4096, num_classes)
)

# Freeze the weights of the pretrained layers (optional)
for param in vgg_face2.features.parameters():
    param.requires_grad = False

# Define your custom dataset and data loader
transform = transforms.Compose([
    transforms.Resize((224, 224)),
    transforms.ToTensor(),
    transforms.Normalize(mean=[0.485, 0.456, 0.406], std=[0.229, 0.224, 0.225])
])

data_dir = 'C:\\FYPApp\\Datasets'
# Example targets assuming two classes for several images (adjust as needed)
targets = [0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0]
dataset = CustomDataset(data_dir, targets, transform=transform)

# Create the DataLoader
dataloader = DataLoader(dataset, batch_size=32, shuffle=True)

# Define the loss function and optimizer
criterion = nn.CrossEntropyLoss()
optimizer = optim.SGD(vgg_face2.classifier.parameters(), lr=0.001, momentum=0.9)

# Train the model
vgg_face2.train()
num_epochs = 20
for epoch in range(num_epochs):
    running_loss = 0.0
    for images, labels in dataloader:
        optimizer.zero_grad()
        
        outputs = vgg_face2(images)
        loss = criterion(outputs, labels)
        loss.backward()
        optimizer.step()
        
        running_loss += loss.item()
    
    print(f"Epoch {epoch+1} loss: {running_loss / len(dataloader)}")

model_path = 'C:\\FYPApp\\Models\\secondmodel.pth'  # Specify the path where you want to save the model
torch.save(vgg_face2.state_dict(), model_path)

# Evaluate the performance of the fine-tuned model
vgg_face2.eval()
with torch.no_grad():
    correct = 0
    total = 0
    for images, labels in dataloader:
        outputs = vgg_face2(images)
        _, predicted = torch.max(outputs.data, 1)
        total += labels.size(0)
        correct += (predicted == labels).sum().item()
    
    accuracy = 100 * correct / total
    print(f"Accuracy: {accuracy}%")
    print(f"Number of images: {len(dataset.images)}")
    print(f"Number of targets: {len(targets)}")
