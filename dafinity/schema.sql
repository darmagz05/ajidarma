-- DAFINITY database: run in Supabase SQL Editor.
create table if not exists public.dafinity_documents (
 user_id uuid primary key references auth.users(id) on delete cascade,
 payload jsonb not null default '{}'::jsonb,
 revision bigint not null default 0,
 updated_at timestamptz not null default now()
);
alter table public.dafinity_documents enable row level security;
revoke all on public.dafinity_documents from anon;
revoke all on public.dafinity_documents from authenticated;
grant select, insert, update on public.dafinity_documents to authenticated;
drop policy if exists "dafinity_read_own" on public.dafinity_documents;
create policy "dafinity_read_own" on public.dafinity_documents for select to authenticated using ((select auth.uid())=user_id);
drop policy if exists "dafinity_insert_own" on public.dafinity_documents;
create policy "dafinity_insert_own" on public.dafinity_documents for insert to authenticated with check ((select auth.uid())=user_id);
drop policy if exists "dafinity_update_own" on public.dafinity_documents;
create policy "dafinity_update_own" on public.dafinity_documents for update to authenticated using ((select auth.uid())=user_id) with check ((select auth.uid())=user_id);
create or replace function public.save_dafinity_document(new_payload jsonb, expected_revision bigint)
returns table(new_revision bigint, new_updated_at timestamptz)
language plpgsql security invoker set search_path = ''
as $$
declare v_uid uuid := (select auth.uid());
begin
 if v_uid is null then raise exception 'LOGIN_REQUIRED'; end if;
 if expected_revision=0 then
  insert into public.dafinity_documents(user_id,payload,revision)
   values(v_uid,new_payload,1)
   on conflict(user_id) do nothing
   returning revision,updated_at into new_revision,new_updated_at;
 else
  update public.dafinity_documents
   set payload=new_payload,revision=revision+1,updated_at=now()
   where user_id=v_uid and revision=expected_revision
   returning revision,updated_at into new_revision,new_updated_at;
 end if;
 if new_revision is null then raise exception 'DAFINITY_CONFLICT'; end if;
 return next;
end;
$$;
revoke all on function public.save_dafinity_document(jsonb,bigint) from public;
revoke all on function public.save_dafinity_document(jsonb,bigint) from anon;
grant execute on function public.save_dafinity_document(jsonb,bigint) to authenticated;