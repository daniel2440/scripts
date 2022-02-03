const mongoose = require('mongoose')

const ProductSchema = new mongoose.Schema({
    name: String,
    description: {
        type: String,
        required: false
    },
    price: {
        type: Number,
        required: true,
        default: 1
    },
    category: {
        type: String,
        required: true
    },
    imageUrl: {
        type: String
    }
})

module.exports = mongoose.model('Product', ProductSchema)