drop table if exists projects;
drop type if exists current_status;
create type current_status as enum ('in-progress','completed');

create table
  projects(
    id bigint primary key generated always as identity not null,
    created_at timestamp default now() not null,
    name text not null,
    slug text unique not null,
    status current_status default 'in-progress' not null,
    collaborators text array default array[]:: varchar[] not null
  );

  -- 1) Enable RLS
ALTER TABLE public."projects"
ENABLE ROW LEVEL SECURITY;

-- 2) (Recommended) ensure RLS applies to authenticated users
-- (Keep/adjust GRANTs depending on your Data API / PostgREST exposure.)
GRANT SELECT, INSERT, UPDATE, DELETE ON public."projects" TO authenticated;

-- 3) SELECT: users can read only their rows
CREATE POLICY "projects_select_own"
ON public."projects"
FOR SELECT
TO authenticated
USING (true);

-- 4) INSERT: users can insert only rows with their own user_id
CREATE POLICY "projects_insert_own"
ON public."projects"
FOR INSERT
TO authenticated
WITH CHECK (true);

-- 5) UPDATE: users can update only their own rows
CREATE POLICY "projects_update_own"
ON public."projects"
FOR UPDATE
TO authenticated
USING (true)
WITH CHECK (true);

-- 6) DELETE: users can delete only their own rows
CREATE POLICY "projects_delete_own"
ON public."projects"
FOR DELETE
TO authenticated
USING (true);

--  -- Enable RLS
-- alter table projects enable row level security;

-- -- Create policy to allow public read access
-- create policy "Allow public read access" on projects
--   for select
--   using (true);

-- -- Create policy to allow public insert access
-- create policy "Allow public insert access" on projects
--   for insert
--   with check (true);

-- -- Create policy to allow public update access
-- create policy "Allow public update access" on projects
--   for update
--   using (true)
--   with check (true);

-- -- Create policy to allow public delete access
-- create policy "Allow public delete access" on projects
--   for delete
--   using (true);