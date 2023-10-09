RTD="https://readthedocs.org"
project_slug='rtd-github-sync'

set +e
default_branch=$(wget --header="Authorization: Token $RTD_TOKEN" -q "$RTD/api/v3/projects/$project_slug/" | sed -n 's/.*"default_branch": "\(.*\)",/\1/p')
echo $default_branch
#wget --no-check-certificate --post-data='{"branch": "main"}' --header="Authorization: Token $RTD_TOKEN" -q $RTD/api/v3/projects/$project_slug/versions/latest/builds/
wget --no-check-certificate --post-data='{"repository": {"branch": "main"}}' --header="Authorization: Token $RTD_TOKEN" -q $RTD/api/v3/projects/$project_slug/versions/latest/builds/

wget --header="Authorization: Token $RTD_TOKEN" -q "https://readthedocs.org/api/v3/projects/rtd-github-sync/"

wget --method=PATCH --header="Authorization: Token $RTD_TOKEN" --header="Content-Type: application/json" --body-file="{\"default_branch\": \"$default_branch\"}" https://readthedocs.org/api/v3/rtd-github-sync/

#{"default_branch": "main"}

wget --no-check-certificate --post-data="" --header="Authorization: Token $RTD_TOKEN" -q https://readthedocs.org/api/v3/projects/rtd-github-sync/versions/latest/builds/

wget -q -O - "https://api.github.com/repos/mtszc/rtd-github-sync" | sed -nE 's/^\s+"default_branch": "([^"]+).+$/\1/p'

wget -q -O - "https://api.github.com/repos/mtszc/rtd-github-sync" | sed -nE 's/^\s+"default_branch": "([^"]+).+$/\1/p' | awk 'NR==1'

wget -q -O - "https://gitlab.com/api/v4/projects/$GITLAB_ID" --header="PRIVATE-TOKEN: glpat-YQwwkpscr7ysZExVCy_F" | sed 's/.*"default_branch":"\([^"]*\)".*/\1/'

wget -q -O - "https://gitlab.com/api/v4/projects/$GITLAB_ID" --header="PRIVATE-TOKEN: glpat-YQwwkpscr7ysZExVCy_F" | sed 's/.*"default_branch":"\([^"]*\)".*/\1/' | awk 'NR==1'
