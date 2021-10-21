const express = require('express');
const hbs = require('hbs');
const wax = require('wax-on');
const mysql = require('mysql2/promise');
const helpers = require('handlebars-helpers')({
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
async function main(){

    // we don't have the connection variable to be reassigned
    const connection = await mysql.createConnection({
        'host':'localhost',
        'user': 'root',
        'database': 'sakila'
    })

    app.get('/actors', async function(req,res){
        let [actors] = await connection.execute("SELECT * from actor");
        res.render('actors', {
            'actors': actors
        });
    })

    app.get('/search', async function(req,res){
        // starts off with the query that selects everything
        let query = "SELECT * from actor WHERE 1";

        // if the user had filled in the name field in the form
        if (req.query.name) {
            // add the extra criteria to back to the query if the
            // user had filled in the name
            query += ` AND (first_name LIKE "%${req.query.name}%" 
                           OR last_name LIKE "%${req.query.name}%")`
        }

        // get the results
        let [actors] = await connection.execute(query);

        res.render('search', {
            'actors': actors
        })
    })
}
main();

// START SERVER
app.listen(3000, ()=>{
    console.log("Server has started")
})