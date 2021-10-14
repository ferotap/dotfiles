FROM python:3.8-slim as base-python

FROM base-python as poetry-exporter
WORKDIR .
RUN pip install poetry==1.0.5
COPY pyproject.toml .
RUN poetry export -f requirements.txt -o requirements.txt

FROM base-python AS base-server
COPY --from=poetry-exporter ./requirements.txt .
RUN pip install -r requirements.txt
CMD bash
