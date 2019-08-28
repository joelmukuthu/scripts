#!/bin/bash

function hali() {
	curl wttr.in/${1:-Copenhagen}
        curl v2.wttr.in/${1:-Copenhagen}
}
