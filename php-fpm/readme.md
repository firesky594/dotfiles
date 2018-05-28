# Open File
```
echo `ulimit -HSn 65536` >> /etc/profile
echo `ulimit -HSn 65536` >> /etc/rc.local
source /etc/profile 
```
# Open File2
```
vim /etc/security/limits.conf
* soft nofile 51200
* hard nofile 51200
```
# Replace php-fpm.conf
```
pm=static
pm.max_children=200
pm.max_requests = 5000

request_terminate_timeout = 0
request_slowlog_timeout = 10s
slowlog = log/$pool.log.slow
rlimit_files = 1024

```



