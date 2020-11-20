'use strict';
const functions  = require('firebase-functions');
const admin = require('firebase-admin');
const nodemailer = require('nodemailer');
const cors = require('cors')({origin: true});
admin.initializeApp();

let transporter = nodemailer.createTransport({
  service: 'gmail',
  auth: {
      user: 'mauricio.lorenzetti.bezerra@gmail.com',
      pass: 'Am0B1k3M35m0F0y123!'
  }
});

exports.enviarEmail = functions.https.onRequest((req, res) => {
  cors(req, res, () => {

    let dest = req.body.data.dest;
    console.log(dest)

    const mailOptions = {
      from: '"Mauricio Bezzerra" <mauricio.lorenzetti.bezerra@gmail.com>',
      to: dest,
      subject: 'I\'M A PICKLE!!!',
      html: `<p style="font-size: 16px;">Pickle Riiiiiiiiiiiiiiiick!!</p>
          <br />
          <img src="https://images.prod.meredith.com/product/fc8754735c8a9b4aebb786278e7265a5/1538025388228/l/rick-and-morty-pickle-rick-sticker" />
      `
    };

    transporter.sendMail(mailOptions, (error, info) => {
        if (error) {
          return console.log(error);
        }
        console.log('Mensagem %s enviada: %s', info.messageId, info.response);
        return;
    });
  });
});

exports.createUser = functions.auth.user().onCreate((user) => {

  const newUser = {
    "uid": user.uid,
    "name": "novo-usuario",
    "email": user.email,
    "analysisStatus": false,
    "phone": "19987650000",
    "cpf": "111.111.111-11"
  }

  admin.database().ref('users/' + user.uid).set(newUser)

})