using Firebase.Storage;
using Microsoft.Extensions.Options;
using Website_tour_Be.IRepository;
using Website_tour_Be.Models;

namespace Website_tour_Be.repositories
{
    public class FirebaseRepository : IFirebaseRepository
    {
        private readonly FirebaseConfigurationModel _firebaseConfiguration;

        public FirebaseRepository(IOptions<FirebaseConfigurationModel> config)
        {
            _firebaseConfiguration = config.Value;
        }

        public async Task<string?> UploadFileToFirebaseStorage(IFormFile files, string fileName, string folderName)
        {
            if (files.Length > 0)
            {
                try
                {
                    var task = new FirebaseStorage(
                        _firebaseConfiguration.Bucket
                        )
                        .Child(folderName) // Chỉ định folder chứa file
                        .Child($"{fileName}.{Path.GetExtension(files.FileName).Substring(1)}") // Đặt tên file
                        .PutAsync(files.OpenReadStream());

                    string? urlFile = await task;
                    return urlFile; // Trả về URL của file đã upload
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.Message);
                }
            }
            return null;
        }


        public async Task DeleteFileFromFirebaseStorage(string fileName, string folderName)
        {
            try
            {
                // Mã hóa tên file để đảm bảo các ký tự đặc biệt được xử lý đúng
                string encodedFileName = Uri.EscapeDataString(fileName);

                var task = new FirebaseStorage(
                    _firebaseConfiguration.Bucket,
                    new FirebaseStorageOptions
                    {
                        ThrowOnCancel = true
                    })
                    .Child(folderName) // Chỉ định thư mục
                    .Child(encodedFileName) // Sử dụng tên file đã mã hóa
                    .DeleteAsync(); // Xóa file

                await task; // Chờ cho việc xóa hoàn thành
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }


        public async Task<string?> DownloadFileFromFirebaseStorage(string fileName, string folderName)
        {
            try
            {
                var task = new FirebaseStorage(
                    _firebaseConfiguration.Bucket,
                    new FirebaseStorageOptions
                    {
                        ThrowOnCancel = true
                    })
                    .Child(folderName) // Chỉ định folder
                    .Child(fileName) // Chỉ định file
                    .GetDownloadUrlAsync(); // Lấy URL tải về

                var downloadUrl = await task;
                return downloadUrl; // Trả về URL tải về
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        public async Task<FirebaseMetaData?> GetMetadataFileFromFirebaseStorage(string fileName, string folderName)
        {
            try
            {
                var task = new FirebaseStorage(
                    _firebaseConfiguration.Bucket,
                    new FirebaseStorageOptions
                    {
                        ThrowOnCancel = true
                    })
                    .Child(folderName) // Chỉ định folder
                    .Child(fileName) // Chỉ định file
                    .GetMetaDataAsync(); // Lấy metadata của file

                var metadata = await task;
                return metadata; // Trả về metadata
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }
    }
}
