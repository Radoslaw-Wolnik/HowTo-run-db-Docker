# Oracle

## Start
1. start docker container: ` docker-compose up -d `

## Connecting using SQL*PL
2. connect to the container's bash shell: `docker-compose exec oracle-xe bash`
3. inside the container, connect to SQL*Plus as the system user: `sqlplus / as sysdba`
4. Now connect as user `CONNECT myappuser@XEPDB1` or `sqlplus myappuser@XEPDB1`

## Connecting via Oracle SQL Developer
2. add new connection
```
Connection Name: OracleXE_Docker
Connection Type: Basic
Username: myappuser (or the APP_USER you set in .env)
Password: app_user_password (or the APP_USER_PASSWORD you set in .env)
Hostname: localhost
Port: 1521
Service name: XEPDB1
```
3. Test Connection
4. Save and connect

## Notes 
 - Here we download community mantained image insted of official one becouse official one is only avaliable after creating free acc and downloading it form oracle website (docker-compose `image: gvenzl/oracle-xe:21-slim`)
 Alternatively you can download image and specify it as image in docker-compose

 - Also make sure that script are executable (eg. `chmod +x init-scripts/init-oracle.sh` )
 - To connect as SYS: `sqlplus sys/your_sys_password@XEPDB1 as sysdba`