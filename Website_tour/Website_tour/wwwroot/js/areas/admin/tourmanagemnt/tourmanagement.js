$(document).ready(function () {
    let allTours = [];
    const yourAccessToken = localStorage.getItem('token');
    let currentPage = 1;
    const limit = 5;

    if (!yourAccessToken) {
        alert('Bạn cần đăng nhập trước khi thực hiện hành động này.');
        return;
    }

    function getTourTypeName(tourTypeId) {
        switch (tourTypeId) {
            case 1: return 'Tour trong nước';
            case 2: return 'Tour ngoài nước';
            case 3: return 'Tour kết hợp';
            default: return 'Không xác định';
        }
    }

    function fetchTours(page = 1, searchParams = {}) {
        $('#tour-list').html('<tr><td colspan="12" class="text-center">Đang tải dữ liệu...</td></tr>');

        let url;
        if (searchParams.name && searchParams.name.trim() !== '') {
            url = `https://localhost:44393/api/tour-translation?name=${encodeURIComponent(searchParams.name)}&page=${page}&pageSize=${limit}`;
        } else if (searchParams.type && searchParams.type !== '') {
            url = `https://localhost:44393/api/tour?tourTypeId=${encodeURIComponent(searchParams.type)}&page=${page}&pageSize=${limit}`;
        } else {
            url = `https://localhost:44393/api/tour?page=${page}&limit=${limit}`;
        }

        console.log("API URL:", url);

        $.ajax({
            type: 'GET',
            url: url,
            contentType: 'application/json',
            headers: {
                'Authorization': `Bearer ${yourAccessToken}`
            },
            success: function (toursResponse) {
                const tours = toursResponse.$values || toursResponse;

                if (!Array.isArray(tours) || tours.length === 0) {
                    $('#tour-list').empty();
                    $('#tour-list').append('<tr><td colspan="12" class="text-center">Không tìm thấy tour nào</td></tr>');
                    updatePaginationButtons(page, false);
                    return;
                }

                const tourDataPromises = tours.map(tour => {
                    return Promise.all([
                        $.ajax({
                            url: `https://localhost:44393/api/tour/${tour.tourId}`,
                            headers: { 'Authorization': `Bearer ${yourAccessToken}` },
                            contentType: 'application/json'
                        }),
                        $.ajax({
                            url: `https://localhost:44393/api/tour-departure/${tour.tourId}`,
                            headers: { 'Authorization': `Bearer ${yourAccessToken}` },
                            contentType: 'application/json'
                        }),
                        $.ajax({
                            url: `https://localhost:44393/api/tour-image/${tour.tourId}`,
                            headers: { 'Authorization': `Bearer ${yourAccessToken}` },
                            contentType: 'application/json'
                        }),
                        $.ajax({
                            url: `https://localhost:44393/api/tour-itinerary/${tour.tourId}`,
                            headers: { 'Authorization': `Bearer ${yourAccessToken}` },
                            contentType: 'application/json'
                        }),
                        $.ajax({
                            url: `https://localhost:44393/api/tour-translation/${tour.tourId}`,
                            headers: { 'Authorization': `Bearer ${yourAccessToken}` },
                            contentType: 'application/json'
                        })
                    ]).then(([tourDetails, departure, image, itinerary, translation]) => {
                        return {
                            ...tourDetails,
                            departure: departure.$values?.[0] || departure,
                            image: image.$values || image,
                            itinerary: itinerary.$values || itinerary,
                            translation: translation.$values?.[0] || translation
                        };
                    });
                });

                Promise.all(tourDataPromises)
                    .then(allTourData => {
                        allTours = [...allTourData];
                        renderTourList(allTourData, page);
                        updatePaginationButtons(page, allTourData.length >= limit);
                    })
                    .catch(error => {
                        console.error('Lỗi khi lấy chi tiết tour:', error);
                        $('#tour-list').empty();
                        $('#tour-list').append('<tr><td colspan="12" class="text-center">Đã xảy ra lỗi khi tải chi tiết tour</td></tr>');
                    });
            },
            error: function (error) {
                console.error('Lỗi:', error);
                $('#tour-list').empty();
                $('#tour-list').append('<tr><td colspan="12" class="text-center">Đã xảy ra lỗi khi tải dữ liệu</td></tr>');
            }
        });
    

    }


    


    function renderTourList(tours, page) {
        const tourList = $('#tour-list');
        tourList.empty();

        tours.forEach(function (tour, index) {
            const serialNumber = (page - 1) * limit + index + 1;
            const imageUrl = tour.image && tour.image.length > 0 && tour.image[0].imageUrl ? tour.image[0].imageUrl : 'default-image.jpg';
            const tourRow = `
            <tr>
                <td>${serialNumber}</td>
                <td><img src="${imageUrl}" alt="${tour.translation?.name || 'Không có tên'}" class="img-thumbnail" style="max-width: 100px;" /></td>
                <td>${tour.translation?.name || 'Không có tên'}</td>
                <td>${tour.translation?.description || 'Không có mô tả'}</td>
                <td>${tour.departure?.price ? tour.departure.price.toLocaleString() + ' VND' : 'N/A'}</td>
                <td>${tour.departure?.departureDate ? new Date(tour.departure.departureDate).toLocaleDateString() : 'N/A'}</td>
                <td>${tour.departure?.returnDate ? new Date(tour.departure.returnDate).toLocaleDateString() : 'N/A'}</td>
                <td>${tour.departure?.availableSeats || 'N/A'}</td>
                <td>${tour.startPlace || 'N/A'}</td> <!-- Hiển thị startPlace -->
                <td>${tour.endPlace || 'N/A'}</td> <!-- Hiển thị endPlace -->
                <td>${getTourTypeName(tour.tourTypeId) || 'Không xác định'}</td> <!-- Hiển thị tourType -->
                <td>
                    <button class="btn btn-primary edit-button" data-id="${tour.tourId}">Sửa</button>
                    <button class="btn btn-danger delete-button" data-id="${tour.tourId}">Xóa</button>
                </td>
            </tr>`;

            tourList.append(tourRow);
        });
    }


    function updatePaginationButtons(page, hasMoreData) {
        $('#page-number').text(`Trang ${page}`);
        currentPage = page;

        $('#prev-page-button').toggle(page > 1);
        $('#next-page-button').toggle(hasMoreData);

        // Nếu trang hiện tại không có tour và là trang cuối, ẩn nút "Trang sau"
        if (!hasMoreData && page > 1) {
            $('#next-page-button').hide();
        }
    }

    // Xử lý sự kiện tìm kiếm
    $('#searchButton').click(function () {
        const searchByName = $('#searchByName').val().trim();
        const searchByType = $('#searchByType').val();

        // Tạo đối tượng tham số tìm kiếm
        const searchParams = {
            name: searchByName,  // Tên tour
            type: searchByType   // Loại tour
        };

        console.log("Search params:", searchParams); // Kiểm tra giá trị tìm kiếm

        currentPage = 1; // Reset về trang 1 khi tìm kiếm
        fetchTours(1, searchParams);  // Gọi API với các tham số tìm kiếm
    });

    // Thêm sự kiện cho phím Enter trong ô tìm kiếm
    $('#searchByName').keypress(function (e) {
        if (e.which == 13) { // 13 là mã phím Enter
            $('#searchButton').click();
        }
    });


    // Xử lý nút phân trang
    $('#prev-page-button').click(function () {
        if (currentPage > 1) {
            const searchParams = {
                name: $('#searchByName').val().trim(),
                type: $('#searchByType').val()
            };
            fetchTours(currentPage - 1, searchParams);
        }
    });

    $('#next-page-button').click(function () {
        const searchParams = {
            name: $('#searchByName').val().trim(),
            type: $('#searchByType').val()
        };
        fetchTours(currentPage + 1, searchParams);
    });

    // Khởi tạo ban đầu
    fetchTours();
});
