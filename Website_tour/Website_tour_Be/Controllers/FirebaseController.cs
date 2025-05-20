/*using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Website_tour_Be.repositories;

namespace Website_tour_Be.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class FirebaseController : ControllerBase
    {
        private readonly IFirebaseRepository _firebaseRepository;

        public FirebaseController(IFirebaseRepository firebaseRepository)
        {
            _firebaseRepository = firebaseRepository;
        }

        [HttpPost("upload")]
        public async Task<IActionResult> UploadFile(IFormFile file, [FromQuery] string fileName, [FromQuery] string folderName)
        {
            if (file == null || file.Length == 0)
                return BadRequest("File is empty");

            var fileUrl = await _firebaseRepository.UploadFileToFirebaseStorage(file, fileName, folderName);
            if (fileUrl == null)
                return BadRequest("Upload failed");

            return Ok(new { FileUrl = fileUrl });
        }

        [HttpDelete("delete")]
        public async Task<IActionResult> DeleteFile([FromQuery] string fileName, [FromQuery] string folderName)
        {
            try
            {
                await _firebaseRepository.DeleteFileFromFirebaseStorage(fileName, folderName);
                return Ok("File deleted successfully");
            }
            catch (Exception ex)
            {
                Console.WriteLine($"FileName: {fileName}, FolderName: {folderName}, Error: {ex.Message}");
                return BadRequest($"Delete failed: {ex.Message}");
            }
        }

        [HttpGet("download")]
        public async Task<IActionResult> GetDownloadUrl([FromQuery] string fileName, [FromQuery] string folderName)
        {
            var downloadUrl = await _firebaseRepository.DownloadFileFromFirebaseStorage(fileName, folderName);
            if (downloadUrl == null)
                return NotFound("File not found");

            return Ok(new { DownloadUrl = downloadUrl });
        }

        [HttpGet("metadata")]
        public async Task<IActionResult> GetMetadata([FromQuery] string fileName, [FromQuery] string folderName)
        {
            var metadata = await _firebaseRepository.GetMetadataFileFromFirebaseStorage(fileName, folderName);
            if (metadata == null)
                return NotFound("File not found or metadata not available");

            return Ok(metadata);
        }
    }
}
*/