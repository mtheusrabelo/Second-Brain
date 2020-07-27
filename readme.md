# Second Brain Project

## Description

This project will be used to store and link memories from my second brain.

## Requirements

- Docker
- Postgres DB

## Usage

Clone this repository:
```
$ git clone git@github.com:matheusrabelo/second-brain.git 
```

Run the following command:
```
$ make run-dev
```

You should be able to see the dashboard at `http://localhost:1337/admin`

## Running the database locally

There is a helper command to run the database locally.

Please set the following required env variables:

`SECOND_BRAIN_DB_DATA_FOLDER`, `SECOND_BRAIN_DB_PORT`, `SECOND_BRAIN_DB_USER`, `SECOND_BRAIN_DB_PASSWORD`, `SECOND_BRAIN_DB`

And then run:
```
$ make run-local-db 
```

## License
MIT

## Author
Matheus Freire Rabelo
