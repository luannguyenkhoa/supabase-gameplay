#!/bin/bash
source .env

## Generate diffs for migrations
supabase db diff

## Set the remote db
supabase db remote set ${DB_URL}

## Commit changes to remote
supabase db remote commit

## Push changes
supabase db push