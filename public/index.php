<?php
// Load package dependencies
require __DIR__ . '/../vendor/autoload.php';

// Load Environment variables form .env file
(Dotenv\Dotenv::create(substr(__DIR__, 0, strrpos(__DIR__, '/'))))->load();

// Create App setting the env for later use
$app = new \Slim\App(['env' => getenv('APP_ENV')]);
$container = $app->getContainer();

// Add all services to the App container
include __DIR__ . '/../config/services.php';
// Register routes
include __DIR__ . '/../config/routes.php';

$app->run();
