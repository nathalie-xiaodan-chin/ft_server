<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the
 * installation. You don't have to use the web site, you can
 * copy this file to "wp-config.php" and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * MySQL settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** MySQL settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'nath_db' );

/** MySQL database username */
define( 'DB_USER', 'nath' );

/** MySQL database password */
define( 'DB_PASSWORD', 'toto' );

/** MySQL hostname */
define( 'DB_HOST', 'localhost' );

/** Database Charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The Database Collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication Unique Keys and Salts.
 *
 * Change these to different unique phrases!
 * You can generate these using the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}
 * You can change these at any point in time to invalidate all existing cookies. This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
// define( 'AUTH_KEY',         'put your unique phrase here' );
// define( 'SECURE_AUTH_KEY',  'put your unique phrase here' );
// define( 'LOGGED_IN_KEY',    'put your unique phrase here' );
// define( 'NONCE_KEY',        'put your unique phrase here' );
// define( 'AUTH_SALT',        'put your unique phrase here' );
// define( 'SECURE_AUTH_SALT', 'put your unique phrase here' );
// define( 'LOGGED_IN_SALT',   'put your unique phrase here' );
// define( 'NONCE_SALT',       'put your unique phrase here' );

define('AUTH_KEY',         'X39I$|!btmt[7]6vwX>/Be*c~I(f,fW(iV-?9qD^UE|gTAG.r8<R)JG#!*yho~:>');
define('SECURE_AUTH_KEY',  'rMDO4e@@^Shi@R1UGm?y]u;E/2[OETcQpS^/Lq2:_sr:Yu!?W/kq@+ T[84D()Lo');
define('LOGGED_IN_KEY',    '*169)ofk7icro= P63J3Hhdz_Byr{%0rl^X(}x,}!h(!l8xzu4mw>KAWB{~(ZxR?');
define('NONCE_KEY',        'Ckx&-Pw]>wgLp/jx(~,%+`O4{g[`TcFp2ys{tU)9ZG3J|20%8p|X>HM?mXZkF}--');
define('AUTH_SALT',        'tKs0` waGo|UZq|YJq_&bxSMX[*iC[p~CVgMH4I+zL%wJ8X`)fmRRu&J3jA6Z2Xd');
define('SECURE_AUTH_SALT', '30uC-9ZMW8J/Lig,sBeBh9kL9_-|2gplF>>3}V+<[i)g%+SmasNt%-<S:xXrP(?H');
define('LOGGED_IN_SALT',   '$zkWTWnc4 pi[X^L-00b-?3] +-H.Vb<iuvSKPWC3n5:r*-13oyx69%mIA!l~X)g');
define('NONCE_SALT',       'LP-Fo|rE4soA-9ouO{A[<@b0:Rc~ZXzdu#_d@]!VN03_5LX|:Pt 7HI.ghx%[jLX');

/**#@-*/

/**
 * WordPress Database Table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
        define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
