const express = require('express');
const hbs = require('hbs');
const wax = require('wax-on');
const mysql = require('mysql2/promise');
const helpers = require('handelbars-helpers')({
    'handlebars': hbs.handlebars
})

const app = express();

// SETUP EXPRESS
app.use(express.static('public'));
app.set('view engine', 'hbs');
app.use(express.urlencoded({
    'extended': false
}));

// setup wax-on for template inheritance
wax.on(hbs.handlebars);
wax.setLayoutPath('./views/layouts')

// ROUTES


// START SERVER
app.listen(3000, ()=>{
    console.log("Server has started")
})