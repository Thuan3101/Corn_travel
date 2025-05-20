
// Mở modal
function openModal() {
    document.getElementById("loginModal").style.display = "block";
}

// Đóng modal
function closeModal() {
    document.getElementById("loginModal").style.display = "none";
}

// Đảm bảo khi người dùng nhấn bên ngoài modal cũng sẽ đóng nó
window.onclick = function (event) {
    if (event.target === document.getElementById("loginModal")) {
        closeModal();
    }
}

// Hàm giải mã JWT để lấy thông tin từ token
// Hàm giải mã JWT để lấy thông tin từ token
function parseJwt(token) {
    console.log("Token:", token); // In ra token
    if (typeof token !== 'string') {
        console.error("Token không hợp lệ hoặc không phải là chuỗi:", token);
        return null;
    }
    

    var parts = token.split('.');
    if (parts.length !== 3) {
        console.error("Token không có đủ ba phần.");
        return null;
    }

    var base64Url = parts[1];
    if (!base64Url) {
        console.error("Phần payload không tồn tại trong token.");
        return null;
    }

    var base64 = base64Url.replace(/-/g, '+').replace(/_/g, '/');

    var jsonPayload = decodeURIComponent(atob(base64).split('').map(function (c) {
        return '%' + ('00' + c.charCodeAt(0).toString(16)).slice(-2);
    }).join(''));

    return JSON.parse(jsonPayload);
}

// Hàm kiểm tra token có hết hạn không
function isTokenExpired(token) {
    const decodedToken = parseJwt(token);
    if (decodedToken && decodedToken.exp) {
        const expTime = decodedToken.exp * 1000; // Chuyển đổi thời gian hết hạn về milliseconds
        return Date.now() >= expTime; // Kiểm tra xem thời gian hiện tại có vượt quá thời gian hết hạn không
    }
    return true; // Nếu không có thông tin exp, coi như token đã hết hạn
}

// Biến để kiểm tra xem đã hiển thị thông báo chưa
let hasShownExpiredAlert = false;

// Hàm hiển thị nút Admin hoặc Manage
function showRoleButton(role) {
    const adminNavItem = document.getElementById("adminNavItem");
    adminNavItem.style.display = "block";
    if (role === "Admin") {
        adminNavItem.innerHTML = '<a href="/admin">Admin</a>'; // Hiển thị nút Admin
    } else if (role === "Manage") {
        adminNavItem.innerHTML = '<a href="/manage">Manage</a>'; // Hiển thị nút Manage
    }
}

// Khi tài liệu sẵn sàng
$(document).ready(function () {
    // Kiểm tra xem người dùng đã đăng nhập chưa
    const token = localStorage.getItem("token");
    if (token) {
        if (!isTokenExpired(token)) {
            // Tiếp tục xử lý nếu token hợp lệ và chưa hết hạn
            var decodedToken = parseJwt(token); // Gọi hàm parseJwt
            updateLoginLogoutButton(true);

            // Kiểm tra vai trò trong token
            var roles = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
            console.log("Roles từ token:", roles); // In ra các vai trò

            // Hiển thị nút tương ứng dựa trên vai trò
            if (Array.isArray(roles)) {
                if (roles.includes("Admin")) {
                    showRoleButton("Admin"); // Hiện nút Admin
                } else if (roles.includes("Manage")) {
                    showRoleButton("Manage"); // Hiện nút Manage
                }
            } else if (typeof roles === 'string') {
                if (roles === "Admin") {
                    showRoleButton("Admin"); // Hiện nút Admin
                } else if (roles === "Manage") {
                    showRoleButton("Manage"); // Hiện nút Manage
                }
            }

            // Hiển thị biểu tượng thông tin tài khoản
            document.getElementById("accountInfo").style.display = "block"; // Hiển thị nút thông tin tài khoản
        } else {
            // Nếu token đã hết hạn
            console.log("Phiên đăng nhập đã hết hạn.");
            if (!hasShownExpiredAlert) {
                alert("Hết phiên đăng nhập.Bạn sẽ được đăng xuất.");
                hasShownExpiredAlert = true; // Đánh dấu rằng đã hiển thị thông báo
                logout(); // Gọi hàm đăng xuất ngay sau khi hiển thị thông báo
            }
        }
    } else {
        // Nếu không có token
        console.log("Không có token. Người dùng chưa đăng nhập.");
        updateLoginLogoutButton(false); // Đảm bảo nút đăng nhập hiển thị
    }

    // Đảm bảo chọn form bên trong modal
    $("#loginModal form").submit(function (event) {
        event.preventDefault(); // Ngăn chặn trang load lại

        var email = $("#loginEmail").val();
        var password = $("#loginPassword").val();

        var loginData = {
            email: email,
            password: password
        };

        $.ajax({
            url: "https://localhost:44393/api/signin",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(loginData),
            success: function (response) {
                alert("Đăng nhập thành công!");
                console.log("Response:", response); // In ra response để kiểm tra

                // Lưu token từ response
                if (response.data && response.data.accessToken) {
                    localStorage.setItem("token", response.data.accessToken); // Lưu token từ response
                } else {
                    console.error("Token không tồn tại trong response.");
                    return; // Dừng lại nếu không có token
                }

                var decodedToken = parseJwt(response.data.accessToken); // Gọi hàm parseJwt
                // Kiểm tra vai trò trong token và hiển thị nút tương ứng
                if (decodedToken) {
                    var roles = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];
                    console.log("Roles từ response:", roles); // In ra các vai trò

                    if (Array.isArray(roles)) {
                        if (roles.includes("Admin")) {
                            showRoleButton("Admin");
                        } else if (roles.includes("Manage")) {
                            showRoleButton("Manage");
                        }
                    }
                }

                // Hiển thị biểu tượng thông tin tài khoản
                document.getElementById("accountInfo").style.display = "block"; // Hiển thị nút thông tin tài khoản

                closeModal(); // Đóng modal khi đăng nhập thành công
                window.location.href = "/home/index"; // Chuyển hướng nếu cần
            },
            error: function (xhr, status, error) {
                alert("Đăng nhập thất bại!");
                console.log("Response text:", xhr.responseText);
                console.log("Status:", status);
                console.log("Error:", error);
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

// Cập nhật giao diện nút Đăng nhập/Đăng xuất
function updateLoginLogoutButton(isLoggedIn) {
    const loginLogoutBtn = document.getElementById("loginLogoutBtn");
    if (isLoggedIn) {
        loginLogoutBtn.innerHTML = '<a href="javascript:void(0);" onclick="logout()"><img src="/image/logout.png" alt="Đăng xuất" style="width: 30px; height: 30px;"></a>';
    } else {
        loginLogoutBtn.innerHTML = '<a href="javascript:void(0);" onclick="openModal()"><img src="/image/login1.png" alt="Đăng nhập" style="width: 30px; height: 30px;"></a>';
    }
}

// Hàm xử lý Đăng xuất
function logout() {
    // Hiển thị thông báo xác nhận
    const confirmation = confirm("Bạn có chắc chắn muốn đăng xuất?");
    if (confirmation) {
        localStorage.removeItem("token");
        updateLoginLogoutButton(false);
        document.getElementById("accountInfo").style.display = "none"; // Ẩn nút thông tin tài khoản
        alert("Đăng xuất thành công!");
        window.location.href = "/home/index"; // Có thể chuyển hướng người dùng nếu cần
    } else {
        console.log("Người dùng đã chọn không đăng xuất.");
    }
}

// Hàm hiển thị nút Admin
function showAdminButton() {
    document.getElementById("adminNavItem").style.display = "block";
}
