const router = require('express').Router()
const db = require('../db.js');

const multer = require('multer');

const storage = multer.diskStorage({
    destination: function (req, file, cb) {
      cb(null, 'uploads/');
    },
    filename: function (req, file, cb) {
      const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
      const extension = path.extname(file.originalname);
      cb(null, file.fieldname + '-' + uniqueSuffix + extension);
    }
})
const upload = multer({storage: storage});

const fs = require('fs')
const path = require('path')

router.post('/', [upload.single('attachment')], (req, res, next) => {

    let tipo = req.body.tipo;
    let id = req.body.id;
    let type = req.file.originalname.slice(-3);
    let responseb = {};

    if (req.file.length == 0) {
        responseb.error = true;
        responseb.mensaje = 'Ingrese una imagen';
        responseb.codigo = 400;
        res.status(400).send(responseb);

    } else {
        if (req.file.mimetype.indexOf('image') >= 0) {
            let { fileName } = req.file.filename;
            const imageUrl = `/uploads/${req.file.filename}`
            const sql = tipo === 'electricista' 
                ? "UPDATE electricistas SET typeFoto = ?, url_foto = ? WHERE id = ?"
                : "UPDATE usuarios SET typeFoto = ?, url_foto = ?  WHERE id = ?";

            const params = [type, imageUrl, id];

            db.query(sql, params, (err, results) => {
                if (err) {
                    console.error('Error al actualizar:', err);
                    res.status(500).send('Error en el servidor');
                    return;
                }
                console.log(results)
                res.json(results);
            });

        } else {
            responseb.error = true;
            responseb.mensaje = 'Ingrese una imagen';
            responseb.codigo = 400;
            res.status(400).send(responseb);
        }
    }
});

module.exports = router;