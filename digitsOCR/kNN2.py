import cv2
import numpy as np


# 定义更新knn的方法，有新的数据样本就添加，没有就训练opencv默认的数据
def updateKnn(knn, train, train_labels, newData=None, newDataLabel=None):
    if newData != None and newDataLabel != None:
        print(train.shape, newData.shape)
        newData = newData.reshape(-1, 400).astype(np.float32)
        train = np.vstack((train, newData))
        train_labels = np.hstack((train_labels, newDataLabel))
    knn.train(train, cv2.ml.ROW_SAMPLE, train_labels)
    return knn, train, train_labels


# 读取图片转为灰度图
img = cv2.imread('digits.png')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
# 把图片分隔成5000个，每个20x20大小
cells = [np.hsplit(row, 100) for row in np.vsplit(gray, 50)]
train = np.array(cells).reshape(-1, 400).astype(np.float32)
k = np.arange(10)
train_labels = np.repeat(k, 500)
# 创建一个K-Nearest Neighbour分类器，训练数据
knn = cv2.ml.KNearest_create()
knn, train, trainLabel = updateKnn(knn, train, train_labels)
# 开启摄像头，usb摄像头用1
cap = cv2.VideoCapture(0)
count = 0

while True:
    # 读取每一帧画面
    ret, frame = cap.read()
    rois = []
    # 转为灰度图
    gray = cv2.cvtColor(frame, cv2.COLOR_BGR2GRAY)
    # 定义一个3x3大小，正方形的核
    element = cv2.getStructuringElement(cv2.MORPH_RECT, (3, 3))
    # 进行形态学膨胀和腐蚀，然后通过cv2.adsdiff(A, B)两幅图像作差，找到边
    gray2 = cv2.dilate(gray, element)
    gray2 = cv2.erode(gray2, element)
    edges = cv2.absdiff(gray, gray2)
    # 运用Sobels算子去噪点
    x = cv2.Sobel(edges, cv2.CV_16S, 1, 0)
    y = cv2.Sobel(edges, cv2.CV_16S, 0, 1)
    # convertScaleAbs()函数将其转回原来的uint8形式，否则将无法显示图像
    absX = cv2.convertScaleAbs(x)
    absY = cv2.convertScaleAbs(y)
    # Sobel算子是在两个方向计算的，最后还需要用cv2.addWeighted(...)函数将其组合起来
    dst = cv2.addWeighted(absX, 0.5, absY, 0.5, 0)
    # 设置一个阈值来对图像进行分类
    ret_1, ddst = cv2.threshold(dst, 50, 255, cv2.THRESH_BINARY)
    # 找图片的轮廓
    im, contours, hierarchy = cv2.findContours(ddst, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    # 把宽度大于10，高度大于20的轮廓用矩形画出
    for c in contours:
        x, y, w, h = cv2.boundingRect(c)
        if w > 10 and h > 20:
            rois.append((x, y, w, h))
    # 找到ROI，把每个找到的图通过阈值分类再设置成20x20大小，再设置成一维数组400个灰度值代表这个数字的特征
    digits = []
    for r in rois:
        x, y, w, h = r
        ret_roi, th = cv2.threshold(edges[y:y + h, x:x + w], 50, 255, cv2.THRESH_BINARY)
        th = cv2.resize(th, (20, 20))
        out = th.reshape(-1, 400).astype(np.float32)
        # 根据knn算法，找到这个数字特征和训练样本的特征进行分类，识别出是哪个数字
        ret_n, result, neighbours, dist = knn.findNearest(out, k=5)
        digit = int(result[0][0])
        digits.append(cv2.resize(th, (20, 20)))
        # 用矩形画出这个识别数字再写出这个识别数字
        cv2.rectangle(frame, (x, y), (x + w, y + h), (0, 255, 0), 2)
        cv2.putText(frame, str(digit), (x, y), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 0, 0), 2)

    newEdges = cv2.cvtColor(edges, cv2.COLOR_GRAY2BGR)
    newFrame = np.hstack((frame, newEdges))
    cv2.imshow('frame', newFrame)
    key = cv2.waitKey(1) & 0xff
    # 按空格退出程序
    if key == ord(' '):
        break
    # 按s保存当前的数据
    elif key == ord('s'):
        np.savez('data.npz', train=train, train_labels=train_labels)
        print('保存数据成功')
    # 按u更新新的数据样本进行训练
    elif key == ord('u'):
        Nd = len(digits)
        output = np.zeros(20 * 20 * Nd).reshape(-1, 20)
        for i in range(Nd):
            output[20 * i:20 * (i + 1), :] = digits[i]
        showDigits = cv2.resize(output, (60, 60 * Nd))
        cv2.imshow('digits', showDigits)
        cv2.imwrite(str(count) + '.png', showDigits)
        count += 1
        if cv2.waitKey(0) & 0xff == ord('e'):
            pass
        print('输入数字，用空格分隔')
        numbers = input().split(' ')
        Nn = len(numbers)
        if Nd != Nn:
            print('更新失败')
            continue
        try:
            for i in range(Nn):
                numbers[i] = int(numbers[i])
        except:
            continue
        knn, train, train_labels = updateKnn(knn, train, train_labels, output, numbers)
        print('更新成功')
        print('当前训练的图片', len(train))
        print('当前训练的图片标签', len(train_labels))

print('训练的图片', len(train))
print('训练的图片标签', len(train_labels))
cap.release()
cv2.destroyAllWindows()
