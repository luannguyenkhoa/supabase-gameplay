#!/bin/bash
export `paste -d -s .env.local`
supabase start