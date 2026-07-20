---
page: asp.net
---
🔹 Step 1: Install a GraphQL Client
```bash
# In Blazor, you can use GraphQL.Client (NuGet package) to send queries/mutations.

dotnet add package GraphQL.Client
dotnet add package GraphQL.Client.Serializer.Newtonsoft
```

---

🔹 Step 2: Configure the GraphQL Client

Add this to your 

```Program.cs
builder.Services.AddSingleton(s =>
    new GraphQL.Client.GraphQLClient(new GraphQL.Client.Http.GraphQLHttpClientOptions
    {
        EndPoint = new Uri("http://localhost:5000/graphql")
    }, new GraphQL.Client.Serializer.Newtonsoft.NewtonsoftJsonSerializer()));
```

This registers a GraphQL client pointing to your local endpoint.

---

🔹 Step 3: Create a Service for Queries

Make a 

```MovieService.cs
using GraphQL;
using GraphQL.Client.Abstractions;

public class MovieService
{
    private readonly IGraphQLClient _client;

    public MovieService(IGraphQLClient client)
    {
        _client = client;
    }

    public async Task<List<Movie>> GetMoviesAsync()
    {
        var request = new GraphQLRequest
        {
            Query = @"
                query {
                  movies {
                    id
                    title
                    releaseDate
                    genre
                    rating
                  }
                }"
        };

        var response = await _client.SendQueryAsync<ResponseData>(request);
        return response.Data.Movies;
    }
}

public class ResponseData
{
    public List<Movie> Movies { get; set; }
}

public class Movie
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string ReleaseDate { get; set; }
    public string Genre { get; set; }
    public int Rating { get; set; }
}
```

---

🔹 Step 4: Inject Service into Blazor Component



```Pages/Movies.razor
@page "/movies"
@inject MovieService MovieService

<h3>Movie List</h3>

@if (movies == null)
{
    <p>Loading...</p>
}
else
{
    <ul>
        @foreach (var movie in movies)
        {
            <li>@movie.Title (@movie.ReleaseDate) - @movie.Genre - Rating: @movie.Rating</li>
        }
    </ul>
}

@code {
    private List<Movie> movies;

    protected override async Task OnInitializedAsync()
    {
        movies = await MovieService.GetMoviesAsync();
    }
}
```

---

 [What Happens]
 
* - When you navigate to /movies, Blazor calls MovieService
  * - MovieService sends a GraphQL query to your backend (Db.gql).
* - The GraphQL endpoint returns JSON data.
* - (.Blazor) renders the movie list dynamically in the UI.


---
 full pipeline
 — GraphQL schema (`Db.gql`) → ASP.NET Core GraphQL endpoint → Blazor service → Razor component → rendered UI.

