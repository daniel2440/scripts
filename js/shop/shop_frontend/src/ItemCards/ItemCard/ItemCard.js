import './ItemCard.css'

const ItemCard = ({item, clickHandle}) => {

    return (
        <div className="item-card" key={item._id}>
            <img src={item.imageUrl}
                 alt={item.name}/>
            <div className="description">
                <div>
                    {item.name}
                </div>
                <div>
                    {item.description}
                </div>
                <div>
                    {item.category}
                </div>
            </div>
            <div className="right-side">
                <div>
                    {item.price} zł
                </div>
                <button className="add-to-cart-button" type="button" onClick={() => clickHandle(item)}>
                    Add to cart
                </button>
            </div>
        </div>
    )
};
export default ItemCard;