import { connection } from '../database/db';

export const  getUserByEmail = (email, callback) => {
    connection.query('SELECT * FROM user WHERE USER_EMAIL = ? AND ACTIVO != -1', [email], (err, result) => {
      console.log("DATOS CONSULTADOS");
      console.log(result);
      if (err) {
        console.log("Error al consultar");
        callback(err, null);
      } else {
        console.log("Consulta realizada");
        callback(null, result);
      }
    });
  };
  
export const getUserRole = (userIdentification, callback) => {
    connection.query('SELECT role_id FROM userol WHERE user_identification = ?', [userIdentification], (err, result) => {
      console.log(result);
      if (err) {
        callback(err, null);
      } else {
        callback(null, result);
      }
    });
  };