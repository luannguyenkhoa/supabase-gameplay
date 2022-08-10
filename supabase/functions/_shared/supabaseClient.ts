import { createClient } from 'https://esm.sh/@supabase/supabase-js@^1.33.2'

const options = {
    schema: 'public',
    headers: { 'x-my-custom-header': 'supabase' },
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
}

export const supabaseClient = createClient(
    Deno.env.get('SP_URL') ?? '',
    Deno.env.get('ANON_KEY') ?? '',
    options
)

export const supabaseAdmin = createClient(
    Deno.env.get('SP_URL') ?? '',
    Deno.env.get('SERVICE_ROLE_KEY') ?? '',
    options
)
