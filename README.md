Exportar tabla HTML a PDF usando mPDF
======

Código del ejemplo para exportar tablas HTML a un documento PDF usando mPDF con KumbiaPHP 1.0RC, del manual: 
[Exportar tabla HTML a PDF usando mPDF](https://www.kumbiaphp.com/blog/)

## Correr en Docker

Como prerequisito debe tener instalado Docker en el sistema operatvo: [Obtener Docker](https://www.docker.com/products/overview)

### 1. Correr mysql con datos externos y publicado

``
docker run --detach --name=mysql-dev --env="MYSQL_ROOT_PASSWORD=root" --volume /home/usuario/mysql/data:/var/lib/mysql --publish 6603:3306 mysql:5.7
``

Cambia el valor del parámetro --volume por el directorio que desees

### 2. Importar base de datos

Importar el archivo *default/app/config/sql/paginate-php.sql*

### 3. Crear red network-dev

``
docker network create network-dev
``

### 4. Conectar la base de datos a la red creada

Esto es con el fin de que el contendor creado con docker compose en el paso
5 se pueda conectar al contenedor de la base de datos MySQL:

``
docker network connect network-dev mysql-dev
``

### 5. Correr Apache + PHP 7

En la carpeta raíz de este proyecto correr:

``
docker-compose up -d --build
``

o simplemente...

``
docker-compose up -d
``

Mirar la web en **http://localhost:8186**

La opción ``--build``, es sólo para la primera vez o cuando se cambian los ficheros del docker.

``docker-compose up`` (muestra el log en la terminal)

``docker-compose up -d `` (como demonio, sin datos en la terminal)

## Instalar mPDF con composer

El contenedor actual ya viene con composer instalado y el archivo _composer.json_ 
modificado para indicar la instalación mPDF en su versión 7

Archivo: _composer.json_

``
{    
    "require": {
        "php": ">=7.0",
        "mpdf/mpdf": "7.1.7"
    }
}
``

### 1. Igresar a la consola o bash del contenedor

``docker exec -t -i export-table-mpdf bash``

### 2. Ejecutar el comando

``composer install``

### 3. Salir del contendor

``exit``