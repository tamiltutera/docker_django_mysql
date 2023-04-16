# Use an official Python runtime as a parent image
FROM python:3.9

ARG APP_PORT


ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
# Set the working directory to /code
WORKDIR /code

COPY requirements.txt requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

COPY . /code

# Run migrations
RUN python manage.py makemigrations && python manage.py migrate

# Expose port 8000 for the Django app
EXPOSE $APP_PORT

CMD [ "python","manage.py","runserver","0.0.0.0:8000" ]

