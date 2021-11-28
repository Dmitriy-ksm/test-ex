var React = require("react");

class ItemsTable extends React.Component{

  handleSubmit = (e) => {
    e.preventDefault();
    const token = document.querySelector('[name=csrf-token]').content;
    var formData = new FormData(e.target);
    fetch(e.target.action, {
      method: 'POST',
      headers: {
        'X-CSRF-TOKEN': token
      },
      redirect: 'follow',
      body: formData
    })
      .then(resp => window.location = resp.url)
      .catch(error => console.log(error));
  }

  render () {
    const { items } = this.props;
    return (
      <table className="item-table">
        <thead>
          <tr>
            <th className="item-table-header-name">Name</th>
            <th className="item-table-header-price">Price</th>
            <th className="item-table-header-utils"></th>
          </tr>
        </thead>
        <tbody>
          {items && items.map((item,index)=>
          (
            <tr key={index}>
              <td className="item-table-name">
                <a href={`/items/${item.id}`}>{item.name}</a>
              </td>
              <td className="item-table-price">
                {item.price}
              </td>
              <td className="item-table-utils">
                <form className="item-table-buy-form" action={`/items/${item.id}/buy`} acceptCharset="UTF-8" method="post" onSubmit={this.handleSubmit}>
                  <input className="item-table-count-form" min="1" step="1" defaultValue="1" type="number" name="item[count]" />
                  <input className="item-table-submit-form" type="submit" name="commit" value="Купить" data-disable-with="Обрабатывается" />
                </form>
                <a className="item-table-link-to-edit" href={`/items/${item.id}/edit`}>Редактировать</a>
                <a className="item-table-link-to-delete" data-confirm="Вы уверены что хотите удалить этот товар?" rel="nofollow" data-method="delete" href={`/items/${item.id}`}>Удалить</a>
              </td>
            </tr>
          )
          )}
        </tbody>
      </table>
    )
}
}

module.exports = ItemsTable
