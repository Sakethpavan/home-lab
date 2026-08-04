up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

pull:
	docker compose pull

update:
	docker compose pull
	docker compose up -d

status:
	docker compose ps

restart:
	docker compose restart

clean:
	docker image prune -f
