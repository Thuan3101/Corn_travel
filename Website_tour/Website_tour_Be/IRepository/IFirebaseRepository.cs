﻿using Firebase.Storage;

namespace Website_tour_Be.IRepository
{
    public interface IFirebaseRepository
    {
        /// <summary>
        /// Upload file len firebase storage, cung co the thay the file cung duong dan va ten
        /// </summary>
        /// <returns>tra ve url file</returns>
        Task<string?> UploadFileToFirebaseStorage(IFormFile files, string fileName, string folderName);

        /// <summary>
        /// Xoa file tren firebase
        /// </summary>
        Task DeleteFileFromFirebaseStorage(string fileName, string folderName);

        /// <summary>
        /// lay url download file tu firebase
        /// </summary>
        /// <returns>lay url download file tu firebase</returns>
        Task<string?> DownloadFileFromFirebaseStorage(string fileName, string folderName);

        /// <summary>
        /// lay thong tin file tu firebase
        /// </summary>
        /// <returns>tra ve object FirebaseMetaData chua cac thong tin file</returns>
        Task<FirebaseMetaData?> GetMetadataFileFromFirebaseStorage(string fileName, string folderName);
    }
}

