#!/bin/bash
## Create new project
output=`supabase projects create $1 --org-id $2 --db-password $3 --region ap-southeast-1`
project_url=`echo $output | grep -Eo "(http|https)://[a-zA-Z0-9./?=_%:-]*" | sort -u`
project_id=${project_url##*/}

## Update configs
sed -i -e "s/\(project_id=\).*/\1\"$1\"/" ./supabase/config.toml
## Remove sed file
rm ./supabase/config.toml-e

## Auto fill some env
sp_url="http://supabase_kong_$1:8000"
db_url="postgresql://postgres:$3@db.$project_id.supabase.co:5432/postgres"
api_url="http://$project_id.supabase.co"
sed -i -e "s/\(SP_URL=\).*/\1$sp_url/" \
-e "s/\(API_URL=\).*/\1$api_url/" \
-e "s/\(DB_URL=\).*/\1$db_url/" \
-e "s/\(PROJECT_ID=\).*/\1$project_id/" .env

## Auto fill local
loca_db_url="postgresql://postgres:postgres@localhost:54322/postgres"
loca_api_url="http://localhost:54321"
sed -i -e "s/\(DB_URL=\).*/\1$loca_db_url/" \
-e "s/\(API_URL=\).*/\1$loca_api_url/" .env.local
