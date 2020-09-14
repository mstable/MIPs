#!/bin/bash
set -e # halt script on error

HTMLPROOFER_OPTIONS="./_site --internal-domains=mips.mstable.org --check-html --check-opengraph --report-missing-names --log-level=:debug --assume-extension --empty-alt-ignore --timeframe=6w --url-ignore=/MIPS/mip-1,/MCCP/mccp-1,/MCCP/mccp-2"

if [[ $TASK = 'htmlproofer' ]]; then
  bundle exec jekyll doctor
  bundle exec jekyll build
  bundle exec htmlproofer $HTMLPROOFER_OPTIONS --disable-external

  # Validate GH Pages DNS setup
  bundle exec github-pages health-check
elif [[ $TASK = 'htmlproofer-external' ]]; then
  bundle exec jekyll doctor
  bundle exec jekyll build
  bundle exec htmlproofer $HTMLPROOFER_OPTIONS --external_only
elif [[ $TASK = 'mip-validator' ]]; then
  BAD_FILES="$(ls MIPS | egrep -v "mip-[0-9]+.md")" || true
  if [[ ! -z $BAD_FILES ]]; then
    echo "Files found with invalid names:"
    echo $BAD_FILES
    exit 1
  fi

  FILES="$(ls MIPS/*.md | egrep "mip-[0-9]+.md")"
  bundle exec mip_validator $FILES
elif [[ $TASK = 'codespell' ]]; then
  codespell -q4 -I .codespell-whitelist mip-X.md MIPS/
fi
