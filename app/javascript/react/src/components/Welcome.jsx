import * as React from "react"
import * as ReactDOM from "react-dom"

const Welcome = () => {
  return(
    <div className="container">
      <h1>Hello World! Welcome to Rails 7 with ReactJS</h1>
      <p className="lead">This is test description</p>
    </div>
  )
}

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Welcome />, document.getElementById('welcome'))
})

export default Welcome