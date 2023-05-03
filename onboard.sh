#!/usr/bin/bash env

# Clear the terminal completely
printf "\033[3J\033c\033[3J"

# Check for existence of necessary env vars, skip if needed.
[ -n "${DBT_SERVICE_ACCOUNT:-}" ] && [ -n "${DBT_PROJECT:-}" ] && gp sync-done first_time && exit

# Install gum
! command -v gum 1>/dev/null && curl -SsL "https://github.com/charmbracelet/gum/releases/download/v0.10.0/gum_0.10.0_Linux_x86_64.tar.gz" | sudo tar -C /usr/bin -xzf - gum

ask() {
  printf '\n\n'
  declare name="$1" desc="$2" user_input;
  gum format -- "## Enter value of \`${name}\`"
  until user_input="$(gum input --placeholder="${desc}")" && test -n "${user_input}"; do continue; done
  printf 'Executing: gp env %s\n' "$(gp env "${name}=${user_input}")"
}

gum format -- \
  "# Initial environment setup" \
  "See https://github.com/gitpod-samples/template-dbt-bigquery/#connecting-to-bigquery for more info"

ask DBT_SERVICE_ACCOUNT "The content of a valid service account JSON"
ask DBT_PROJECT "The name of your dbt project"
ask DBT_DEV_DATASET "This depends on personal preference, e.g. dbt_dev"
ask DBT_LOCATION "The location of your BigQuery project, i.e. US or EU"

gum format -- \
  "- Now you're all set!" \
  "- Created variables at https://gitpod.io/variables with your inputs." \
  "- You can create a Project and move the variables **if you're setting this up for a team**, see:" \
  "- https://www.gitpod.io/docs/configure/projects/environment-variables#project-specific-environment-variables"

gp sync-done first_time
gum confirm "Do you want to close this terminal?" && exit
