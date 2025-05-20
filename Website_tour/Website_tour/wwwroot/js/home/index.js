// Hàm kiểm tra quyền truy cập vào trang
function checkAccess(roleRequired) {
    const token = localStorage.getItem("token");
    if (!token || isTokenExpired(token)) {
        // Nếu không có token hoặc token đã hết hạn
        alert("Bạn cần đăng nhập để truy cập trang này.");
        window.location.href = "/home/index"; // Chuyển hướng về trang index
        return false; // Không cho phép truy cập
    }

    const decodedToken = parseJwt(token);
    const roles = decodedToken['http://schemas.microsoft.com/ws/2008/06/identity/claims/role'];

    // Kiểm tra xem người dùng có vai trò yêu cầu không
    if (Array.isArray(roles) && roles.includes(roleRequired)) {
        return true; // Cho phép truy cập
    } else if (typeof roles === 'string' && roles === roleRequired) {
        return true; // Cho phép truy cập
    } else {
        alert("Bạn không có quyền truy cập trang này.");
        window.location.href = "/home/index"; // Chuyển hướng về trang index
        return false; // Không cho phép truy cập
    }
}

// Sử dụng hàm checkAccess trong các trang admin và manage
document.addEventListener("DOMContentLoaded", function () {
    // Gọi hàm checkAccess với vai trò tương ứng
    if (window.location.pathname === '/admin') {
        checkAccess("Admin");
    } else if (window.location.pathname === '/manage') {
        checkAccess("Manage");
    }
});



$(document).ready(function () {
    loadTours();

    // sự kiện cho nút tìm kiếm
    document.getElementById('searchBtn').addEventListener('click', () => {
        const endPlace = document.getElementById('searchDestination').value;
        const startPlace = document.getElementById('searchDeparture').value;

        // Gọi hàm tìm kiếm với đúng thứ tự tham số
        searchTours(startPlace, endPlace);
    });


    async function loadTours() {
        await loadDomesticTours();
        await loadInternationalTours();
        await loadCombinedTours();
    }

    async function loadDomesticTours() {
        await loadToursOfType(1, '#domesticTours');
    }

    async function loadInternationalTours() {
        await loadToursOfType(2, '#internationalTours');
    }

    async function loadCombinedTours() {
        await loadToursOfType(3, '#combinedTours');
    }

    async function loadToursOfType(tourTypeId, containerId) {
    try {
        const page = 1; // Trang đầu tiên
        const pageSize = 5; // Lấy 5 tour mỗi lần

        // Điều chỉnh URL để thêm điều kiện lấy đúng tourTypeId và giới hạn 5 tour
        const response = await fetch(`https://localhost:44393/api/tour?page=${page}&pageSize=${pageSize}&tourTypeId=${tourTypeId}`);
        const tours = await response.json();

        if (Array.isArray(tours)) {
            // Lọc ra các tour theo loại tour (tourTypeId)
            const filteredTours = tours.filter(tour => tour.tourTypeId === tourTypeId);

            // Thực hiện enrich dữ liệu cho các tour
            const enrichedTours = await Promise.all(filteredTours.map(async tour => {
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
                    return tour; // Trả lại tour gốc nếu có lỗi
                }
            }));

            // Hiển thị các tour đã được enrich lên giao diện
            displayTours(enrichedTours, containerId);
        } else {
            console.error('API did not return a valid array.');
        }
    } catch (error) {
        console.error(`Error when fetching tours of type ${tourTypeId}:`, error);
    }
}





    function displayTours(tours, containerId) {
        const container = document.querySelector(containerId);
        container.innerHTML = '';

        if (tours.length === 0) {
            container.innerHTML = '<p>Không có tour nào được tìm thấy.</p>';
            if (containerId === '#searchResults') {
                $('#searchResultsContainer').hide(); // Ẩn kết quả tìm kiếm
            }
            return;
        }

        const limitedTours = tours.slice(0, 5);
        limitedTours.forEach(tour => {
            const tourCard = createTourCard(tour);
            container.innerHTML += tourCard;
        });

        if (containerId === '#searchResults') {
            $('#searchResultsContainer').show(); // Hiển thị kết quả tìm kiếm
        }
    }



    

    // Hàm tìm kiếm các tour
    async function searchTours(startPlace, endPlace, departure = '', page = 1, pageSize = 10) {
        try {
            // Khởi tạo URL cơ bản
            let url = `https://localhost:44393/api/tour?`;

            // Khởi tạo mảng chứa các tham số
            const params = [];

            // Thêm các tham số vào mảng nếu có giá trị
            if (endPlace && endPlace.trim()) {
                params.push(`endPlace=${encodeURIComponent(endPlace.trim())}`);
            }
            if (startPlace && startPlace.trim()) {
                params.push(`startPlace=${encodeURIComponent(startPlace.trim())}`);
            }
            if (departure && departure.trim()) {
                params.push(`departure=${encodeURIComponent(departure.trim())}`);
            }

            // Thêm các tham số phân trang
            params.push(`page=${page}`);
            params.push(`pageSize=${pageSize}`);

            // Nối các tham số lại để tạo URL cuối cùng
            url += params.join("&");

            console.log("Generated URL:", url);

            // Gửi yêu cầu đến API
            const response = await fetch(url);
            const tours = await response.json();

            if (Array.isArray(tours)) {
                // Tiến hành lọc tour theo điều kiện startPlace, endPlace và departure (nếu cần)
                const filteredTours = tours.filter(tour => {
                    const tourDeparture = tour.departures && tour.departures.length > 0 ? tour.departures[0] : null;
                    const tourStartPlaceMatch = tour.startPlace && startPlace && tour.startPlace.toLowerCase().includes(startPlace.toLowerCase());
                    const tourEndPlaceMatch = tour.endPlace && endPlace && tour.endPlace.toLowerCase().includes(endPlace.toLowerCase());

                    // Kết hợp các điều kiện tìm kiếm
                    const destinationMatch = tourStartPlaceMatch || tourEndPlaceMatch;
                    const departureMatch = !departure || (tourDeparture && tourDeparture.location.toLowerCase().includes(departure.toLowerCase()));

                    return destinationMatch && departureMatch;
                });

                // Lấy thêm thông tin cho các tour đã lọc
                const enrichedTours = await Promise.all(filteredTours.map(async tour => {
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
                        return tour; // Return the original tour in case of error
                    }
                }));

                // Hiển thị kết quả tìm kiếm
                displayTours(enrichedTours, '#searchResults');
            } else {
                console.error('API did not return a valid array.');
            }
        } catch (error) {
            console.error('Error fetching tours for search:', error);
        }
    }




});

