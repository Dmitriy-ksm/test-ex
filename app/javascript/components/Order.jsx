var React = require("react");

class Order extends React.Component{
   
    render () {
        const { order, is_cur_order } = this.props;
        return (
        <div className="order-container">
          <div className="order-header">
              Order number: {order.id}
          </div>
          <span className="position-header">
              Items
          </span>
          <table className="position-table">
          <thead>
              <tr>
                  <th className="position-table-header-name">Name</th>
                  <th className="position-table-header-price">Price</th>
                  <th className="position-table-header-quantity">Quantity</th>
                  {is_cur_order && 
                    <th className="position-table-header-utils"></th>
                  }
              </tr>
              </thead>
              <tbody>
              {order.positions && order.positions.map((position) =>
                  (
                  <tr key={position.id}>
                      <td className="position-table-name">{position.name}</td>
                      <td className="position-table-price">{position.price}</td>
                      <td className="position-table-quantity">{position.quantity}</td>
                      {is_cur_order && 
                        <td className="position-table-utils">
                            <a className="position-table-link-to-delete" data-confirm="Вы уверены что хотите удалить позицию?" rel="nofollow" data-method="delete" href={`/orders/remove?orders_descriptions=${position.id}`}>Удалить</a>
                        </td>
                      }
                  </tr>
                  ))
              }
              </tbody>
          </table>
          <span className="order-amount">Amount: {order.amount}</span>
        </div>
        )
    }
}

module.exports = Order