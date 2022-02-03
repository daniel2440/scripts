const express = require('express')
const router = express.Router()

//Post of payment
function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

router.post('/', async (req, res) => {
    try {
        await sleep(5000);
        res.status(201).json({message: "ok thx"})
    } catch (err) {
        res.status(500).json({message: err.message})
    }
})

module.exports = router;