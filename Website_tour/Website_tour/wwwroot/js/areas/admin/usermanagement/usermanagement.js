document.addEventListener("DOMContentLoaded", function () {
    let allUsers = []; // Mảng lưu trữ tất cả người dùng
    let allRoles = []; // Mảng lưu trữ tất cả vai trò

    // Lấy access token từ localStorage
    const yourAccessToken = localStorage.getItem('token'); // Đổi từ 'accessToken' thành 'token'
    console.log('Access Token:', yourAccessToken);

    // Kiểm tra xem token có tồn tại không
    if (!yourAccessToken) {
        alert('Bạn cần đăng nhập trước khi thực hiện hành động này.');
        return; // Dừng lại nếu không có token
    }
    
    // Gửi yêu cầu GET đến API để lấy danh sách người dùng
    fetch('https://localhost:44393/api/user-role/get-users-and-roles', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${yourAccessToken}`, // Sử dụng token
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Mã lỗi: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log(data);
            allUsers = data || []; // Lấy mảng người dùng
            renderUserList(allUsers);
        })
        .catch(error => {
            console.error('Lỗi:', error);
            alert('Không thể lấy danh sách người dùng: ' + error.message);
        });

    // Lấy danh sách vai trò từ API
    fetch('https://localhost:44393/api/user-role/get-roles', {
        method: 'GET',
        headers: {
            'Authorization': `Bearer ${yourAccessToken}`, // Sử dụng token
            'Content-Type': 'application/json'
        }
    })
        .then(response => {
            if (!response.ok) {
                throw new Error('Mã lỗi: ' + response.status);
            }
            return response.json();
        })
        .then(data => {
            console.log('Vai trò:', data);
            allRoles = data || []; // Lấy mảng vai trò
            const roleSelect = document.getElementById('searchByRole');
            roleSelect.innerHTML = '<option value="">Tất cả vai trò</option>'; // Reset dropdown

            allRoles.forEach(role => {
                const option = document.createElement('option');
                option.value = role; // Giá trị của option sẽ là tên vai trò
                option.textContent = role; // Hiển thị tên vai trò
                roleSelect.appendChild(option);
            });
        })
        .catch(error => {
            console.error('Lỗi:', error);
            alert('Không thể lấy danh sách vai trò: ' + error.message);
        });

    // Hàm hiển thị danh sách người dùng
    function renderUserList(users) {
        const userList = document.getElementById('user-list').getElementsByTagName('tbody')[0];
        userList.innerHTML = ''; // Xóa nội dung cũ trước khi thêm mới

        users.forEach(function (user, index) {
            const userRow = userRowHtml(user, index);
            userList.insertAdjacentHTML('beforeend', userRow);
        });
    }

    function userRowHtml(user, index) {
        const birthDate = formatDate(user.birthDate);
        const createdAt = formatDate(user.createdAt);
        const roleName = Array.isArray(user.role) && user.role.length > 0
            ? user.role.join(', ')
            : 'Chưa xác định';

        return `<tr>
            <td>${index + 1}</td>
            <td>${user.email}</td>
            <td>${user.lastName +" "+ user.firstName }</td>
            
            <td>${user.phoneNumber}</td>
            <td>${user.address}</td>
            <td>${user.gender}</td>
            <td>${birthDate}</td>
            <td>${createdAt}</td>
            <td>${roleName}</td>
            <td>
                <button class="btn btn-primary edit-button" data-id="${user.userId}">Sửa</button>
                <button class="btn btn-danger delete-button" data-id="${user.userId}">Xóa</button>     
            </td>
        </tr>`;
    }

    function formatDate(dateString) {
        const date = new Date(dateString);
        return `${date.getDate().toString().padStart(2, '0')}-${(date.getMonth() + 1).toString().padStart(2, '0')}-${date.getFullYear()}`;
    }

    // Sự kiện cho nút Sửa
    document.addEventListener('click', function (e) {
        if (e.target.classList.contains('edit-button')) {
            const userId = e.target.getAttribute('data-id');
            const user = allUsers.find(u => u.userId === userId);
            if (user) {
                // Điền thông tin người dùng vào popup
                document.getElementById('editUserId').value = user.userId;
                document.getElementById('editUserEmail').value = user.email;
                document.getElementById('editUserFirstName').value = user.firstName;
                document.getElementById('editUserLastName').value = user.lastName;
                document.getElementById('editUserPhoneNumber').value = user.phoneNumber;
                document.getElementById('editUserAddress').value = user.address;
                document.getElementById('editUserGender').value = user.gender;
                document.getElementById('editUserBirthDate').value = user.birthDate.split('T')[0]; // Chỉ lấy ngày

                // Thêm vai trò vào dropdown
                const roleSelect = document.getElementById('editUserRole');
                roleSelect.innerHTML = ''; // Xóa nội dung cũ
                allRoles.forEach(role => {
                    const option = document.createElement('option');
                    option.value = role; // Giá trị của option là tên vai trò
                    option.textContent = role; // Hiển thị tên vai trò
                    if (user.role.includes(role)) {
                        option.selected = true; // Đánh dấu vai trò hiện tại là được chọn
                    }
                    roleSelect.appendChild(option);
                });

                // Hiện popup
                document.getElementById('editUserModal').style.display = 'block';
            }
        }

        if (e.target.id === 'closeEditModal') {
            document.getElementById('editUserModal').style.display = 'none';
        }

        if (e.target.classList.contains('delete-button')) {
            const userId = e.target.getAttribute('data-id');
            if (confirm('Bạn có chắc chắn muốn xóa người dùng này không?')) {
                fetch(`https://localhost:44393/api/user-role/delete-user/${userId}`, {
                    method: 'DELETE',
                    headers: {
                        'Authorization': `Bearer ${yourAccessToken}`, // Sử dụng token
                        'Content-Type': 'application/json'
                    }
                })
                    .then(response => {
                        if (response.ok) {
                            alert('Người dùng đã được xóa thành công.');
                            refreshUserList();
                        } else {
                            throw new Error('Không thể xóa người dùng.');
                        }
                    })
                    .catch(error => {
                        console.error('Lỗi:', error);
                        alert('Không thể xóa người dùng: ' + error.message);
                    });
            }
        }
    });

    // Cập nhật người dùng
    document.getElementById('editUserForm').addEventListener('submit', function (e) {
        e.preventDefault();

        const userId = document.getElementById('editUserId').value;
        const updatedUser = {
            userId: userId,
            email: document.getElementById('editUserEmail').value,
            firstName: document.getElementById('editUserFirstName').value,
            lastName: document.getElementById('editUserLastName').value,
            phoneNumber: document.getElementById('editUserPhoneNumber').value,
            address: document.getElementById('editUserAddress').value,
            gender: document.getElementById('editUserGender').value,
            birthDate: document.getElementById('editUserBirthDate').value,
            role: Array.from(document.getElementById('editUserRole').selectedOptions).map(option => option.value)
        };

        fetch(`https://localhost:44393/api/user-role/update-user/${userId}`, {
            method: 'PUT',
            headers: {
                'Authorization': `Bearer ${yourAccessToken}`, // Sử dụng token
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(updatedUser)
        })
            .then(response => {
                if (response.ok) {
                    alert('Cập nhật người dùng thành công!');
                    document.getElementById('editUserModal').style.display = 'none';
                    refreshUserList(); // Làm mới danh sách người dùng
                } else {
                    return response.json().then(err => {
                        throw new Error(err.message || 'Không thể cập nhật người dùng.');
                    });
                }
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Không thể cập nhật người dùng: ' + error.message);
            });
    });

    // Hàm làm mới danh sách người dùng
    function refreshUserList() {
        fetch('https://localhost:44393/api/user-role/get-users-and-roles', {
            method: 'GET',
            headers: {
                'Authorization': `Bearer ${yourAccessToken}`,
                'Content-Type': 'application/json'
            }
        })
            .then(response => {
                if (!response.ok) {
                    throw new Error('Mã lỗi: ' + response.status);
                }
                return response.json();
            })
            .then(data => {
                allUsers = data || [];
                renderUserList(allUsers);
            })
            .catch(error => {
                console.error('Lỗi:', error);
                alert('Không thể làm mới danh sách người dùng: ' + error.message);
            });
    }


    // Tìm kiếm người dùng theo vai trò
    document.getElementById('searchByRole').addEventListener('change', function () {
        const selectedRole = this.value;

        // Lọc người dùng dựa trên vai trò được chọn
        const filteredUsers = selectedRole
            ? allUsers.filter(user => Array.isArray(user.role) && user.role.includes(selectedRole))
            : allUsers;

        renderUserList(filteredUsers);
    });

});
