#include <stdio.h>
#include <stdlib.h>
#include <libpq-fe.h>

static void finish_with_error(PGconn *conn, const char *context)
{
    fprintf(stderr, "%s: %s\n", context, PQerrorMessage(conn));
    PQfinish(conn);
    exit(EXIT_FAILURE);
}

int main(void)
{
    const char *conninfo = getenv("PG_CONNINFO");
    if (conninfo == NULL) {
        conninfo = "host=localhost port=5432 dbname=university user=uni password=uni_password";
    }

    PGconn *conn = PQconnectdb(conninfo);
    if (PQstatus(conn) != CONNECTION_OK) {
        finish_with_error(conn, "Connection failed");
    }

    PGresult *result = PQexec(conn,
        "SELECT e.last_name, e.position, t.name "
        "FROM employees e JOIN teams t ON t.team_id = e.team_id "
        "ORDER BY e.last_name");

    if (PQresultStatus(result) != PGRES_TUPLES_OK) {
        PQclear(result);
        finish_with_error(conn, "Query failed");
    }

    for (int row = 0; row < PQntuples(result); row++) {
        printf("%s works as %s in %s\n",
            PQgetvalue(result, row, 0),
            PQgetvalue(result, row, 1),
            PQgetvalue(result, row, 2));
    }

    PQclear(result);
    PQfinish(conn);
    return EXIT_SUCCESS;
}
