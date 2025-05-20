$(document).ready(function () {
    const yourAccessToken = localStorage.getItem('token');
    console.log('Access Token:', yourAccessToken);

    if (!yourAccessToken) {
        alert('Bạn cần đăng nhập trước khi thực hiện hành động này.');
        return;
    }

    const decodedToken = jwt_decode(yourAccessToken);
    const userId = decodedToken.UserId || decodedToken.nameid;

    function loadUserProfile() {
        $.ajax({
            url: `https://localhost:44393/api/profile/${userId}`,
            type: "GET",
            headers: {
                "Authorization": `Bearer ${yourAccessToken}`
            },
            success: function (data) {
                // Hiển thị thông tin người dùng
                $('#displayFirstName').text(data.firstName);
                $('#displayLastName').text(data.lastName);
                $('#displayPhoneNumber').text(data.phoneNumber);
                $('#displayAddress').text(data.address);
                $('#displayEmail').text(data.email);
                $('#displayBirthDate').text(data.birthDate.split('T')[0]);
                $('#displayGender').text(data.gender);

                // Điền thông tin vào form chỉnh sửa
                $('#firstName').val(data.firstName);
                $('#lastName').val(data.lastName);
                $('#phoneNumber').val(data.phoneNumber);
                $('#address').val(data.address);
                $('#email').val(data.email);
                $('#birthDate').val(data.birthDate.split('T')[0]);

                $('#gender').val(data.gender);
            },
            error: function (error) {
                console.error("Có lỗi xảy ra khi lấy thông tin hồ sơ:", error);
            }
        });
    }

    loadUserProfile();

    // Sự kiện khi nhấn nút "Chỉnh sửa"
    $('#editProfileBtn').on('click', function () {
        $('#userInfo').hide();
        $('#profileForm').show();
    });

    // Sự kiện khi nhấn nút "Hủy"
    $('#cancelEditBtn').on('click', function () {
        $('#profileForm').hide();
        $('#userInfo').show();
    });

    $('#profileForm').on('submit', function (e) {
        e.preventDefault();

        const oldPassword = $('#oldPassword').val();
        if (!oldPassword) {
            alert("Vui lòng nhập mật khẩu cũ.");
            return; // Dừng thực hiện nếu không có mật khẩu cũ
        }

        const updatedProfile = {
            firstName: $('#firstName').val(),
            lastName: $('#lastName').val(),
            phoneNumber: $('#phoneNumber').val(),
            address: $('#address').val(),
            email: $('#email').val(),
            birthDate: $('#birthDate').val() + "T00:00:00", // Đảm bảo định dạng đúng với giờ
            gender: $('#gender').val(),
            oldPassword: oldPassword // Chỉ gửi mật khẩu cũ
        };

        console.log("Đối tượng cập nhật:", updatedProfile);

        $.ajax({
            url: `https://localhost:44393/api/profile/update-profile/${userId}`,
            type: "PUT",
            contentType: "application/json",
            headers: {
                "Authorization": `Bearer ${yourAccessToken}`
            },
            data: JSON.stringify(updatedProfile),
            success: function () {
                alert("Cập nhật hồ sơ thành công!");
                $('#profileForm').hide();
                $('#userInfo').show();
                loadUserProfile(); // Tải lại thông tin người dùng
            },
            error: function (error) {
                console.error("Có lỗi xảy ra khi cập nhật hồ sơ:", error);
                console.error("Chi tiết phản hồi:", error.responseText); // In chi tiết phản hồi từ máy chủ

                // Kiểm tra mã lỗi và hiển thị thông báo phù hợp
                if (error.status === 400) {
                    // Phản hồi từ máy chủ có thể không phải là JSON
                    const responseMessage = error.responseText; // Nhận phản hồi từ máy chủ
                    alert(responseMessage || "Có lỗi xảy ra, vui lòng thử lại."); // Hiển thị thông báo cụ thể
                } else if (error.status === 401) {
                    alert("Mật khẩu cũ không chính xác. Vui lòng thử lại.");
                } else {
                    alert("Có lỗi xảy ra, vui lòng thử lại sau.");
                }
            }

        });
    });
    $('#changePasswordForm').on('submit', function (e) {
        e.preventDefault();

        const oldPassword = $('#oldPassword1').val();
        const newPassword = $('#newPassword').val();
        const confirmPassword = $('#confirmPassword').val();

        if (!oldPassword || !newPassword || !confirmPassword) {
            $('#changePasswordMessage').text("Vui lòng điền đủ thông tin.").css('color', 'red');
            return;
        }

        if (newPassword !== confirmPassword) {
            $('#changePasswordMessage').text("Mật khẩu mới và xác nhận mật khẩu không khớp.").css('color', 'red');
            return;
        }

        const changePasswordData = {
            userId: userId, // Sử dụng userId từ token
            oldPassword: oldPassword,
            newPassword: newPassword,
            confirmPassword: confirmPassword
        };

        $.ajax({
            url: `https://localhost:44393/api/change-password`,
            type: "POST",
            contentType: "application/json",
            headers: {
                "Authorization": `Bearer ${yourAccessToken}`
            },
            data: JSON.stringify(changePasswordData),
            success: function () {
                showAlert("Đổi mật khẩu thành công!", 'green');
                $('#changePasswordForm')[0].reset(); // Đặt lại form
            },
            error: function (error) {
                console.error("Có lỗi xảy ra khi đổi mật khẩu:", error);
                console.error("Chi tiết phản hồi:", error.responseText);
                showAlert(error.responseText || "Có lỗi xảy ra, vui lòng thử lại.", 'red');
            }
        });

        // Hàm hiển thị alert
        function showAlert(message, color) {
            $('#changePasswordMessage').text(message).css('color', color).show().fadeIn(300).delay(5000).fadeOut(300, function () {
                $(this).hide(); // Ẩn sau khi fade out
            });
        }

    });


});

//JavaScript để hiển thị / ẩn form
// Sự kiện khi nhấn nút so xuong doi mat khau
document.getElementById('togglePasswordForm').addEventListener('click', function () {
    var form = document.getElementById('changePasswordForm');
    if (form.style.display === "none" || form.style.display === "") {
        form.style.display = "block"; // Hiển thị form nếu đang bị ẩn
    } else {
        form.style.display = "none"; // Ẩn form nếu đang hiển thị
    }
});
