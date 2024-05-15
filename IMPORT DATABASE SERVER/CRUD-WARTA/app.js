const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const conn = require('./config/db');

// Middleware for parsing JSON bodies
app.use(bodyParser.json());

// API Read
app.get('/warta', function (req, res) {
    const queryStr = "SELECT * FROM warta";
    conn.query(queryStr, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({
                "success": false,
                "message": "Failed to retrieve data",
                "error": err.message
            });
        } else {
            res.status(200).json({
                "success": true,
                "message": "Success retrieving data",
                "data": results
            });
        }
    });
});


// API Read
app.get('/warta/home', function (req, res) {
    const queryStr = "SELECT * FROM warta ORDER BY id_warta DESC";
    conn.query(queryStr, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({
                "success": false,
                "message": "Failed to retrieve data",
                "error": err.message
            });
        } else {
            res.status(200).json({
                "success": true,
                "message": "Success retrieving data",
                "data": results
            });
        }
    });
});




// API Create
app.post('/warta/create', function (req, res) {
    const param = req.body;
    const warta = param.warta;

    const queryStr = "INSERT INTO warta (warta) VALUES (?)";
    const values = [warta];

    conn.query(queryStr, values, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({
                "success": false,
                "message": "Failed to save data",
                "error": err.message
            });
        } else {
            res.status(200).json({
                "success": true,
                "message": "Success saving data",
                "data": results
            });
        }
    });
});

// API Edit
app.put('/warta/:id', function (req, res) {
    const id = req.params.id;
    const param = req.body;
    const warta = param.warta;

    // Validate if 'warta' parameter is not null
    if (!warta) {
        return res.status(400).json({
            "success": false,
            "message": "Parameter 'warta' cannot be null"
        });
    }

    const queryStr = "UPDATE warta SET warta = ? WHERE id_warta = ?";
    const values = [warta, id];

    conn.query(queryStr, values, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({
                "success": false,
                "message": "Failed to edit data",
                "error": err.message
            });
        } else {
            res.status(200).json({
                "success": true,
                "message": "Success editing data",
                "data": results
            });
        }
    });
});

// API Get Warta by ID
app.get('/Warta/:id', function (req, res) {
    const id = req.params.id;

    const queryStr = "SELECT * FROM warta WHERE id_warta = ?";
    const values = [id];

    conn.query(queryStr, values, (err, results) => {
        if (err) {
            console.log(err);
            res.status(500).json({
                "success": false,
                "message": "Failed to retrieve warta",
                "error": err.message
            });
        } else {
            if (results.length === 0) {
                res.status(404).json({
                    "success": false,
                    "message": "Warta not found"
                });
            } else {
                res.status(200).json({
                    "success": true,
                    "message": "Success retrieving warta",
                    "data": results[0] // Assuming only one warta should be returned
                });
            }
        }
    });
});

// Start the server
const PORT = process.env.PORT || 2005;
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});
