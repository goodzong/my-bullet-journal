-- 불렛저널 데이터 테이블: 각 사용자가 자신의 항목만 읽고 쓸 수 있게 합니다.
create table if not exists public.bj_data (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  key text not null,
  value text,
  updated_at timestamptz not null default now(),
  primary key (user_id, key)
);

alter table public.bj_data enable row level security;

create policy "Users manage their own rows"
  on public.bj_data
  for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
