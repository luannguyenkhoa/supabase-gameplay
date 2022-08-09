import { createClient } from '@supabase/supabase-js'

const options = {
    schema: 'public',
    headers: { 'x-my-custom-header': 'my-app-name' },
    autoRefreshToken: true,
    persistSession: true,
    detectSessionInUrl: true
}

export const supabaseClient = createClient(
    Deno.env.get("API_URL") ?? "",
    Deno.env.get("ANON_KEY") ?? "",
    options
)

export const supabaseAdmin = createClient(
    Deno.env.get("API_URL") ?? "",
    Deno.env.get("SERVICE_ROLE_KEY") ?? "",
    options
)
