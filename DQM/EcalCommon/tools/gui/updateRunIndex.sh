#!/bin/sh

ulimit -c 0

cd ${HOME}/DQM/dqm-GUI

LD_LIBRARY_PATH=
source rpms/cmsset_default.sh
source rpms/slc4_ia32_gcc345/cms/dqmgui/5.1.4/etc/profile.d/env.sh

if [ -e /tmp/updateRunIndex.lock ]; then
  echo "Lock file is present, exit"
  exit 1
fi

touch /tmp/updateRunIndex.lock

echo "Index update: begin"

./visDQMImport /data/ecalod-disk01/dqm-GUI/idx /data/ecalod-disk01/dqm-data/root

echo "Index update: end"

rm /tmp/updateRunIndex.lock

exit 0

