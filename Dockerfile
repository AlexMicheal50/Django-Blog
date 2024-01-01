FROM ubuntu

WORKDIR /app

COPY . /app

RUN apt-get update && \
    apt-get install -y python3 python3-pip && \
    pip install -r requirements.txt && \
# Comment the below if you do not need to create and apply database table
    python3 manage.py makemigrations && \
    python3 manage.py migrate


ENTRYPOINT ["python3"]
CMD ["manage.py", "runserver", "0.0.0.0:8000"]
