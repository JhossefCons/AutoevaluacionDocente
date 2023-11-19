import mysql from 'mysql';
require('dotenv').config();

const data = {
    host: process.env.DB_HOST,
    user: process.env.DB_USER,
    password: process.env.DB_PASSWORD,
    database: process.env.DB_DATABASE
}

export const connection = mysql.createConnection(data);

connection.connect((err) =>{
    console.log(data);
    if(err){
        console.log('TypeError:' + err);
        return;
    }
    console.log('Connection with database was successful')
});