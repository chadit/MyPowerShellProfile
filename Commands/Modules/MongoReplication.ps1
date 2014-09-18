cls
#start powershell -noexit -command
# cmd /c start powershell -noexit -command "get-date"

$mongoDbPath = "C:\MongoDB\bin\mongod.exe"
& cmd /c start "a" powershell -noexit -command $mongoDbPath --dbpath "C:\MongoDB\bin\ReplicaTest\db1" --port 40000 --replSet "repdemo"
& cmd /c start "b" powershell -noexit -command $mongoDbPath --dbpath "C:\MongoDB\bin\ReplicaTest\db2" --port 40100 --replSet "repdemo"
& cmd /c start "c" powershell -noexit -command $mongoDbPath --dbpath "C:\MongoDB\bin\ReplicaTest\db3" --port 40200 --replSet "repdemo"
& cmd /c start "d" powershell -noexit -command $mongoDbPath --dbpath "C:\MongoDB\bin\ReplicaTest\db4" --port 40300 --replSet "repdemo"
# & cmd /c start "a" C:\MongoDB\bin\mongod.exe --dbpath "C:\MongoDB\bin\ReplicaTest\db1" --port 40000 --replSet "repdemo" -ArgumentList "Server a"

start "a" C:\MongoDB\bin\mongod.exe --dbpath "C:\MongoDB\bin\ReplicaTest\db1" --port 40000 --replSet "repdemo"
start "b" C:\MongoDB\bin\mongod.exe --dbpath "C:\MongoDB\bin\ReplicaTest\db2" --port 40100 --replSet "repdemo"
start "c" C:\MongoDB\bin\mongod.exe --dbpath "C:\MongoDB\bin\ReplicaTest\db3" --port 40200 --replSet "repdemo"
start "d" C:\MongoDB\bin\mongod.exe --dbpath "C:\MongoDB\bin\ReplicaTest\db4" --port 40300 --replSet "repdemo"
