document.addEventListener("DOMContentLoaded", function () {
    let allRoles = [];

    // Lấy access token từ localStorage
    const yourAccessToken = localStorage.getItem('token'); // Đổi từ 'accessToken' thành 'token'
    console.log('Access Token:', yourAccessToken);

    // Kiểm tra xem token có tồn tại không
    if (!yourAccessToken) {
        alert('Bạn cần đăng nhập trước khi thực hiện hành động này.');
        return; // Dừng lại nếu không có token
    }

    // Lấy danh sách vai trò từ API
    // Lấy danh sách vai trò từ API
    fetch('https://localhost:44393/api/user-role/get-roles', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${yourAccessToken}`, // Thêm token vào header
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Có lỗi xảy ra khi lấy vai trò');
            }
            return response.json();
        })
        .then(data => {
            console.log('Vai trò:', data); // In ra dữ liệu để kiểm tra

            const roleSelect = document.getElementById('addUserRole');
            roleSelect.innerHTML = '<option value="">Chọn vai trò</option>'; // Tạo option mặc định

            // Thêm các vai trò vào dropdown
            data.forEach(role => {
                const option = document.createElement('option');
                option.value = role; // Gán giá trị vai trò
                option.textContent = role; // Hiển thị tên vai trò
                roleSelect.appendChild(option);
            });
        })
        .catch(error => {
            console.error('Lỗi:', error);
            alert('Không thể lấy danh sách vai trò.');
        });


    // Xử lý sự kiện submit form để thêm người dùng
    document.getElementById('addUserForm').addEventListener('submit', function (e) {
        e.preventDefault();
        const password = document.getElementById('addUserPassword').value;
        const confirmPassword = document.getElementById('confirmPassword').value;

        if (password !== confirmPassword) {
            alert('Mật khẩu và nhập lại mật khẩu không khớp!');
            return;
        }

        const selectedRole = document.getElementById('addUserRole').value;
        if (!selectedRole) {
            alert('Vui lòng chọn vai trò cho người dùng!');
            return;
        }

        const newUser = {
            userId: "", // Để trống cho người dùng mới
            email: document.getElementById('addUserEmail').value,
            firstName: document.getElementById('addUserFirstName').value,
            lastName: document.getElementById('addUserLastName').value,
            phoneNumber: document.getElementById('addUserPhoneNumber').value,
            address: document.getElementById('addUserAddress').value,
            gender: document.getElementById('addUserGender').value,
            birthDate: new Date(document.getElementById('addUserBirthDate').value).toISOString(),
            createdAt: new Date().toISOString(),
            password: password,
            role: [selectedRole] // Đưa vai trò vào một mảng
        };

        console.log("Dữ liệu người dùng:", newUser);
        console.log("Dữ liệu gửi đi:", JSON.stringify(newUser));

        fetch('https://localhost:44393/api/user-role/add-user', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'Authorization': `Bearer ${yourAccessToken}` // Thêm token vào header
            },
            body: JSON.stringify(newUser)
        })
            .then(response => {
                return response.text().then(text => {
                    console.log('Phản hồi từ server:', text);
                    if (response.ok) {
                        return { message: text }; // Giả định máy chủ trả về một thông điệp
                    } else {
                        throw new Error(text || 'Có lỗi xảy ra khi thêm người dùng');
                    }
                });
            })
            .then(data => {
                console.log('Phản hồi từ server:', data);
                alert(data.message || 'Thêm người dùng thành công!');
                window.location.href = "/admin/usermanagement/user";
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Không thể thêm người dùng: ' + error.message);
            });
    });
});
