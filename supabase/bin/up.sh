#!bin/bash

## Create new project
$PROJ_NAME = $1
supabase projects create $PROJ_NAME --org-id $2 --db-password $3 --region us-east-1

