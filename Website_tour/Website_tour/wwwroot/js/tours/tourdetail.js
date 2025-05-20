$(document).ready(function () {
    const urlParams = new URLSearchParams(window.location.search);
    const tourId = urlParams.get('id');

    if (tourId) {
        loadTourDetails(tourId);
    }

    async function loadTourDetails(tourId) {
        try {
            const [tourResponse, departureResponse, imageResponse, itineraryResponse, translationResponse] = await Promise.all([
                fetch(`https://localhost:44393/api/tour/${tourId}`),
                fetch(`https://localhost:44393/api/tour-departure/${tourId}`),
                fetch(`https://localhost:44393/api/tour-image/${tourId}`),
                fetch(`https://localhost:44393/api/tour-itinerary/${tourId}`),
                fetch(`https://localhost:44393/api/tour-translation/${tourId}`)
            ]);

            const tour = await tourResponse.json();
            const departures = await departureResponse.json();
            const images = await imageResponse.json();
            const itineraries = await itineraryResponse.json();
            const translation = await translationResponse.json();

            displayTourDetails(tour, departures, images, itineraries, translation);
        } catch (error) {
            console.error('Error loading tour details:', error);
            $('#tourDetail').html('<p>Đã có lỗi xảy ra khi tải thông tin tour. Vui lòng thử lại sau.</p>');
        }
    }

    function displayTourDetails(tour, departures, images, itineraries, translation) {
        $('.tour-title').text(translation.name);
        $('.tour-code').text(`Mã tour: ${tour.code}`);
        $('.route-text').text(`${tour.startPlace} - ${tour.endPlace}`);
        $('.description-text').text(translation.description);
        $('.highlights-text').text(translation.highlights);
        $('.includes-text').text(translation.includes);
        $('.excludes-text').text(translation.excludes);
        $('.notes-text').text(translation.notes);

        /*const departureOptions = Array.isArray(departures)
            ? departures.map(dep => `<option value="${dep.departureId}">
            ${new Date(dep.departureDate).toLocaleDateString('vi-VN')} 
            - ${new Intl.NumberFormat('vi-VN').format(dep.price)} VNĐ</option>`).join('')
            : `<option value="${departures.departureId}">
            ${new Date(departures.departureDate).toLocaleDateString('vi-VN')} 
            - ${new Intl.NumberFormat('vi-VN').format(departures.price)} VNĐ</option>`;
        $('#departureSelect').html(departureOptions);*/

        let imageGallery = '';

        if (Array.isArray(images)) {
            images.forEach((img, index) => {
                imageGallery += `
                    <img src="${img.imageUrl || ''}" alt="${img.caption || ''}" class="thumbnail" data-index="${index}">
                `;
            });
        }

        $('.thumbnail-container').html(imageGallery);
        $('.main-image').attr('src', images[0]?.imageUrl || '');

        let currentIndex = 0;

        $('.prev-button').click(function () {
            currentIndex = (currentIndex - 1 + images.length) % images.length;
            updateMainImage();
        });

        $('.next-button').click(function () {
            currentIndex = (currentIndex + 1) % images.length;
            updateMainImage();
        });

        function updateMainImage() {
            $('.main-image').attr('src', images[currentIndex]?.imageUrl || '');

            // Update thumbnail styles
            $('.thumbnail').each(function (index) {
                if (index === currentIndex) {
                    $(this).addClass('active-thumbnail');
                } else {
                    $(this).removeClass('active-thumbnail');
                }
            });
        }

        setInterval(function () {
            currentIndex = (currentIndex + 1) % images.length;
            updateMainImage();
        }, 3000); //thời gian lướt 
    

        const itineraryHtml = Array.isArray(itineraries)
            ? itineraries.map(day => `<div class="day-item"><details>
  <summary class="day-title">${day.title}</summary>
  <p>${day.description}</p><p><strong>Điểm đến:</strong> ${day.destinations}</p>
            <p><strong>Hoạt động:</strong> ${day.activities}</p><p><strong>Bữa ăn:</strong> ${day.mealInclusions}</p>
            <p><strong>Lưu trú:</strong> ${day.accommodation}</p></div>`).join('')
            : `<div class="day-item"><h3 class="day-title">${itineraries.title}</h3><p>${itineraries.description}</p>
            <p><strong>Điểm đến:</strong> ${itineraries.destinations}</p><p><strong>Hoạt động:</strong> ${itineraries.activities}</p>
            <p><strong>Bữa ăn:</strong> ${itineraries.mealInclusions}</p><p><strong>Lưu trú:</strong> ${itineraries.accommodation}</p>
</details>
            
            </div>`;
            $('.itinerary-list').html(itineraryHtml);

        // Hiển thị giá tour cho người lớn và trẻ em
        $('.price-value').text(new Intl.NumberFormat('vi-VN').format(departures.price));
        $('.child-price-value').text(new Intl.NumberFormat('vi-VN').format(departures.childPrice));

        // Hiển thị số chỗ còn lại
        $('.seats-available-value').text(departures.availableSeats);

        // Hiển thị lựa chọn ngày khởi hành cùng với giá và số chỗ còn lại
        const departureOptions = Array.isArray(departures)
            ? departures.map(dep => `
        <option value="${dep.departureId}">
            ${new Date(dep.departureDate).toLocaleDateString('vi-VN')} 
            - ${new Intl.NumberFormat('vi-VN').format(dep.price)} VNĐ
        </option>`).join('')
                    : `<option value="${departures.departureId}">
        ${new Date(departures.departureDate).toLocaleDateString('vi-VN')} 
        - ${new Intl.NumberFormat('vi-VN').format(departures.price)} VNĐ
        </option>`;

        $('#departureSelect').html(departureOptions);

        // Cập nhật giá trị số lượng vé khi người dùng thay đổi
        $('#ticketQuantity').on('input', function () {
            const quantity = $(this).val();
            const totalPrice = departures.price * quantity; // Tổng giá cho người lớn
            $('.total-price').text(`Tổng giá: ${new Intl.NumberFormat('vi-VN').format(totalPrice)} VNĐ`);
        });




            $('.book-button').click(function () {
                bookTour(tour.tourId);
            });
    }

    function bookTour(tourId) {
        const departureId = $('#departureSelect').val();
        window.location.href = `/booking?tourid=${tourId}&departureid=${departureId}`;
    }
});


