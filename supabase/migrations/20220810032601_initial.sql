create table if not exists profiles (
    accountID uuid references auth.users not null primary key,
    vipLevel int default 0,
    coins int default 0,
    gems int default 0
);

alter table profiles enable row level security;
create policy "Only owner can see his profile" on profiles for select using (auth.uid() = accountID);
create policy "Only owner can update his profile" on profiles for update using (auth.uid() = accountID);
create policy "Only owner can delete his profile" on profiles for delete using (auth.uid() = accountID);

create table if not exists profiles_public (
    accountID uuid references auth.users not null primary key,
    displayName varchar,
    avatarID int,
    avatarURL varchar,
    tropies int default 0,
    xp int default 0,
    level int default 0
);

alter table profiles_public enable row level security;
create policy "All users can see public profiles" on profiles_public for select
to authenticated, anon
using (true);
create policy "Only owner can update his public profile" on profiles_public for update using (auth.uid() = accountID);
create policy "Only owner can delete his public profile" on profiles_public for delete using (auth.uid() = accountID);

-- Trigger automatically creates a profile entry when a new user signs up via Supabase auth
create function public.handle_new_user()
returns trigger as $$
begin 
    insert into public.profiles (accountID, vipLevel, coins, gems)
    values (new.id, 0, 0, 0);
    return new;
end;
$$ language plpgsql security definer;
create trigger on_auth_user_created
    after insert on auth.users
    for each row execute procedure public.handle_new_user();