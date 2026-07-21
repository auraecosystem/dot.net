using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BlazorWebAppMovies.Models;

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

    // ⭐ New Additions

    [StringLength(100)]
    public string? Director { get; set; }

    [StringLength(100)]
    public string? Producer { get; set; }

    [Range(0, 300)]
    public int DurationMinutes { get; set; }   // runtime

    [StringLength(10)]
    public string? Rating { get; set; }        // e.g. PG-13, R

    [Url]
    public string? TrailerUrl { get; set; }    // link to trailer

    [StringLength(500)]
    public string? Description { get; set; }   // synopsis

    public bool IsAvailable { get; set; }      // availability flag
}
