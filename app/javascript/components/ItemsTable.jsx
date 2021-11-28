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
      <table>
      <thead>
      <tr>
        <th>Name</th>
        <th>Price</th>
        <th></th>
      </tr>
      </thead>
      <tbody>
        {items && items.map((item,index)=>
        (
          <tr key={index}>
            <td>
              <a href={`/items/${item.id}`}>{item.name}</a>
            </td>
            <td>
              {item.price}
            </td>
            <td>
              <form action={`/items/${item.id}/buy`} acceptCharset="UTF-8" method="post" onSubmit={this.handleSubmit}>
                <input min="1" step="1" defaultValue="1" type="number" name="item[count]" />
                <input type="submit" name="commit" defaultValue="Купить" data-disable-with="Купить" />
              </form>
              <a href={`/items/${item.id}/edit`}>Редактировать</a>
              <a data-confirm="Вы уверены что хотите удалить этот товар?" rel="nofollow" data-method="delete" href={`/items/${item.id}`}>Удалить</a>
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
