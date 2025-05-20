// Mở modal
function openModal() {
    document.getElementById("verifyOtpContainer").style.display = "block";
}

// Đóng modal
function closeModal() {
    console.log("Closing modal..."); // Thêm log để kiểm tra
    document.getElementById("verifyOtpContainer").style.display = "none";
}

// Đảm bảo khi người dùng nhấn bên ngoài modal cũng sẽ đóng nó
window.onclick = function (event) {
    if (event.target === document.getElementById("verifyOtpContainer")) {
        closeModal();
    }
}

$(document).ready(function () {
    var registerData; // Khai báo biến toàn cục ở đây

    // Xử lý gửi form đăng ký
    $("#registerForm").submit(function (event) {
        event.preventDefault(); // Ngăn chặn trang load lại

        // Thu thập dữ liệu từ form
        registerData = {
            firstName: $("#firstName").val(),
            lastName: $("#lastName").val(),
            email: $("#email").val(),
            password: $("#password").val(),
            confirmPassword: $("#confirmPassword").val(),
            phoneNumber: $("#phoneNumber").val(),
            address: $("#address").val(),
            birthDate: $("#birthDate").val(),
            gender: $("#gender").val()
        };

        // Kiểm tra tính hợp lệ của mật khẩu
        var passwordRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[!@#$%^&*])[A-Za-z\d!@#$%^&*]{8,}$/;
        if (!passwordRegex.test(registerData.password)) {
            alert("Mật khẩu phải có ít nhất 8 ký tự, bao gồm ít nhất 1 chữ in hoa, 1 chữ thường, 1 ký tự đặc biệt và 1 chữ số.");
            return; // Ngăn không cho tiếp tục nếu mật khẩu không hợp lệ
        }

        // Kiểm tra xác nhận mật khẩu
        if (registerData.password !== registerData.confirmPassword) {
            alert("Mật khẩu và xác nhận mật khẩu không khớp!");
            return; // Ngăn không cho tiếp tục nếu mật khẩu và xác nhận không khớp
        }

        // Gửi dữ liệu để yêu cầu gửi mã OTP
        $.ajax({
            url: "https://localhost:44393/api/otp/send-otp",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ email: registerData.email }),
            success: function (response) {
                alert("Mã OTP đã được gửi đến email của bạn!");
                $("#verifyOtpContainer").show(); // Hiển thị phần nhập mã OTP
                $("#registerForm").hide(); // Ẩn form đăng ký
            },
            error: function (xhr, status, error) {
                alert("Gửi mã OTP thất bại!");
                console.log("Response text:", xhr.responseText);
                console.log("Status:", status);
                console.log("Error:", error);
            }
        });
    });

    // Xác nhận mã OTP
    $("#verifyOtpButton").click(function () {
        var otpData = {
            email: $("#email").val(),
            otpCode: $("#otpCode").val()
        };

        $.ajax({
            url: "https://localhost:44393/api/otp/verify-otp",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(otpData),
            success: function (response) {
                completeRegistration();
            },
            error: function (xhr, status, error) {
                alert("Xác thực mã OTP thất bại! Vui lòng kiểm tra lại mã OTP.");
                console.log("Response text:", xhr.responseText);
                console.log("Status:", status);
                console.log("Error:", error);
            }
        });
    });

    // Hàm hoàn tất đăng ký
    function completeRegistration() {
        if (registerData) {
            $.ajax({
                url: "https://localhost:44393/api/signup",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify(registerData),
                success: function (response) {
                    alert("Xác thực mã OTP thành công! Đăng ký thành công!");
                    setTimeout(function () {
                        window.location.href = "/home/index";
                    }, 2000);
                },
                error: function (xhr, status, error) {
                    var errorResponse = JSON.parse(xhr.responseText);
                    if (Array.isArray(errorResponse) && errorResponse.length > 0) {
                        alert(errorResponse[0].description);
                    } else {
                        alert("Đăng ký thất bại! Vui lòng thử lại.");
                    }
                    console.log("Response text:", xhr.responseText);
                    console.log("Status:", status);
                    console.log("Error:", error);
                }
            });

            registerData = null; // Đặt lại biến sau khi hoàn tất đăng ký
        }
    }
});



