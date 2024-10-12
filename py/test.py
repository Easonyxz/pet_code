import pydicom
from matplotlib import pyplot as plt

# 读取DCM文件
dcm_file_path = "D:/code/code/pet_code/data/TCGA-Breast-Radiogenomics/manifest-AmUKkZHx1564984923148296294/TCGA-BRCA/TCGA-AO-A0J9/05-11-2001-NA-NA-96851/1.000000-Localization-18424/1-15.dcm"
dataset = pydicom.dcmread(dcm_file_path)

# 输出一些基本信息
print(f"Patient's Name: {dataset.PatientName}")
print(f"Patient ID: {dataset.PatientID}")
print(f"Modality: {dataset.Modality}")

# 显示图像
plt.imshow(dataset.pixel_array, cmap=plt.cm.bone)
plt.show()
