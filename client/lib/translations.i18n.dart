import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final Translations _wallet = Translations.byText('en-US') +
      {
        'en-US': 'Teeth Width Prediction',
        'vi-VN': 'Dự Đoán Kích Thước Răng',
      } +
      {
        'en-US': 'View Alternative Prediction',
        'vi-VN': 'Xem dự đoán khác',
      } +
      {
        'en-US': 'Select Gender and Arch',
        'vi-VN': 'Chọn Giới tính và Cung hàm',
      } +
      {
        'en-US': "Gender",
        'vi-VN': "Giới tính",
      } +
      {
        'en-US': 'Male',
        'vi-VN': 'Nam',
      } +
      {
        'en-US': 'Female',
        'vi-VN': 'Nữ',
      } +
      {
        'en-US': 'Arch to predict',
        'vi-VN': 'Cung hàm cần dự đoán',
      } +
      {
        'en-US': 'Upper',
        'vi-VN': 'Hàm trên',
      } +
      {
        'en-US': 'Lower',
        'vi-VN': 'Hàm dưới',
      } +
      {
        'en-US': 'Start',
        'vi-VN': 'Bắt đầu',
      } +
      {
        'en-US': 'Below measurements are required for the best predictions',
        'vi-VN': 'Dưới đây là các số đo cần thiết để có kết quả dự đoán tốt nhất',
      } +
      {
        'en-US': 'Note that only left OR right side measurements is needed', // thêm giùm em câu này
        'vi-VN': 'Lưu ý rằng bạn chỉ cần cung cấp số đo ở bên trái HOẶC bên phải',
      } +
      {
        'en-US':
            "If you are unable to provide these, click 'I DON'T HAVE THESE MEASUREMENTS' button to evaluate based on other measurements",
        'vi-VN':
            "Nếu bạn không thể cung cấp các số đo này, hãy chọn nút 'TÔI KHÔNG CÓ CÁC SỐ ĐO NÀY' để dự đoán bằng các số đo thay thế",
      } +
      {
        'en-US': 'Please provide mesiodistal width (mm) of these teeth',
        'vi-VN': 'Vui lòng nhập kích thước gần xa (mm) của các răng sau đây',
      } +
      {
        'en-US': 'Upper central incisor', // R1T
        'vi-VN': 'Răng cửa giữa hàm trên',
      } +
      {
        'en-US': 'Upper lateral incisor', // R2T
        'vi-VN': 'Răng cửa bên hàm trên',
      } +
      {
        'en-US': 'Upper first molar', // R6T
        'vi-VN': 'Răng cối lớn thứ nhất hàm trên',
      } +
      {
        'en-US': 'Lower central incisor', // R1D
        'vi-VN': 'Răng cửa giữa hàm dưới',
      } +
      {
        'en-US': 'Lower lateral incisor', // R2D
        'vi-VN': 'Răng cửa bên hàm dưới',
      } +
      {
        'en-US': 'Lower first molar', // R6D
        'vi-VN': 'Răng cối lớn thứ nhất hàm dưới',
      } +
      {
        'en-US': 'Eg: 10.00',
        'vi-VN': 'Ví dụ: 10.00',
      } +
      {
        'en-US': 'Predict', // Predict
        'vi-VN': 'Dự đoán',
      } +
      {
        'en-US': 'Reset',
        'vi-VN': 'Làm lại',
      } +
      {
        'en-US': 'Required',
        'vi-VN': 'Bắt buộc',
      } +
      {
        'en-US': 'Result',
        'vi-VN': 'Kết quả',
      } +
      {
        'en-US': "I don't have these measurements",
        'vi-VN': 'Tôi không có các số đo này',
      } +
      {
        'en-US': 'Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran. All rights reserved.',
        'vi-VN': 'Xây dựng và sở hữu bởi Trần Ngọc Phương Thảo và Thanh Tran. Vui lòng không sao chép.',
      } +
      {
        'en-US': 'For any inquiry, please contact Thao Ngoc-Phuong Tran at tranngocphuongthao@gmail.com',
        'vi-VN': 'Mọi chi tiết vui lòng liên hệ Trần Ngọc Phương Thảo qua tranngocphuongthao@gmail.com',
      } +
      {
        'en-US': 'View Best Prediction',
        'vi-VN': 'Xem dự đoán tốt nhất',
      } +
      {
        'en-US': 'Please fill in a valid value. Eg: 10.0',
        'vi-VN': 'Giá trị không phù hợp. Ví dụ: 10.0',
      } +
      {
        'en-US': 'Select all teeth that you can measure',
        'vi-VN': 'Chọn tất cả những răng bạn có thể cung cấp số đo',
      } +
      {
        'en-US': 'Require at least 2 teeth',
        'vi-VN': 'Bắt buộc chọn ít nhất 2 răng',
      } +
      {
        'en-US': 'You only need to provide these measurements. You can click reset button to try again',
        'vi-VN': 'Bạn chỉ cần cung cấp kích thước của các răng bên dưới. Hãy chọn nút Làm lại để bắt đầu lại',
      } +
      {
        'en-US': 'Note: This is an ALTERNATIVE prediction result, may vary by about %s mm from actual value',
        'vi-VN': 'Lưu ý: Đây là kết quả dự đoán THAY THẾ, có thể sai lệch khoảng %s mm so với thực tế',
      };

  static final Translations _translations = _wallet;

  String get i18n => localize(this, _translations);

  String plural(int number) => localizePlural(number, this, _translations);

  String fill(List<Object> params) => localizeFill(this, params);
}
