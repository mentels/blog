.PHONY: db db_cli db_prune

db:
# linebreak
	docker run --name blog_db --rm -p $$DB_PORT:5432 -e POSTGRES_DB=$$DB_NAME -e POSTGRES_USER=$$DB_USERNAME -e POSTGRES_PASSWORD=$$DB_PASSWORD -v `pwd`/postgres_data/:/var/lib/postgresql/data postgres:13-alpine

db_cli:
	docker exec -it blog_db psql -U $$DB_PASSWORD $$DB_NAME

db_prune:
	rm -r ./postgres_data


.PHONY: im

im:
	iex -S mix