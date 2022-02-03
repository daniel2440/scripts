const express = require('express')
const app = express()
const mongoose = require('mongoose')
const cors = require('cors')
app.use(cors())
mongoose.connect('mongodb://localhost/products', {useNewUrlParser: true}, () => console.log('DB is up'))
const db = mongoose.connection
db.on('error', (error) => console.log(error))

app.use(express.json())

const productsRouter = require('./routes/products')
const categoriesRouter = require('./routes/categories')
const paymentsRouter = require('./routes/payments')
app.use('/products', productsRouter)
app.use('/categories', categoriesRouter)
app.use('/payments', paymentsRouter)

app.listen(3001, () => console.log('Server is Up'))

