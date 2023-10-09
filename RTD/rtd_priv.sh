RTD='https://readthedocs.org'
project_slug='rtd-github-sync'

set +e

#GITHUB_REPO
#default_branch=$(wget -q -O - "https://api.github.com/repos/mtszc/rtd-github-sync" | sed -nE 's/^\s+"default_branch": "([^"]+).+$/\1/p' | awk 'NR==1')

#GITLAB_REPO
default_branch=$(wget -q -O - "https://gitlab.com/api/v4/projects/$GITLAB_ID" --header="PRIVATE-TOKEN: $GITLAB_TOKEN" | sed 's/.*"default_branch":"\([^"]*\)".*/\1/')

#echo "{\"default_branch\": \"$default_branch\"}" > body.json

#wget --method=PATCH --header="Authorization: Token $RTD_TOKEN" --header="Content-Type: application/json" --body-file=body.json $RTD/api/v3/projects/$project_slug/

wget --method=PATCH --header="Authorization: Token $RTD_TOKEN" --header="Content-Type: application/json" --body-data="{\"default_branch\": \"$default_branch\"}" $RTD/api/v3/projects/$project_slug/

wget --no-check-certificate --post-data="" --header="Authorization: Token $RTD_TOKEN" -q $RTD/api/v3/projects/$project_slug/versions/latest/builds/

#wget --method=PATCH --header="Authorization: Token $RTD_TOKEN" --header="Content-Type: application/json" --body-file=body.json https://readthedocs.org/api/v3/projects/rtd-github-sync/
