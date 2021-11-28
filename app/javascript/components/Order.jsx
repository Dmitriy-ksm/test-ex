var React = require("react");

class Order extends React.Component{
   
    render () {
        const { order, is_cur_order } = this.props;
        return (
        <div>
          <p>
              Order number: {order.id}
          </p>
          <span>
              Items
          </span>
          <table>
          <thead>
              <tr>
                  <th>Name</th>
                  <th>Price</th>
                  <th>Quantity</th>
                  {is_cur_order && 
                    <th></th>
                  }
              </tr>
              </thead>
              <tbody>
              {order.positions && order.positions.map((position) =>
                  (
                  <tr key={position.id}>
                      <td>{position.name}</td>
                      <td>{position.price}</td>
                      <td>{position.quantity}</td>
                      {is_cur_order && 
                        <td>
                            <a data-confirm="Вы уверены что хотите удалить позицию?" rel="nofollow" data-method="delete" href={`/orders/remove?orders_descriptions=${position.id}`}>Удалить</a>
                        </td>
                      }
                  </tr>
                  ))
              }
              </tbody>
          </table>
          <span>Amount: {order.amount}</span>
        </div>
        )
    }
}

module.exports = Order