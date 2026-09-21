create table if not exists public.profile (
 id bigint primary key check (id = 1),
 name text not null default 'Your Name',
 tagline text not null default 'Your identity. Your story. Your own space on the internet.',
 photo text not null default '',
 about text not null default '',
 contact jsonb not null default '[]'::jsonb,
 writing jsonb not null default '[]'::jsonb,
 projects jsonb not null default '[]'::jsonb,
 achievements jsonb not null default '[]'::jsonb,
 gallery jsonb not null default '[]'::jsonb
);
insert into public.profile (id) values (1) on conflict (id) do nothing;
alter table public.profile enable row level security;
drop policy if exists "Public can read profile" on public.profile;
create policy "Public can read profile" on public.profile for select using (true);
drop policy if exists "Authenticated owner can update profile" on public.profile;
create policy "Authenticated owner can update profile" on public.profile for update to authenticated using (true) with check (true);
drop policy if exists "Authenticated owner can insert profile" on public.profile;
create policy "Authenticated owner can insert profile" on public.profile for insert to authenticated with check (id = 1);
