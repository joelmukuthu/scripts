#!/bin/bash

function hali() {
	curl wttr.in/${1:-Copenhagen}
}
