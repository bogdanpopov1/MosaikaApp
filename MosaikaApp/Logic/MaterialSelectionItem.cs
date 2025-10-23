using MosaikaApp.Models;
using ReactiveUI;
using ReactiveUI.Fody.Helpers;

namespace MosaikaApp.Logic;
public class MaterialSelectionItem : ReactiveObject
{
    public Material Material { get; set; }

    [Reactive]
    public decimal? Quantity { get; set; }

    public MaterialSelectionItem(Material material, int quantity = 0)
    {
        Material = material;
        Quantity = quantity;
    }
}