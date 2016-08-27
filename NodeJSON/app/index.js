// app/index.js

const express = require('express')
const app = express()
const port = 8585
const host = "169.254.237.101"

const commondHandler = require('./CommonHandler')

/* Serve Static Files */
app.use(express.static('public'));

app.get('/json', (request, response) => {
	const jsonData = commondHandler.makeJSON();
	response.setHeader('Content-Type', 'application/json');
	response.send(JSON.stringify(jsonData))
})

app.listen(port, host, (err) => {
  if (err) {
    return console.log('something bad happened', err)
  }

  console.log(`server is listening on ${host}:${port}`)
})
