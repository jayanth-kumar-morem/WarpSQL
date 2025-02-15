#!/usr/bin/env bash

# We have to use the Bitnami configuration variable to add TimescaleDB, Citus to
# the shared preload list, or else it gets overwritten.
if [ -z "$POSTGRESQL_SHARED_PRELOAD_LIBRARIES" ]
then
    POSTGRESQL_SHARED_PRELOAD_LIBRARIES="citus,timescaledb,zombodb,pg_repack,pgautofailover,hll"
else
    POSTGRESQL_SHARED_PRELOAD_LIBRARIES="citus,timescaledb,zombodb,pg_repack,pgautofailover,hll,$POSTGRESQL_SHARED_PRELOAD_LIBRARIES"
fi
export POSTGRESQL_SHARED_PRELOAD_LIBRARIES

# Fall through to the original entrypoint. Note that we use exec here because
# this wrapper script shouldn't change PID 1 of the container.
exec /opt/bitnami/scripts/postgresql/entrypoint.sh "$@"
