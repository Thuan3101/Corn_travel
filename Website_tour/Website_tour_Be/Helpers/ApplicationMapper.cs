using AutoMapper;
using Website_tour_Be.Data;
using Website_tour_Be.Models;

namespace Website_tour_Be.Helpers
{
    public class ApplicationMapper : Profile
    {
        public ApplicationMapper()
        {
            /*// Ánh xạ từ TourModel sang Tour
            CreateMap<TourModel, Tour>()
                .ForMember(dest => dest.TourImages, opt => opt.MapFrom(src => src.TourImages));

            // Ánh xạ từ Tour sang TourModel
            CreateMap<Tour, TourModel>()
                .ForMember(dest => dest.TourImages, opt => opt.MapFrom(src => src.TourImages));*/

            /*CreateMap<TourModel, Tour>()
            .ForMember(dest => dest.TourImages, opt => opt.MapFrom(src => src.TourImages))
            .ReverseMap()
            .ForMember(dest => dest.TourImages, opt => opt.MapFrom(src => src.TourImages));*/


            CreateMap<TourModel, Tour>().ReverseMap();

            // Ánh xạ từ TourImageModel sang TourImage
            CreateMap<TourImageModel, TourImage>().ReverseMap();
            CreateMap<TourTypeModel, TourType>().ReverseMap();

            CreateMap<TourTranslationModel, TourTranslation>().ReverseMap();


            CreateMap<TourItineraryModel, TourItinerary>().ReverseMap();
            CreateMap<TourDepartureModel, TourDeparture>().ReverseMap();
        }
    }
}
