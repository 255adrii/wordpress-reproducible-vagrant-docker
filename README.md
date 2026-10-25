# ProyectoAmpSis · WordPress reproducible con Vagrant y Docker Compose

Entorno completo de WordPress que se despliega con **un solo comando** (`vagrant up`):
Vagrant crea una VM Ubuntu, instala Docker y Compose dentro, y Compose levanta
MySQL + WordPress, instala el sitio y activa un tema propio. No hay que tocar nada a mano.

> *WebFusion Digital S.L.* es una empresa ficticia usada como caso de ejemplo en un proyecto de clase (Ampliación de Sistemas).

**Resultado:** una página corporativa de una sola pantalla con cabecera oscura (nombre de la empresa y eslogan), una tarjeta central de bienvenida con un botón "Contactar" y un pie de página con el copyright.

## Arquitectura

```
Tu equipo (host)
└── Vagrant + VirtualBox
    └── VM Ubuntu 22.04  (localhost:8080 → VM:8080)
        └── Docker Compose
            ├── db         MySQL 8.0        (volumen db_data)
            ├── wordpress  WordPress 6.7    (volumen wp_data, tema montado desde ./web)
            └── wpcli      WP-CLI           (instala WordPress y activa el tema; termina)
```

## Requisitos

- [VirtualBox](https://www.virtualbox.org/) y [Vagrant](https://www.vagrantup.com/)
- ~2 GB de RAM libres y conexión a internet (primera ejecución)

## Uso

```bash
git clone https://github.com/255adrii/ProyectoAmpSis.git
cd ProyectoAmpSis
cp .env.example .env      # cambia las contraseñas
vagrant up
```

Cuando termine (la primera vez tarda unos minutos):

- Web: http://localhost:8080
- Administración: http://localhost:8080/wp-admin (usuario y contraseña del `.env`)

Otros comandos útiles:

```bash
vagrant ssh                                   # entrar en la VM
cd /vagrant && docker compose ps              # estado de los contenedores
docker compose logs -f wpcli                  # progreso de la instalación
vagrant halt                                  # apagar la VM
vagrant destroy -f                            # borrarlo todo
```

## Estructura

```
├── Vagrantfile          VM (Ubuntu 22.04, 2 GB, 2 CPU)
├── provision.sh         instala Docker/Compose y ejecuta docker compose up
├── docker-compose.yml   servicios db, wordpress y wpcli
├── wp-cli/install.sh    instalación automática de WordPress
├── web/                 tema WordPress "WebFusion" (se edita en local y se ve al recargar)
└── .env.example         plantilla de configuración y credenciales
```

## Configuración

Todas las credenciales viven en `.env` (que **no** se sube al repositorio). Las variables están documentadas en `.env.example`.

## Decisiones de diseño

- **Versiones fijadas** (`mysql:8.0`, `wordpress:6.7-apache`) para que el entorno sea reproducible.
- **Healthcheck en MySQL** para que WordPress y WP-CLI arranquen solo cuando la base de datos está lista.
- **Tema montado como volumen** (`./web`), sin depender de clonar el repo desde dentro de un contenedor.
- **Instalación con WP-CLI**: sin asistente manual, el despliegue es idempotente.

## Posibles mejoras

- HTTPS con un proxy inverso (Caddy/Traefik)
- Copias de seguridad automáticas de la base de datos
- Pipeline de CI que valide `docker compose config`

## Licencia

Pendiente de añadir (por ejemplo MIT).
