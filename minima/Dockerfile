FROM python:3.9.12-alpine

WORKDIR /src
COPY src/ .

RUN pip install -r requirements.txt
RUN crontab crontab

CMD ["crond", "-f"]