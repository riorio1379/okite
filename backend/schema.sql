-- 二人の掟：共有テーブル（Supabase SQL Editor で1回だけ実行）
-- 公開キーは誰でも手に入る前提なので、ポリシーは「この1行だけ・サイズ上限つき」に絞る。
create table if not exists public.okite_state (
  id text primary key,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

alter table public.okite_state enable row level security;

drop policy if exists okite_sel on public.okite_state;
drop policy if exists okite_ins on public.okite_state;
drop policy if exists okite_upd on public.okite_state;

create policy okite_sel on public.okite_state for select to anon, authenticated
  using (id = 'okite-momoka-rio-9f3c71');

create policy okite_ins on public.okite_state for insert to anon, authenticated
  with check (id = 'okite-momoka-rio-9f3c71' and pg_column_size(data) < 400000);

create policy okite_upd on public.okite_state for update to anon, authenticated
  using (id = 'okite-momoka-rio-9f3c71')
  with check (id = 'okite-momoka-rio-9f3c71' and pg_column_size(data) < 400000);
