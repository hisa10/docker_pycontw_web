Dockerfile for testing ja-translation of PyCon TW web
#####################################################

* You can find original source code in here:

  https://github.com/pycontw/pycon.tw

* Japanese translations are still in beta quality:
  
  https://github.com/hisa10/pycon.tw



Requirements
============

* Linux (Not tested on any other OSes and specially I don't take care of Windows.)
* Docker >= 18.09.2
* Docker compose >= 1.20.1

Usage
-----

1. Clone this repository.
2. Generate django secret key then rewrite Dockerfile.
3. Build image.

    .. code-block:: bash

       $ docker build -t pycontw-web .

4. Run.

    .. code-block:: bash

       $ docker run -p 8000:8000 -d pycontw-web 

5. Access with web browser.
6. Add admin user from "My PyCon" page.
7. Login the container and add some flags to user which you created.

    .. code-block:: bash

       $ docker ps
       $ docker exec -it <container ID> /bin/bash
       # cd /pycon.tw/src
       # sqlite3 db.sqlite3
       sqlite> .header on
       sqlite> select * from users_user;
       sqlite> update users_user set is_superuser=1,is_staff=1,verified=1 where id=1;
       sqlite> .quit
       # exit

