import React, { useState, useEffect } from 'react';
import { useParams, useNavigate } from 'react-router-dom';
import Header from '../components/header';
import storage from '../Utils/storage';

const Perfil = ({ tipo }) => {
    const { id } = useParams();
    const navigate = useNavigate();

    // Estados
    const [tipoUsuario, setTipoUsuario] = useState(storage.get('tipoUsuario') ?? null);
    const [idStorage, setIdStorage] = useState(storage.get('userId') ?? null);
    const [userData, setUserData] = useState(null); // Iniciar como null para mostrar un estado de carga
    const [userValoraciones, setUserValoraciones] = useState([]);
    const [editing, setEditing] = useState(false);
    const [formData, setFormData] = useState({});

    // El estado de la imagen ahora se derivará de userData
    const [image, setImage] = useState('/images/nofoto.png'); // Placeholder por defecto con ruta absoluta

    const apiUpload = '/api/uploadImage';
    const urlApi = tipoUsuario === 'electricista'
            ? `/api/electricistas/${id}`
            : `/api/usuarios/${id}`;

    // --- LÓGICA DE DATOS ---

    useEffect(() => {
        if (idStorage === null || parseInt(idStorage) !== parseInt(id) || tipo !== tipoUsuario) {
            navigate('/');
            return; // Detener la ejecución si la validación falla
        }

        fetch(urlApi)
            .then((response) => response.json())
            .then((data) => {
                setUserData(data.data);
                setUserValoraciones(data.valoraciones);
                setFormData(data.data);

                // --- CAMBIO CLAVE #1: Usar la url_foto de la API ---
                // Ya no construimos la ruta, la leemos directamente del objeto que nos da el backend.
                if (data.data && data.data.url_foto) {
                    setImage(data.data.url_foto);
                } else {
                    setImage('/images/nofoto.png'); // Si no hay foto, usamos el placeholder
                }
            })
            .catch(error => console.error("Error al cargar los datos del perfil:", error));
    }, [id, idStorage, tipo, tipoUsuario, navigate]);


    // --- MANEJADORES DE EVENTOS ---

    const handleImageChange = async (e) => {
        const selectedFile = e.target.files[0];
        if (!selectedFile) return;

        // Muestra una previsualización instantánea
        const reader = new FileReader();
        reader.onloadend = () => {
            setImage(reader.result);
        };
        reader.readAsDataURL(selectedFile);

        // Sube el archivo al backend
        const formdata = new FormData();
        formdata.append("id", id);
        formdata.append("tipo", tipoUsuario);
        formdata.append("attachment", selectedFile);

        try {
            const response = await fetch(apiUpload, {
                method: "POST",
                body: formdata,
            });

            const result = await response.json();

            if (!response.ok) {
                throw new Error(result.message || 'Error al subir la imagen');
            }
            
            // --- CAMBIO CLAVE #2: Actualizar el estado con la nueva URL ---
            // El backend nos devuelve la nueva URL, la usamos para actualizar la imagen final.
            // Esto reemplaza la previsualización temporal con la imagen real del servidor.
            setImage(result.imageUrl);
            
            // También actualizamos el objeto de datos principal para mantener la consistencia
            setUserData(prevData => ({...prevData, url_foto: result.imageUrl}));
            
            alert('Imagen actualizada correctamente');

        } catch (error) {
            console.error(error);
            alert('No se pudo guardar la imagen');
            // Si falla, podrías revertir la imagen a la original: setImage(userData.url_foto || '/images/nofoto.png');
        }
    };

    const handleChange = (e) => {
        setFormData({ ...formData, [e.target.name]: e.target.value });
    };

    const handleSubmit = async (e) => {
        e.preventDefault();
        setUserData(formData);
        const formDataToSend = new URLSearchParams();
        formDataToSend.append("nombre", formData.nombre);
        formDataToSend.append("apellidos", formData.apellidos);
        formDataToSend.append("password", formData.password);
        formDataToSend.append("telefono", formData.telefono);
        formDataToSend.append("email", formData.email);
        formDataToSend.append("ubicacion", formData.ubicacion);
        formDataToSend.append("nombreEmpresa", formData.nombreEmpresa);
        formDataToSend.append("servicios", formData.servicios);
        try {
             const response = await fetch(urlApi, {
                method: 'PUT',
                body: formDataToSend,
                headers: {
                    'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
            });

            if (!response.ok) {
                throw new Error('Error al guardar el usuario');
            }

            setTimeout(() => {
                alert('Cambios guardados correctamente');
            }, 1000);
        } catch (error) {
            console.log(error);
            alert('No se pudieron guardar los cambios');
        }
        setEditing(false);
    };

    const eliminar = async () => {
        try {
            const response = await fetch(urlApi, {
                method: 'DELETE',
                headers: {
                    'Content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
                },
            });

            if (!response.ok) {
                throw new Error('Error al guardar el usuario');
            }

            setTimeout(() => {
                alert('Usuario eliminado correctamente');
            }, 1000);
        } catch (error) {
            console.log(error);
            alert('No se pudo borrar usuario');
        }
    };

    const cerrarSesion = () => {
        storage.clear();
        setIdStorage(null);
    };
    
    // Muestra un mensaje de carga mientras se obtienen los datos
    if (!userData) return <p>Cargando perfil...</p>;

    // --- RENDERIZADO DEL COMPONENTE ---
    return (
        <>
            <Header />
            <div className="container mx-auto mt-8">
                <div className="max-w-lg mx-auto bg-white shadow-md rounded px-8 pt-6 pb-8 mb-4">
            <h2 className="text-lg font-bold mb-4">Información del Usuario</h2>
            {editing ? (
                <form onSubmit={handleSubmit}>
                    <div className="mb-4">
                        <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="nombre">
                            Nombre:
                        </label>
                        <input
                            className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                            id="nombre"
                            type="text"
                            name="nombre"
                            value={formData.nombre}
                            onChange={handleChange}
                        />
                    </div>
                    {/* Agregar campos de formulario adicionales según el tipo de usuario */}
                    {tipoUsuario !== 'electricista' ? (
                        <>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="apellidos">
                                    Apellidos:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="apellidos"
                                    type="text"
                                    name="apellidos"
                                    value={formData.apellidos}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="ubicacion">
                                    Ubicación:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="ubicacion"
                                    type="text"
                                    name="ubicacion"
                                    value={formData.ubicacion}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="valoraciones">
                                    Valoraciones:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="valoraciones"
                                    type="number"
                                    name="valoraciones"
                                    value={formData.valoraciones}
                                    onChange={handleChange}
                                />
                            </div>
                        </>
                    ) : (
                        <>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="apellidos">
                                    Apellidos:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="apellidos"
                                    type="text"
                                    name="apellidos"
                                    value={formData.apellidos}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="nombreEmpresa">
                                    Nombre de la Empresa:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="nombreEmpresa"
                                    type="text"
                                    name="nombreEmpresa"
                                    value={formData.nombreEmpresa}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="email">
                                    Email:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="email"
                                    type="email"
                                    name="email"
                                    value={formData.email}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="telefono">
                                    Teléfono:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="telefono"
                                    type="tel"
                                    name="telefono"
                                    value={formData.telefono}
                                    onChange={handleChange}
                                />
                            </div>
                            <div className="mb-4">
                                <label className="block text-gray-700 text-sm font-bold mb-2" htmlFor="servicios">
                                    Servicios:
                                </label>
                                <input
                                    className="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline"
                                    id="servicios"
                                    type="text"
                                    name="servicios"
                                    value={formData.servicios}
                                    onChange={handleChange}
                                />
                            </div>
                        </>
                    )}
                    <button
                        type="submit"
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded focus:outline-none focus:shadow-outline"
                    >
                        Guardar
                    </button>
                    <a
                        onClick={() => { setEditing(false) }}><span
                            className="text-red-400 hover:bg-slate-100 cursor-pointer font-bold py-2 px-4"
                        >
                            Cancelar</span>
                    </a>
                    <button
                        onClick={cerrarSesion}
                        className="bg-grey-500 hover:bg-grey-700 font-bold py-2 px-4 rounded mt-4 focus:outline-none focus:shadow-outline"
                    >
                        Cerrar Sesión
                    </button>
                </form>
            ) : (
                <>
                    <p className="mb-4"><span className="font-semibold">Nombre:</span> {userData.nombre}</p>
                    {tipo === 'usuario' ? (
                        <>
                            <p className="mb-4"><span className="font-semibold">Apellidos:</span> {userData.apellidos}</p>
                            <p className="mb-4"><span className="font-semibold">Ubicación:</span> {userData.ubicacion}</p>
                            <p className="mb-4"><span className="font-semibold">Valoraciones:</span> {userData.valoraciones}</p>
                        </>
                    ) : (
                        <>
                            <p className="mb-4"><span className="font-semibold">Apellidos:</span> {userData.apellidos}</p>
                            <p className="mb-4"><span className="font-semibold">Ubicación:</span> {userData.ubicacion}</p>
                            <p className="mb-4"><span className="font-semibold">Nombre de la Empresa:</span> {userData.nombreEmpresa}</p>
                            <p className="mb-4"><span className="font-semibold">Email:</span> {userData.email}</p>
                            <p className="mb-4"><span className="font-semibold">Teléfono:</span> {userData.telefono}</p>
                            <p className="mb-4"><span className="font-semibold">Servicios:</span> {userData.servicios}</p>
                        </>
                    )}
                <div>
                    <label htmlFor="image-input">
                        <img src={image} alt="User" className='w-32 h-32 mx-auto rounded-full mb-4 cursor-pointer object-cover' />
                    </label>
                    <input
                        id="image-input"
                        type="file"
                        accept="image/*"
                        style={{ display: 'none' }}
                        onChange={handleImageChange}
                    />
                </div>
                <button
                        onClick={() => setEditing(true)}
                        className="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-4 focus:outline-none focus:shadow-outline"
                    >
                        Editar
                    </button>
                    <button
                        onClick={cerrarSesion}
                        className="bg-grey-500 hover:bg-grey-700 font-bold py-2 px-4 rounded mt-4 focus:outline-none focus:shadow-outline"
                    >
                        Cerrar Sesión
                    </button>
                    <button
                        onClick={eliminar}
                        className="bg-red-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded mt-4 focus:outline-none focus:shadow-outline"
                    >
                        Eliminar
                    </button>
                </>
            )}
        </div>
            </div>
        </>
    );
};

export default Perfil;