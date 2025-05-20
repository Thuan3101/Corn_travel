$(document).ready(function () {
    // Khi nhấn nút gửi mã OTP
    $("#sendOtpBtn").click(function () {
        var emailOrPhone = $("#emailOrPhone").val();

        // Kiểm tra xem trường nhập email hoặc số điện thoại có rỗng không
        if (emailOrPhone === "") {
            alert("Vui lòng nhập email hoặc số điện thoại.");
            return;
        }

        // Gửi yêu cầu đến API gửi mã OTP
        $.ajax({
            url: "https://localhost:44393/api/otp/send-otp", // Đường dẫn API gửi mã OTP
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                Email: emailOrPhone
            }),
            success: function (response) {
                alert("Mã OTP đã được gửi thành công đến email hoặc số điện thoại của bạn!");
                // Hiện thị trường nhập OTP và mật khẩu mới
                $(".otp-field").show();
                $("#sendOtpBtn").hide();
            },
            error: function (xhr, status, error) {
                alert("Gửi mã OTP thất bại! Vui lòng kiểm tra lại email hoặc số điện thoại.");
                console.log("Response text:", xhr.responseText);
                console.log("Status:", status);
                console.log("Error:", error);
            }
        });
    });

    // Khi gửi form để xác minh mã OTP và cập nhật mật khẩu mới
    $("#forgetForm").submit(function (event) {
        event.preventDefault(); // Ngăn không cho form gửi đi

        var otpCode = $("#otpCode").val();
        var password = $("#password").val();
        var emailOrPhone = $("#emailOrPhone").val();

        // Kiểm tra OTP và mật khẩu
        if (otpCode === "" || password === "") {
            alert("Vui lòng điền đầy đủ thông tin.");
            return;
        }

        // Kiểm tra định dạng mật khẩu
        var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
        if (!passwordRegex.test(password)) {
            alert("Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất 1 chữ in hoa, 1 chữ thường, 1 ký tự đặc biệt và 1 chữ số.");
            return;
        }

        // Gửi yêu cầu đến API xác minh mã OTP và cập nhật mật khẩu mới
        $.ajax({
            url: "https://localhost:44393/api/otp/reset-password",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                email: emailOrPhone,
                otpCode: otpCode,
                newPassword: password
            }),
            success: function (response) {
                alert("Mật khẩu đã được cập nhật thành công!");
                setTimeout(function () {
                    window.location.href = "/home/index"; // Chuyển hướng đến trang đăng nhập
                }, 2000);
            },
            error: function (xhr, status, error) {
                alert("Cập nhật mật khẩu thất bại!");
                console.log("Response text:", xhr.responseText);
                console.log("Status:", status);
                console.log("Error:", error);
            }
        });
    });
});
