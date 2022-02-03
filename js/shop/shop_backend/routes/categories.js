const express = require('express')
const router = express.Router()
const Category = require('../models/Category')
//Getting all
router.get('/', async (req,res)=>{
    try{
        const categories = await Category.find();
        res.json(categories)
    }
    catch (err) {
        res.status(500).json({message: err.message})
    }
})
//Getting one
router.get('/:id', (req,res)=>{})
//Creating one
router.post('/', async (req,res)=>{
    const category = new Category({
        name: req.body.name
    })

    try {
        const newCategory= await category.save()
        res.status(201).json(newCategory)
    } catch (err) {
        res.status(400).json({message: err.message})
    }
})
//Updating one
router.patch('/:id', async(req,res)=>{

    if (req.body.name != null) {
        res.category.name=req.body.name
    }
    try {
        const updatedCategory = await res.category.save()
        res.json(updatedCategory)
    }
    catch (err) {
        res.status(400).json({message: err.message})
    }
})
//Deleting one
router.delete('/:id', (req,res)=>{})

module.exports = router;