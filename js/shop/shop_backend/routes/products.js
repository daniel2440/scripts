const express = require('express')
const router = express.Router()
const Product = require('../models/Product')
//Getting all
router.get('/', async (req,res)=>{
    try{
        const filter = Object.keys(req.query).length === 0 ? {} : {category: Object.values(req.query)[0]}
        const products = await Product.find(filter);
        res.json(products)
    }
    catch (err) {
        res.status(500).json({message: err.message})
    }
})
//Getting one
router.get('/:id', async (req,res)=>{
    try{
        const product = await Product.find({_id: req.params['id']});
        res.json(product)
    }
    catch (err) {
        res.status(500).json({message: err.message})
    }
})

//Creating one
router.post('/', async (req,res)=>{
    const product= new Product({
        name: req.body.name,
        description: req.body.description,
        price: req.body.price,
        category: req.body.category,
        imageUrl: req.body.imageUrl
    })

    try {
        const newProduct= await product.save()
        res.status(201).json(newProduct)
    } catch (err) {
        res.status(400).json({message: err.message})
    }
})
//Updating one
router.patch('/:id', (req,res)=>{})
//Deleting one
router.delete('/:id', (req,res)=>{})

module.exports = router;