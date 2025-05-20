$(document).ready(function () {
    // Lấy token từ localStorage
    const yourAccessToken = localStorage.getItem('token');
    console.log('Access Token:', yourAccessToken);

    // Kiểm tra xem token có tồn tại không
    if (!yourAccessToken) {
        alert('Bạn cần đăng nhập trước khi thực hiện hành động này.');
        return; // Dừng lại nếu không có token
    }

    // Xử lý sự kiện khi form được gửi
    $('form').on('submit', function (event) {
        event.preventDefault(); // Ngăn chặn hành động mặc định của biểu mẫu

        // Lấy file hình ảnh từ input
        const imageFile = $('input[name="image"]')[0].files[0];

        // Lấy dữ liệu từ các trường của biểu mẫu
        const tourData = new FormData();  // Sử dụng FormData để gửi dữ liệu bao gồm file
        tourData.append('Name', $('input[name="name"]').val());
        tourData.append('Description', $('textarea[name="description"]').val());
        tourData.append('Price', parseFloat($('input[name="price"]').val())); // Chuyển đổi giá thành số
        tourData.append('StartDate', $('input[name="start_date"]').val());
        tourData.append('EndDate', $('input[name="end_date"]').val());
        tourData.append('StartPlace', $('input[name="start_point"]').val());
        tourData.append('EndPlace', $('input[name="end_point"]').val());
        tourData.append('AvailableSeats', parseInt($('input[name="availableSeats"]').val())); // Chuyển đổi số lượng thành số nguyên
        tourData.append('TourTypeId', parseInt($('select[name="type"]').val())); // Chuyển đổi loại tour thành số nguyên
        tourData.append('ImageFile', imageFile);  // Thêm file hình ảnh vào form data

        // Gửi đối tượng tourData đến máy chủ bằng AJAX
        $.ajax({
            type: 'POST',
            url: 'https://localhost:44393/api/Tickets', // Đảm bảo URL đúng
            data: tourData, // Gửi đối tượng FormData
            processData: false, // Ngăn chặn jQuery xử lý dữ liệu (vì chúng ta dùng FormData)
            contentType: false, // Để mặc định, cho phép browser tự động đặt
            headers: {
                'Authorization': 'Bearer ' + yourAccessToken
            },
            success: function (response) {
                console.log('Thêm tour thành công:', response);
                alert('Thêm tour thành công');
                // Quay về trang quản lý tour sau khi thêm thành công
                window.location.href = "/admin/tourmanagement/tours";
            },
            error: function (xhr, status, error) {
                alert('Đã có lỗi xảy ra khi thêm tour.');
                console.error('Lỗi:', error);

                try {
                    const errorResponse = JSON.parse(xhr.responseText);
                    console.error("Lỗi từ API:", errorResponse);
                } catch (e) {
                    console.error("Không thể phân tích phản hồi lỗi:", xhr.responseText);
                }
            }
        });
    });
});
