namespace Website_tour_Be.Helpers
{
    public static class UrlHelper
    {
        public static string GetFileNameFromUrl(string url)
        {
            var uri = new Uri(url);
            return uri.Segments.Last();
        }
    }
}
