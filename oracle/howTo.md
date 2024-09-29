# Oracle community image
0. copy and change things in .env `copy .env.example .env`
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
3. test connection
4. save and connect


 - Also make sure that script are executable (eg. `chmod +x init-scripts/init-oracle.sh` )
 - To connect as SYS: `sqlplus sys/your_sys_password@XEPDB1 as sysdba`

# Oracle official image
-1. rename `docker-compose-official` to `docker-compose` if you care 
0. mkae the .env file `echo ORACLE_PASSWORD=your_secure_password > .env`
1. login to oracle acc `docker login container-registry.oracle.com`
2. run the docker compose `docker-compose up -d`

## Connect using SQL*PL
3. Run in console
    - login as sysdba `docker-compose exec oracle sqlplus sys/${ORACLE_PASSWORD}@ORCLCDB as sysdba`
    - login as pdb `docker-compose exec oracle sqlplus sys/${ORACLE_PASSWORD}@ORCLPDB1 as sysdba`
## Connect using Oracle SQL Developer
3. add new connection 
```
Hostname: localhost
Port: 1521
Service name: ORCLCDB or ORCLPDB1 (for the pluggable database)
Username: sys
Password: [Your ORACLE_PASSWORD]
Role: SYSDBA
```
4. test connection
5. save and connect