FROM python:3.8-slim

RUN useradd --home-dir /app cfdns
WORKDIR /app
RUN chown cfdns /app
USER cfdns

ENV POETRY_VIRTUALENVS_CREATE=false
ENV PATH=$PATH:/app/.local/bin

RUN pip install --no-cache-dir poetry

COPY pyproject.toml poetry.lock /app/
COPY README.md /app/
COPY cloudflare_dyndns.py /app/
RUN poetry install --no-dev

ENTRYPOINT ["cloudflare-dyndns"]
