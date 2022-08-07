#!/bin/bash
# Созданим переменные с ip адресом
appserver=$(yc compute instance list --folder-id=$YC_FOLDER_ID | grep "reddit-app" | awk '{print $10}')
dbserver=$(yc compute instance list --folder-id=$YC_FOLDER_ID | grep "reddit-app" | awk '{print $10}')

#Условие с параметром "--list"
if [ "$1" == "--list" ]; then
cat<< EOF
{
   "_meta": {
        "hostvars": {
            "appserver": {
                "ansible_host": "$appserver"
            },
            "dbserver": {
                "ansible_host": "$dbserver"
            }
        }
    },
    "all": {
        "children": [
            "app",
            "db",
            "ungrouped"
        ]
    },
    "app": {
        "hosts": [
            "appserver"
        ]
    },
    "db": {
        "hosts": [
            "dbserver"
        ]
    }
}
EOF
elif [ "$1" == "--host" ]; then
  echo '{"_meta": {hostvars": {}}}'
else
  echo "{ }"
fi
