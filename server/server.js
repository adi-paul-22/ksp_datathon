const express = require('express');
const { Pool } = require('pg');
const cors = require('cors'); // Don't forget to npm install cors

// Set up the PostgreSQL connection.
const pool = new Pool({
  user: 'postgres',
  host: 'localhost',
  database: 'postgres',
  password: '1234',
  port: 5432,
});

const app = express();

// Enable CORS for all routes
app.use(cors());

// Support JSON payloads
app.use(express.json());

const port = 3000;

// Define a route that fetches all rows from your table.
app.get('/fetch-data', async (req, res) => {
  try {
    const { rows } = await pool.query('SELECT * FROM kspdata');
    res.json(rows);
  } catch (error) {
    console.error('Error fetching data:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Create a new task
app.post('/create-task', async (req, res) => {
  try {
    const { name, task, taskdate, status } = req.body;
    const result = await pool.query(
      'INSERT INTO kspdata (name, task, taskdate, status) VALUES ($1, $2, $3, $4)',
      [name, task, taskdate, status]
    );
    res.status(201).send(`Task added with ID: ${result.insertId}`);
  } catch (error) {
    console.error('Error creating new task:', error);
    res.status(500).send('Internal Server Error');
  }
});

// Update an existing task
app.put('/update-task/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { name, task, taskdate, status } = req.body;
    await pool.query(
      'UPDATE kspdata SET name = $1, task = $2, taskdate = $3, status = $4 WHERE id = $5',
      [name, task, taskdate, status, id]
    );
    res.send(`Task updated with ID: ${id}`);
  } catch (error) {
    console.error('Error updating task:', error);
    res.status(500).send('Internal Server Error');
  }
});

app.delete('/delete-task/:id', async (req, res) => {
  try {
    const { id } = req.params;
    await pool.query('DELETE FROM kspdata WHERE id = $1', [id]);
    res.status(200).send(`Task deleted with ID: ${id}`);
  } catch (error) {
    console.error('Error deleting task:', error);
    res.status(500).json({ error: 'Internal Server Error' });
  }
});

app.get('/search-task', async (req, res) => {
  try {
    const { name } = req.query;
    const { rows } = await pool.query('SELECT * FROM kspdata WHERE name ILIKE $1', [`%${name}%`]);
    res.json(rows);
  } catch (error) {
    console.error('Error searching tasks:', error);
    res.status(500).json({ error: 'Internal server error' });
  }
});

// Start the server
app.listen(port, () => {
  console.log(`Server running on port ${port}`);
});
