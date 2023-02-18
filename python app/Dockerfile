FROM python:3.9
# Allow statements and log messages to immediately appear in the Knative logs
ENV PYTHONUNBUFFERED True

# Copy local code to the container image.
ENV APP_HOME /app
COPY . /app
WORKDIR $APP_HOME
# Install production dependencies.
RUN pip install -r requirements.txt
RUN apt-get update
RUN apt install redis -y 
CMD service redis-server restart && export $(cat env | xargs) && python hello.py
