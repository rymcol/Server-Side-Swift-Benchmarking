// app/index.js

const express = require('express')
const app = express()
const port = 8585
const host = "169.254.237.101"

const indexHandler = require('./indexHandler')
const blogHandler = require('./blogHandler')
const commondHandler = require('./CommonHandler')

/* Serve Static Files */
app.use(express.static('public'));

app.get('/', (request, response) => {
    const header = commondHandler.makeHeader();
	const indexContent = indexHandler.makeIndexContent();
    const footer = commondHandler.makeFooter();
    const page = header + indexContent + footer;

	response.send(page);
})

app.get('/blog', (request, response) => {
    const header = commondHandler.makeHeader();
	const blogContent = blogHandler.makeBlogContent();
    const footer = commondHandler.makeFooter();
    const page = header + blogContent + footer;

	response.send(page);
})

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
