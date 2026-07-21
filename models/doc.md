# 📝 1. Seed the Database with Sample Movies

Create a DbInitializer.cs in the Data folder:
```DbInitializer.cs
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
```

Then call it in Program.cs after building the app:

```cs
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    var context = services.GetRequiredService<MovieContext>();
    DbInitializer.Initialize(context);
}
```

---

📝 2. Add Validation Rules

Enhance the Movie model with validation:
```cs
public class Movie
{
    public int Id { get; set; }

    [Required]
    [StringLength(100)]
    public string? Title { get; set; }

    [DataType(DataType.Date)]
    public DateOnly ReleaseDate { get; set; }

    [Required]
    [StringLength(30)]
    public string? Genre { get; set; }

    [Range(1, 100)]
    [DataType(DataType.Currency)]
    [Column(TypeName = "decimal(18, 2)")]
    public decimal Price { get; set; }
}

```
👉 This ensures users can’t enter empty titles or genres, and price stays between 1 and 100.

---

📝 3. Add Search & Filter

```Pages/Movies/Index.cshtml.cs

public IList<Movie> Movie { get; set; } = default!;

[BindProperty(SupportsGet = true)]
public string? SearchString { get; set; }

public async Task OnGetAsync()
{
    var movies = from m in _context.Movies
                 select m;

    if (!string.IsNullOrEmpty(SearchString))
    {
        movies = movies.Where(s => s.Title!.Contains(SearchString));
    }

    Movie = await movies.ToListAsync();
}


And in Index.cshtml add:

<form method="get">
    <p>
        Title: <input type="text" name="SearchString" />
        <input type="submit" value="Search" />
    </p>
</form>
```

---

📝 4. Add Sorting

Extend the query to allow sorting by title or release date:
```cs
public string TitleSort { get; set; }
public string DateSort { get; set; }

public async Task OnGetAsync(string sortOrder)
{
    TitleSort = String.IsNullOrEmpty(sortOrder) ? "title_desc" : "";
    DateSort = sortOrder == "Date" ? "date_desc" : "Date";

    var movies = from m in _context.Movies select m;

    switch (sortOrder)
    {
        case "title_desc":
            movies = movies.OrderByDescending(s => s.Title);
            break;
        case "Date":
            movies = movies.OrderBy(s => s.ReleaseDate);
            break;
        case "date_desc":
            movies = movies.OrderByDescending(s => s.ReleaseDate);
            break;
        default:
            movies = movies.OrderBy(s => s.Title);
            break;
    }

    Movie = await movies.AsNoTracking().ToListAsync();
}

```
---
