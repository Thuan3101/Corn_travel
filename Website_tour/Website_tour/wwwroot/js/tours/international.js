$(document).ready(function () {
    const tourTypeId = 2;
    let allTours = [];
    let currentIndex = 0;
    loadInternationalTours();

    async function loadInternationalTours(page = 1, pageSize = 2) {
        try {
            // Gọi API nhiều lần cho đến khi không còn dữ liệu
            while (true) {
                const response = await fetch(`https://localhost:44393/api/tour?page=${page}&pageSize=${pageSize}`);
                const tours = await response.json();

                // Kiểm tra nếu dữ liệu trả về là mảng và có phần tử
                if (Array.isArray(tours) && tours.length > 0) {
                    allTours.push(...tours);  // Thêm dữ liệu mới vào mảng allTours
                    page++;  // Tăng số trang để lấy trang tiếp theo
                } else {
                    break;  // Thoát vòng lặp khi không còn dữ liệu
                }
            }

            console.log('All Tours:', allTours);

            // Lọc các tour có tourTypeId 
            const filteredTours = allTours.filter(tour => Number(tour.tourTypeId) === tourTypeId);
            console.log('Filtered Tours:', filteredTours);

            if (filteredTours.length > 0) {
                // Xử lý dữ liệu bổ sung và hiển thị các tour đã lọc
                allTours = await Promise.all(filteredTours.map(async tour => {
                    try {
                        const departureResponse = await fetch(`https://localhost:44393/api/tour-departure?tourId=${tour.tourId}`);
                        const departures = await departureResponse.json();

                        const imageResponse = await fetch(`https://localhost:44393/api/tour-image?tourId=${tour.tourId}`);
                        const images = await imageResponse.json();

                        const itineraryResponse = await fetch(`https://localhost:44393/api/tour-itinerary?tourId=${tour.tourId}`);
                        const itineraries = await itineraryResponse.json();

                        const translationResponse = await fetch(`https://localhost:44393/api/tour-translation?tourId=${tour.tourId}`);
                        const translations = await translationResponse.json();

                        return {
                            ...tour,
                            departures,
                            images,
                            itineraries,
                            translations
                        };
                    } catch (error) {
                        console.error(`Error fetching data for tourId ${tour.tourId}:`, error);
                        return tour; // Trả về tour gốc nếu có lỗi
                    }
                }));

                displayTours(); // Hiển thị 5 tour đầu tiên
            } else {
                console.log('Không có tour nào với tourTypeId = 3.');
                $('#internationalTours').append('<p>Không có tour nào thuộc loại này.</p>');
            }
        } catch (error) {
            console.error('Lỗi khi lấy tour:', error);
        }
    }

    function displayTours() {
        const container = $('#internationalTours');

        if (allTours.length === 0) {
            container.append('<p>Không có tour nào được tìm thấy.</p>');
            return;
        }

        // Lấy 5 tour tiếp theo để hiển thị
        const limitedTours = allTours.slice(currentIndex, currentIndex + 2);
        currentIndex += 2; // Cập nhật chỉ mục cho các tour tiếp theo

        limitedTours.forEach(tour => {
            const tourImage = tour.images && tour.images[0] ? tour.images[0].imageUrl : '/default.jpg';
            const tourTranslation = tour.translations.find(t => t.tourId === tour.tourId);
            const tourName = tourTranslation ? tourTranslation.name : `Tour ${tour.code}`;
            const tourDeparture = tour.departures.find(departure => departure.tourId === tour.tourId);
            const tourPrice = tourDeparture && tourDeparture.price ? new Intl.NumberFormat('vi-VN').format(tourDeparture.price) : 'Liên hệ';

            // Xóa dấu tiếng Việt, thay thế khoảng trắng bằng dấu gạch ngang và các ký tự đặc biệt khác
            const cleanedTourName = tourName
                .normalize("NFD") // Tách dấu
                .replace(/[\u0300-\u036f]/g, "") // Loại bỏ dấu
                .replace(/đ/g, 'd').replace(/Đ/g, 'D') // Thay thế 'đ' và 'Đ'
                .replace(/[^a-zA-Z0-9\s]/g, "") // Loại bỏ ký tự đặc biệt
                .toLowerCase() // Chuyển thành chữ thường
                .replace(/\s+/g, '-'); // Thay khoảng trắng thành dấu gạch ngang


            const encodedTourName = encodeURIComponent(cleanedTourName); // Mã hóa tên tour đã sửa

            const tourCard = `
                <div class="tour-card">
                    <img src="${tourImage}" alt="${tourName}" class="tour-image">
                    <div class="tour-info">
                        <h3 class="tour-name">${tourName}</h3>
                        <p class="tour-code">Mã tour: ${tour.code}</p>
                        <p class="tour-route">${tour.startPlace} - ${tour.endPlace}</p>
                        <p class="tour-price">Giá: ${tourPrice} VNĐ</p>
                    </div>
                    <div class="tour-actions">
                        <a href="/tours/tourdetail?${encodedTourName}&id=${tour.tourId}" class="view-details">Xem chi tiết</a>
                        <a href="#" class="book" onclick="bookTour(${tour.tourId})">Đặt ngay</a>
                    </div>
                </div>`;

            container.append(tourCard);
        });

        // Nếu đã tải hết tất cả các tour, ẩn nút "Xem thêm"
        if (currentIndex >= allTours.length) {
            $('#seeMoreButton').hide();
        }
    }

    // Thêm sự kiện cho nút "Xem thêm"
    $('#seeMoreButton').click(function () {
        displayTours(); // Tải 5 tour tiếp theo khi người dùng nhấn nút
    });
});
