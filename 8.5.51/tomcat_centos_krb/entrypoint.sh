#!/bin/bash
crond
sed -i s/4096/16384/g /etc/security/limits.d/20-nproc.conf

#clean log
rm -rf /usr/local/tomcat/logs/*


#add host
cat>>/etc/hosts<<EOF
133.38.39.224 scdckb1
133.38.39.225 scdcam1
133.38.35.110 passnn1
133.38.35.111 passnn2
133.38.35.112 passfs1
133.38.35.113 passfs2
133.38.35.114 passdn1
133.38.35.115 passdn2
133.38.35.116 passdn3
133.38.35.117 passdn4
133.38.35.118 passdn5
133.38.35.60 paaskafka1
133.38.35.61 paaskafka2
133.38.35.62 paaskafka3
133.38.35.63 paaskafka4
133.38.35.64 paaskafka5
133.38.39.215 sces001
133.38.39.216 sces002
133.38.39.217 sces003
133.38.39.218 sces004
133.38.39.219 sces005
133.38.39.226 sces006
133.38.39.227 sces007
133.38.39.228 sces008
133.38.39.229 sces009
133.38.39.230 sces010
133.38.39.220 scdcnn1
133.38.39.221 scdcnn2


EOF

exec "$@"
