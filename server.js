const express = require('express')
const app = express()
const { Pool } = require('pg');

// app.get('/', (req,res) => {
//     console.log("here")
//     res.send("Hi")
// })


var pool

pool = new Pool({
    user: "postgres",
    host: "localhost",
    password: "helloworld",
    port: "5431"

})

const PORT = 3000;

app.use(express.json())
app.use(express.urlencoded({extended:true}))

app.get('/', async (req,res)=> {
  await pool.query('CREATE TABLE IF NOT EXISTS users (id SERIAL PRIMARY KEY, name VARCHAR(255), age INT)')
  res.send('success')
})

app.post('/users', async (req,res) => {
  const {name, age} = req.body
  const response = await pool.query('Inserts INTO users (name,age) VALUES ($1, $2)' , [name, age])
  res.send("sucess")
})

app.get('/users', async (req,res) => {
    const response = await pool.query ('SELECT * FROM users')
    res.send(response.rows)
})

app.listen(PORT, () => {
  console.log(`Server running on http://localhost:${PORT}`);
});

