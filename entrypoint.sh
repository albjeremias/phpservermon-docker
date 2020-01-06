#!/bin/bash
if [ -f $FILE ]; then
    echo "<?php
    define('PSM_DB_PREFIX', '$PSM_DB_PREFIX');
    define('PSM_DB_USER', '$PSM_DB_USER');
    define('PSM_DB_PASS', '$PSM_DB_PASS');
    define('PSM_DB_NAME', '$PSM_DB_NAME');
    define('PSM_DB_HOST', '$PSM_DB_HOST');
    define('PSM_DB_PORT', '$PSM_DB_PORT');
    define('PSM_BASE_URL', '$PSM_BASE_URL'); " > config.php
fi
service nginx start
service php7.3-fpm start
cron
sleep 2
tail -f /var/log/nginx/*.log /var/log/cron.log
