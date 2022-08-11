#!/bin/bash
source .env
supabase link --project-ref ${PROJECT_ID}

# Export the secrets from env file
supabase secrets set --env-file .env

## Generate diffs for migrations
supabase db diff

## Set the remote db
supabase db remote changes

## Commit changes to remote
supabase db remote commit

## Push changes
supabase db push