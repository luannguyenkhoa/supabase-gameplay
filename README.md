# Supabase with Edge Functions Project Generator Template

## What are Supabase Edge Functions?

[Supabase Edge Functions](https://supabase.com/edge-functions) are written in TypeScript, run via Deno, and deployed with the Supabase CLI. Please [download](https://github.com/supabase/cli#install-the-cli) the latest version of the Supabase CLI, or [upgrade](https://github.com/supabase/cli#install-the-cli) it if you have it already installed.

## Setup

- Editor: Visual Studio Code + Deno extension
### Supabase CLI

- `Docker` is required to run Supabase locally
- Following the [guide](https://supabase.com/docs/reference/cli/installing-and-updating) to install
- Initialize Supabase CLI:
    - Login: `supabase login`
    - Grant permission for up file: `chmod -R +x bin`
    - Find <org_id>: `supabase orgs list`
    - Up the env: `./bin/up.sh <project_name> <org_id> <db_password>` -> save the last part as the project id from output: https://app.supabase.com/project/xxxx
- Replace `project_name` with `project_id` in `config.toml`
- Adding Facebook/Google `APP ID` and `secret` key to `config.toml` at `client_id` and `secret` fields respectively
- Update `site_url` to `app-url-scheme` for callback if aiming to integrate this supabase app for the applications
- Create 2 env files: `.env.local` and `.env` representing for `local` and `prod`, add these variables into:
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
    - Prod `.env` *DB_URL=postgresql://postgres:<db_password>@db.<project-id>.supabase.co:5432/postgres*: replace <project-id> and <db_password> with yours

- Deploy the project: `./bin/deploy.sh`
*Follow up the terminal to enter <db-password> if requested*

## Enable Auth with Providers: Google, Facebook,...
- Access site: https://app.supabase.com
- Open the preceding project 
- Choose `Settings` on the left menu
- Choose `Authentication`
- Scroll down to find the target provider, click the down arrow to expand
- Switch On -> Enter `Client ID` and `Client Secret`

## Edge Functions development and deployment
- Create a function: `supabase functions new <function-name>`
- Implement the logics inside folder `<function-name>/index.ts` following profiles_public folder
- Serve a function: `supabase functions serve <function-name>`
- Do testing the function by using curl or supabase-js invoke function
- Deploy to cloud: `supabase functions deploy <function-name>`

