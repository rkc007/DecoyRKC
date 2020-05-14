#Build Client
cd client
cd ./c
make
#Build proxy
cd ../../
cd ./proxy/
make center
make single_conn
cd ../
#
