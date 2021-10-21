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

    app.get('/actors/create', function(req,res){
        res.render("actor_create");
    })

    app.post('/actors/create', async function(req,res){
        let firstName = req.body.first_name;
        let lastName = req.body.last_name;
        // prepared query or prepared statement
        let query = `INSERT INTO actor (first_name, last_name)
                             VALUES (?, ?);`;
        let bindings = [firstName, lastName];   
        await connection.execute(query, bindings);
        res.redirect('/actors');
    })

    app.get('/actors/:actor_id/update', async function(req,res){
        let actorId = req.params.actor_id;
        let query = "SELECT * from actor WHERE actor_id = ?";
        let binding = [actorId];
        let [actors] = await connection.execute(query, binding);
        let actor = actors[0];
        res.render('actor_edit',{
            'actor': actor
        })

    })

    app.post('/actors/:actor_id/update', async function(req,res){
        let firstName = req.body.first_name;
        let lastName = req.body.last_name;
        let actorId = req.params.actor_id;
        let query = `UPDATE actor SET first_name = ?, last_name = ? 
                     WHERE actor_id = ?`;
        let bindings = [firstName, lastName, actorId ];
        await connection.execute(query, bindings);
        res.redirect('/actors');
    })

    app.get('/actors/:actor_id/delete', async function(req,res){
        let query = "SELECT * FROM actor where actor_id = ?";
        let binding = [req.params.actor_id];
        let [actors] = await connection.execute(query, binding);
        res.render("actor_delete", {
            'actor': actors[0]
        })
    })

    app.post('/actors/:actor_id/delete', async function(req,res){
        let query = "DELETE FROM actor WHERE actor_id = ?";
        let binding = [req.params.actor_id];
        await connection.execute(query, binding);
        res.redirect('/actors');
    })
}
main();

// START SERVER
app.listen(3000, ()=>{
    console.log("Server has started")
})