from flask import Flask, request, jsonify
import numpy as np
import cv2
import os

# app = Flask(__name__)

# @app.route('/image', methods=['POST'])
def receive_image():
    if request.method == 'POST':
        # 从POST请求中获取图像数据
        image_data = request.data
        # 将二进制数据转换为numpy数组
        nparr = np.frombuffer(image_data, np.uint8)
        # 从numpy数组解码出图像
        img = cv2.imdecode(nparr, cv2.IMREAD_COLOR)

        # 确保目录存在
        save_path = os.path.join('data', 'save_image')
        os.makedirs(save_path, exist_ok=True)

        # 保存图像到指定路径
        save_image_path = os.path.join(save_path, 'save_image.jpg')
        cv2.imwrite(save_image_path, img)

        # 返回成功消息
        return jsonify({'message': 'Image received and saved successfully'})

# if __name__ == '__main__':
#     app.run(host='0.0.0.0', port=5000)
