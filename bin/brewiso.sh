#!/usr/bin/env bash
leaves=($(brew leaves 2>/dev/null))
(( ${#leaves[@]} )) || { echo 'No unused package for brew.'; exit 0; }
for package in "${leaves[@]}"; do
    [[ -z $(brew deps ${package} 2>/dev/null) ]] && echo "${package}"
done
