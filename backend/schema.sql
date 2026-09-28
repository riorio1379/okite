-- 二人の掟：共有テーブル
-- Supabase の SQL Editor で1回だけ実行する
create table if not exists public.okite_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.okite_state enable row level security;

drop policy if exists okite_sel on public.okite_state;
drop policy if exists okite_ins on public.okite_state;
drop policy if exists okite_upd on public.okite_state;

create policy okite_sel on public.okite_state for select to anon, authenticated using (true);
create policy okite_ins on public.okite_state for insert to anon, authenticated with check (true);
create policy okite_upd on public.okite_state for update to anon, authenticated using (true) with check (true);
