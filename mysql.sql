-- edxapp

CREATE USER 'edxapp'@'localhost'
IDENTIFIED BY 'edxapp';

GRANT ALL PRIVILEGES ON *.*
TO 'edxapp'@'localhost';

CREATE DATABASE edxapp
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- xqueue

CREATE USER 'xqueue'@'localhost'
IDENTIFIED BY 'xqueue';

GRANT ALL PRIVILEGES ON * . *
TO 'xqueue'@'localhost';

CREATE DATABASE xqueue
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- ora

CREATE USER 'ora'@'localhost'
IDENTIFIED BY 'ora';

GRANT ALL PRIVILEGES ON * . *
TO 'ora'@'localhost';

CREATE DATABASE ora
CHARACTER SET utf8
COLLATE utf8_general_ci;

-- anal

CREATE USER 'anal'@'localhost'
IDENTIFIED BY 'anal';

GRANT ALL PRIVILEGES ON * . *
TO 'anal'@'localhost';

CREATE DATABASE anal
CHARACTER SET utf8
COLLATE utf8_general_ci;

CREATE USER 'ranal'@'localhost'
IDENTIFIED BY 'ranal';

GRANT SELECT ON ranal.*
TO 'ranal'@'localhost';
