var React = require("react");

class Items extends React.Component{
   state = {
       name: this.props.item.name,
       price: this.props.item.price,
       description: this.props.item.description,
   }
    render () {
        const { name, price, description } = this.state;
        return (
        <div>
             <p>
                <label for="item_name">Название:</label>
                <input type="text" value={name} name="item[name]" id="item_name" onChange={(e)=>this.setState({name: e.target.value})} />
            </p>
            <p>
                <label for="item_price">Цена:</label>
                <input type="text" value={price} name="item[price]" id="item_price" onChange={(e)=>this.setState({price: e.target.value})}/>
            </p>
            <p>
                <label for="item_description">Описание:</label>
                <textarea name="item[description]" id="item_description" onChange={(e)=>this.setState({description: e.target.value})}>
                {description}
                </textarea>
            </p>
        </div>
        )
    }
}

module.exports = Items