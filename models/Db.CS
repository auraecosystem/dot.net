using BlazorWebAppMovies.Models;

namespace BlazorWebAppMovies.Data;

public static class DbInitializer
{
    public static void Initialize(MovieContext context)
    {
        if (context.Movies.Any())
        {
            return; // DB already seeded
        }

        var movies = new Movie[]
        {
            new Movie{Title="The Matrix", ReleaseDate=new DateOnly(1999,3,31), Genre="Sci-Fi", Price=9.99M},
            new Movie{Title="Inception", ReleaseDate=new DateOnly(2010,7,16), Genre="Sci-Fi", Price=12.99M},
            new Movie{Title="Interstellar", ReleaseDate=new DateOnly(2014,11,7), Genre="Sci-Fi", Price=14.99M},
            new Movie{Title="The Dark Knight", ReleaseDate=new DateOnly(2008,7,18), Genre="Action", Price=10.99M}
        };

        context.Movies.AddRange(movies);
        context.SaveChanges();
    }
}
