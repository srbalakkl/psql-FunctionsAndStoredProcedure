--Function In postgresql
create or replace function get_film_count(len_from int, len_to int)
    returns int
    language plpgsql
AS
$$
DECLARE
    film_count int;
Begin
    Select count(*)
    into film_count
    From public.film
    where length between len_from and len_to;
--     return film_count;
end;
$$;

select get_film_count(len_from := 50, len_to := 100);

--Default function OR
--IN function
create or replace function find_film_by_id(p_film_id int)
    returns varchar
    language plpgsql
as
$$
declare
    film_title film.title%type;
begin
    -- find film title by id
    select title
    into film_title
    from film
    where film_id = p_film_id;

    if not found then
        raise 'Film with id % not found', p_film_id;
    end if;

    return film_title;

end;
$$;

select find_film_by_id(133);

--Out Function
create or replace function get_film_stat(
    out min_len int,
    out max_len int,
    out avg_len numeric
)
    language plpgsql
as
$$
BEGIN
    select min(length),
           max(length),
           avg(length)
    into min_len,max_len,avg_len
    from dvdrental.public.film;
end;
$$;

select *
from get_film_stat();

-- inout function
create or replace function swap(
    inout x int,
    inout y int
)
    language plpgsql AS
$$
BEGIN
    select x,y
    into y,x;
END;
$$;


select swap(10,50);

select * from dvdrental.public.rental;