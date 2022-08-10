# Supabase with Edge Functions Project Generator Template

## What are Supabase Edge Functions?

[Supabase Edge Functions](https://supabase.com/edge-functions) are written in TypeScript, run via Deno, and deployed with the Supabase CLI. Please [download](https://github.com/supabase/cli#install-the-cli) the latest version of the Supabase CLI, or [upgrade](https://github.com/supabase/cli#install-the-cli) it if you have it already installed.

## Setup

### Supabase CLI

- `Docker` is required to run Supabase locally
- Following the [guide](https://supabase.com/docs/reference/cli/installing-and-updating) to install
- Initialize Supabase CLI:
    - Login: `supabase login`
    - Grant permission for up file: `chmod -R +x bin`
    - Up the env: `./bin/up.sh <project_name> <org_id> <db_password>` -> save the project id from output
- Replace `project_name` with `project_id` in `config.toml`
- Adding Facebook/Google `APP ID` and `secret` key to `config.toml` at `client_id` and `secret` fields respectively
- Create 2 env files: `.env.local` and `.env` resprenting for `local` and `prod`, add these variables into:
    ```
    SP_URL=http://supabase_kong_<project_name>:8000
    DB_URL=xxxxx
    ANON_KEY=xxxxx
    SERVICE_ROLE_KEY=xxxxx
    ```
    Note: Replace `<project_name>` with your project_name created above.
- Start Supabase instance in local: `supabase start`, copy the output:
    - Replace *ANON_KEY* and *SERVICE_ROLE_KEY* values to corresponding fields in .env files
    - For DB_URL field in `.env.local`, just replace the value from output to `.env.local`
    - Prod `.env` *DB_URL=postgresql://postgres:<db_password>@db.<project-id>.supabase.co:5432/postgres*: <project-id>

- Deploy the project

- Local deployment for edge functions testing:
    - Serve a function: `supabase functions serve <function-name>`
- 
