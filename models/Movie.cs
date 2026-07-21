using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace lmlmWebmovie.Models;

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

    // ⭐ Extra fields
    [StringLength(100)]
    public string? Director { get; set; }

    [StringLength(100)]
    public string? Producer { get; set; }

    [Range(0, 300)]
    public int DurationMinutes { get; set; }

    [StringLength(10)]
    public string? Rating { get; set; }

    [Url]
    public string? TrailerUrl { get; set; }

    [StringLength(500)]
    public string? Description { get; set; }

    public bool IsAvailable { get; set; }

    [Url]
    public string? PosterUrl { get; set; }   // 🎬 New: poster image
}
