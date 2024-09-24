import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {
  static final Translations _wallet = Translations.byText('en_us') +
      {
        'en_us': 'Teeth Width Prediction',
        'vi_vn': 'Dự Đoán Kích Thước Răng',
      } +
      {
        'en_us': 'View Alternative Prediction',
        'vi_vn': 'Xem dự đoán khác',
      } +
      {
        'en_us': 'Select Gender and Arch',
        'vi_vn': 'Chọn Giới tính và Cung hàm',
      } +
      {
        'en_us': "Gender",
        'vi_vn': "Giới tính",
      } +
      {
        'en_us': 'Male',
        'vi_vn': 'Nam',
      } +
      {
        'en_us': 'Female',
        'vi_vn': 'Nữ',
      } +
      {
        'en_us': 'Arch to predict',
        'vi_vn': 'Cung hàm cần dự đoán',
      } +
      {
        'en_us': 'Upper',
        'vi_vn': 'Hàm trên',
      } +
      {
        'en_us': 'Lower',
        'vi_vn': 'Hàm dưới',
      } +
      {
        'en_us': 'Start',
        'vi_vn': 'Bắt đầu',
      } +
      {
        'en_us': 'Below measurements are required for the best predictions',
        'vi_vn': 'Dưới đây là các số đo cần thiết để có kết quả dự đoán tốt nhất',
      } +
      {
        'en_us': 'Note that only left OR right side measurements is needed', // thêm giùm em câu này
        'vi_vn': 'Lưu ý rằng bạn chỉ cần cung cấp số đo ở bên trái HOẶC bên phải',
      } +
      {
        'en_us':
            "If you are unable to provide these, click 'I DON'T HAVE THESE MEASUREMENTS' button to evaluate based on other measurements",
        'vi_vn':
            "Nếu bạn không thể cung cấp các số đo này, hãy chọn nút 'TÔI KHÔNG CÓ CÁC SỐ ĐO NÀY' để dự đoán bằng các số đo thay thế",
      } +
      {
        'en_us': 'Please provide mesiodistal width (mm) of these teeth',
        'vi_vn': 'Vui lòng nhập kích thước gần xa (mm) của các răng sau đây',
      } +
      {
        'en_us': 'Upper central incisor', // R1T
        'vi_vn': 'Răng cửa giữa hàm trên',
      } +
      {
        'en_us': 'Upper lateral incisor', // R2T
        'vi_vn': 'Răng cửa bên hàm trên',
      } +
      {
        'en_us': 'Upper first molar', // R6T
        'vi_vn': 'Răng cối lớn thứ nhất hàm trên',
      } +
      {
        'en_us': 'Lower central incisor', // R1D
        'vi_vn': 'Răng cửa giữa hàm dưới',
      } +
      {
        'en_us': 'Lower lateral incisor', // R2D
        'vi_vn': 'Răng cửa bên hàm dưới',
      } +
      {
        'en_us': 'Lower first molar', // R6D
        'vi_vn': 'Răng cối lớn thứ nhất hàm dưới',
      } +
      {
        'en_us': 'Eg: 10.00',
        'vi_vn': 'Ví dụ: 10.00',
      } +
      {
        'en_us': 'Predict', // Predict
        'vi_vn': 'Dự đoán',
      } +
      {
        'en_us': 'Reset',
        'vi_vn': 'Làm lại',
      } +
      {
        'en_us': 'Required',
        'vi_vn': 'Bắt buộc',
      } +
      {
        'en_us': 'Result',
        'vi_vn': 'Kết quả',
      } +
      {
        'en_us': "I don't have these measurements",
        'vi_vn': 'Tôi không có các số đo này',
      } +
      {
        'en_us': 'Developed and owned by Thao Ngoc-Phuong Tran and Thanh Tran. All rights reserved.',
        'vi_vn': 'Xây dựng và sở hữu bởi Trần Ngọc Phương Thảo và Thanh Tran. Vui lòng không sao chép.',
      } +
      {
        'en_us': 'For any inquiry, please contact Thao Ngoc-Phuong Tran at t4tran3.2@gmail.com',
        'vi_vn': 'Mọi chi tiết vui lòng liên hệ Trần Ngọc Phương Thảo qua t4tran3.2@gmail.com',
      } +
      {
        'en_us': 'View Best Prediction',
        'vi_vn': 'Xem dự đoán tốt nhất',
      } +
      {
        'en_us': 'Please fill in a valid value. Eg: 10.0',
        'vi_vn': 'Giá trị không phù hợp. Ví dụ: 10.0',
      } +
      {
        'en_us': 'Select all teeth that you can measure',
        'vi_vn': 'Chọn tất cả những răng bạn có thể cung cấp số đo',
      } +
      {
        'en_us': 'Require at least 2 teeth',
        'vi_vn': 'Bắt buộc chọn ít nhất 2 răng',
      } +
      {
        'en_us': 'You only need to provide these measurements. You can click reset button to try again',
        'vi_vn': 'Bạn chỉ cần cung cấp kích thước của các răng bên dưới. Hãy chọn nút Làm lại để bắt đầu lại',
      } +
      {
        'en_us': 'Note: This is an ALTERNATIVE prediction result, may vary by about %s mm from actual value',
        'vi_vn': 'Lưu ý: Đây là kết quả dự đoán THAY THẾ, có thể sai lệch khoảng %s mm so với thực tế',
      };

  static final Translations _translations = _wallet;

  String get i18n => localize(this, _translations);

  String plural(int number) => localizePlural(number, this, _translations);

  String fill(List<Object> params) => localizeFill(this, params);
}
