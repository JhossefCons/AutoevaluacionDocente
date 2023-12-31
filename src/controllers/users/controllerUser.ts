import { connection } from '../../database/db';
import bcryptjs from 'bcryptjs';
import { encryptPassword } from '../../utils/passwordHandler';
import { getInfoUser,getUsers,createUser, createUserRole ,getUserByIdentification,updateUser,updateUserRole} from '../../fachada/fachadaUsuario'; 

export const showCoordinadorPrincipal = (req, res) => {
    res.render('coordinadorPrincipal',{
      userName: req.session.username,
      userLastname: req.session.userlastname
    });
}

export const showDocentePrincipal = (req, res) => {
  res.render('docentePrincipal',{
    user: req.session.username
  });
}

export const showInformacionDocente = (req, res) => {
  res.render('docenteInformacionPersonal');
}

export const showDecanoPrincipal = (req,res) => {
  res.render('decanoPrincipal',{
    user: req.session.username
  });
}

export const coordinadorCRUDuser = (req, res) => {
    const user = req.session.username;
    console.log(user);

    getUsers(user, (err, users) => {
        if (err) {
            res.json(err);
        } else {
            console.log(users);
            res.render('coordinadorCrudUser', {
                data: users
            });
        }
    });
};

export const showCreateCoordinadorCreateUser = (req, res) =>{
    res.render('coordinadorCreateUser');
}

export const createDocente = async (req, res) => {
    try {
      const {
        user_identification,
        user_name,
        user_lastname,
        user_gender,
        user_email,
        user_password,
        user_studies,
        user_tipoDocente,
        role_id,
        date_start,
        date_finish,
      } = req.body;
  
      let passwordHash = await encryptPassword(user_password);
      console.log('CONTROLLER CREATE DOCENTE');
      console.log(req.body);
  
      createUser(
        {
          user_identification,
          user_name,
          user_lastname,
          user_gender,
          user_email,
          user_password: passwordHash,
          user_studies,
          activo: 1,
          user_tipoDocente,
        },
        async (err, userResult) => {
          if (err) {
            console.log("ERROR AL CREAR EL USUARIO");
            console.log(err);
            res.render('coordinadorCreateUser', {
              alert: true,
              alertTitle: 'Error',
              alertMessage: 'Error en user',
              alertIcon: 'error',
              showConfirmButton: true,
              timer: false,
              ruta: 'coordinadorCrudUser',
            });
          } else {
            console.log('docente creado');
            createUserRole(
              { user_identification, role_id, date_start, date_finish },
              (err, roleResult) => {
                if (err) {
                  res.render('coordinadorCreateUser', {
                    alert: true,
                    alertTitle: 'Error',
                    alertMessage: 'Error en user_role',
                    alertIcon: 'error',
                    showConfirmButton: true,
                    timer: false,
                    ruta: 'coordinadorCrudUser',
                  });
                } else {
                  console.log('user rol registrado');
                  res.render('coordinadorCreateUser', {
                    alert: true,
                    alertTitle: 'Registro completado',
                    alertMessage: '!usuario registrado!',
                    alertIcon: 'success',
                    showConfirmButton: false,
                    timer: 1500,
                    ruta: 'coordinadorCrudUser',
                  });
                }
              }
            );
          }
        }
      );
    } catch (err) {
      console.log(err);
    }
};

export const showUpdateDocente = (req, res) => {
      const { user_identification } = req.params;
      
      getUserByIdentification(user_identification, (err, result) => {
          if (err) {
              console.log(err);
          } else {
              const user = result[0];  
              console.log("----Datos para actualizar vista----");
              console.log(user);
              res.render('coordinadorUpdateuser', {     
                  data: user
              });
          }
      });
};

export const updateDocente = (req, res) => {
    try {
        const { user_identification, user_role_id } = req.params;
        const { user_name, user_lastname, user_gender, user_email, user_studies, activo, user_tipoDocente, date_start, date_finish, role_id } = req.body;
        console.log("----------------IDENTIFICACION PARA ACTUALIZAR---------------------");
        console.log(user_identification);
        const user = {
            user_name,
            user_lastname,
            user_gender,
            user_email,
            user_studies,
            activo,
            user_tipoDocente
        };
        console.log("----------------DATOS ACTUALIZACION DOCENTE USER---------------------");
        console.log(user);
        const userRole = {
            date_start,
            date_finish,
            role_id
        };
        console.log("----------------DATOS ACTUALIZACION DOCENTE ROLE---------------------");
        console.log(userRole);
        updateUser(user_identification, user, (err, result) => {
            if (err) {
                console.log(err);
            } else {
                console.log('Usuario actualizado');
            }
        });

        updateUserRole(user_role_id, userRole, (err, result) => {
            if (err) {
              console.log(err);
            } else {
              console.log('Rol de usuario actualizado');
            }
        });
        getUsers(user_email, (err, users) => {
          if (err) {
              res.json(err);
          } else {
              res.render('coordinadorUpdateuser', {
                data: users,
                alert: true,
                alertTitle: 'Registro completado',
                alertMessage: '!usuario actualizado!',
                alertIcon: 'success',
                showConfirmButton: false,
                timer: 1500,
                ruta: 'coordinadorCrudUser',
              });
          }
      });
    } catch (err) {
        console.log(err);
    }
};

export const informacionDocente = (req, res) => {
  const email = req.session.useremail;
  console.log("Informacion Personal");
  console.log(email);
  getInfoUser(email, (err, users) => {
    if (err) {
        res.json(err);
    } else {
        console.log("Informacion Personal encontrada");
        console.log(users);
        res.render('docenteInformacionPersonal', {
          data: users
        });
    }
  });
}

