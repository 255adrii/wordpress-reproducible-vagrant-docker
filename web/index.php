<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="<?php bloginfo('charset'); ?>">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <?php wp_head(); ?>
</head>
<body <?php body_class(); ?>>

    <header>
        <h1><?php bloginfo('name'); ?></h1>
        <p>Soluciones web modernas para empresas</p>
    </header>

    <main>
        <div class="card">
            <h2>Bienvenido a nuestra web corporativa</h2>
            <p>
                Somos una empresa especializada en el desarrollo de páginas web
                corporativas utilizando tecnologías modernas, automatización de
                despliegues y entornos virtualizados.
            </p>
            <a href="mailto:info@webfusion.example" class="btn">Contactar</a>
        </div>
    </main>

    <footer>
        <p>© <?php echo esc_html(date('Y')); ?> <?php bloginfo('name'); ?>. Todos los derechos reservados.</p>
    </footer>

    <?php wp_footer(); ?>
</body>
</html>
