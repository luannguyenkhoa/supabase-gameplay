// Follow this setup guide to integrate the Deno language server with your editor:
// https://deno.land/manual/getting_started/setup_your_environment
// This enables autocomplete, go to definition, etc.

import { serve } from 'https://deno.land/std@0.131.0/http/server.ts'
import { supabaseClient, supabaseAdmin } from '../_shared/supabaseClient.ts'
import { corsHeaders } from '../_shared/cors.ts'

console.log('Hello from Functions!')

serve(async (req) => {
  const body = await req.json()

  // HTTP Method validation
  if (req.method == 'OPTIONS') {
    return new Response('ok', { headers: corsHeaders })
  }

  // Set the Auth context of the user that called the function.
  // This way your row-level-security (RLS) policies are applied.
  supabaseClient.auth.setAuth(req.headers.get('Authorization')!.replace('Bearer ', ''))
  
  const { data, error } = await supabaseClient.from('profiles_public').insert(body)
  console.log({ data, error })
  
  if (error) {
    return new Response(JSON.stringify(error), { status: 400 })
  }
  return new Response(JSON.stringify(data), { status: 200 },)
})

// To invoke:
// curl -i --location --request POST 'http://localhost:54321/functions/v1/' \
//   --header 'Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24ifQ.625_WdcF3KHqz5amU0x2X5WWHP-OEs_4qj0ssLNHzTs' \
//   --header 'Content-Type: application/json' \
//   --data '{"name":"Functions"}'
