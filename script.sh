#!/bin/bash

curl -X GET https://monolithic.anykey.pl/metrics | grep client_connected
