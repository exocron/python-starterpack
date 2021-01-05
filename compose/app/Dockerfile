# app-base is a common parent image for both dev and prod
# containers. Installing dependencies, copying (not mounting!) source,
# and other tasks required to run your app should be added to this image.
FROM python:alpine AS app-base

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["python", "./main.py"]


# app-dev is an extension of app-base that is designed to run in a development
# environment. This is where you want to make changes such as mounting your
# work directory in and changing the container user to UID 1000
FROM app-base AS app-dev

COPY compose/app/dev-entrypoint.sh /docker-entrypoint.sh
RUN chmod a+x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]


# app-prod is the version of the container that is designed to run
# in production.  Here we're using compileall to create .pyc files then
# switching user to nobody.  If you're feeling more adventurous, you could
# use a bundler like PyInstaller to create a standalone executable, then
# run it in a FROM scratch container.
FROM app-base AS app-prod

RUN python -m compileall /app

USER nobody:nobody
