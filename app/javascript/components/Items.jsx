var React = require("react");

class Items extends React.Component{
   state = {
       name: this.props.item.name,
       price: this.props.item.price,
       description: this.props.item.description,
   }

    handlePriceNumberAndEmptyChange = (e)=>
   {
       const value = e.target.value;
       if(!isNaN(value))
       {
            this.setState({price: value})
       }
   };

    render () {
        const { name, price, description } = this.state;
        return (
        <div className="item-edit">
             <div className="item-edit-name">
                <label htmlFor="item_name">Название:</label>
                <input type="text" value={name} name="item[name]" id="item_name" onChange={(e)=>this.setState({name: e.target.value})} />
            </div>
            <div className="item-edit-price">
                <label htmlFor="item_price">Цена:</label>
                <input type="text" value={price} name="item[price]" id="item_price" onChange={this.handlePriceNumberAndEmptyChange}/>
            </div>
            <div className="item-edit-description">
                <label htmlFor="item_description">Описание:</label>
                <textarea name="item[description]" value={description} id="item_description" onChange={(e)=>this.setState({description: e.target.value})} />
            </div>
        </div>
        )
    }
}

module.exports = Items