// Move createTourCard function outside of the $(document).ready() block
function createTourCard(tour) {
    const tourImage = tour.images && tour.images.find(img => img.tourId === tour.tourId)
        ? tour.images.find(img => img.tourId === tour.tourId).imageUrl
        : '/default.jpg';

    const tourTranslation = tour.translations.find(t => t.tourId === tour.tourId);
    const tourName = tourTranslation ? tourTranslation.name : `Tour ${tour.code}`;

    // Xóa dấu tiếng Việt, thay thế khoảng trắng bằng dấu gạch ngang và các ký tự đặc biệt khác
    const cleanedTourName = tourName
        .normalize("NFD") // Tách dấu
        .replace(/[\u0300-\u036f]/g, "") // Loại bỏ dấu
        .replace(/đ/g, 'd').replace(/Đ/g, 'D') // Thay thế 'đ' và 'Đ'
        .replace(/[^a-zA-Z0-9\s]/g, "") // Loại bỏ ký tự đặc biệt
        .toLowerCase() // Chuyển thành chữ thường
        .replace(/\s+/g, '-'); // Thay khoảng trắng thành dấu gạch ngang


    const encodedTourName = encodeURIComponent(cleanedTourName); // Mã hóa tên tour đã sửa

    const tourDeparture = tour.departures.find(departure => departure.tourId === tour.tourId);

    const tourPrice = tourDeparture && tourDeparture.price
        ? new Intl.NumberFormat('vi-VN').format(tourDeparture.price)
        : 'Liên hệ';

    return `
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
}











