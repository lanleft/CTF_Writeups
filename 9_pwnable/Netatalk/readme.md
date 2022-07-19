# Netatalk

Date Created: May 17, 2021 4:41 PM
Status: 4->5->6

# References

### Some informations about Netatalk

[Netatalk/Netatalk](https://github.com/Netatalk/Netatalk/blob/2e7f3cb25f1f4eb8ee0e5cbec1ed7bd40bca9031/libatalk/dsi/dsi_opensess.c)

[Data Stream Interface - Wikipedia](https://en.wikipedia.org/wiki/Data_Stream_Interface)

### Explained attack by author 0xddaa

[Hitcon ctf 2019 pwn 371 netatalk](https://ddaa.tw/hitconctf_pwn_371_netatalk.html)

### Out of bound write

[Exploiting an 18 Year Old Bug](https://medium.com/tenable-techblog/exploiting-an-18-year-old-bug-b47afe54172)

### Others

[HITCON CTF 2019 Quals](https://balsn.tw/ctf_writeup/20191012-hitconctfquals/#netatalk)

[0xddaa/ctf_challenges](https://github.com/0xddaa/ctf_challenges/tree/master/hitcon2019/netatalk)

[struct - Interpret bytes as packed binary data - Python 3.9.5 documentation](https://docs.python.org/3/library/struct.html)

### Đặt break point tại line xx trong file c

[Debugging with GDB - Set Breaks](https://ftp.gnu.org/old-gnu/Manuals/gdb/html_node/gdb_28.html)

# Netatalk là gì?

`Netatalk` là một open-source linux deamon, cung cấp POSIX-compliant *NIX/ * BSD hệ thống có khả năng chia sẻ các tập tin với các máy tính Apple Macintonsh.

`Apple Filing Protocol` là giao thức mạng độc quyền của Apple để phân phối file qua mạng. Đây là sự thay thế của Apple cho các giao thức Server Message Block (SMB) và Network File System (NFS).

[Wikipedia](https://en.wikipedia.org/wiki/Netatalk)

"Netatalk is a free, open-source implementation of the `Apple Filing Protocol`. It allows Unix-like operating system to serve as file server for `Macintosh` computers. Historically (until release 3.0) `Netatalk` implemented the `AppleTalk` protocol suite, allowing Unix-like operating systems to serve also as print and time servers for Apple Macintosh computers"

> Hiểu một cách đơn giản, `Netatalk` là một ứng dụng giúp chúng ta chia sẻ file qua mạng giữa hệ thống `Ubuntu`  và hệ thống `MacOS` bằng cách cung cấp cùng giao thức `AFP`
> 

# Setup the environment

For Ubuntu18.04 (`Linux ubuntu 4.15.0-20-generic #21-Ubuntu SMP Tue Apr 24 06:16:15 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux`)

- Download source of this version
    
    ```bash
    wget [http://prdownloads.sourceforge.net/netatalk/netatalk-3.1.11.tar.gz](http://prdownloads.sourceforge.net/netatalk/netatalk-3.1.11.tar.gz)
    ```
    
- Extract source
    
    ```bash
    tar -xzf netatalk-3.1.11.tar.gz
    ```
    
- Compile and install
    
    ```bash
    ./configure \
    --with-init-style=debian-systemd \
    --without-libevent \
    --with-cracklib \
    --enable-krbV-uam \
    --with-pam-confdir=/etc/pam.d \
    --with-dbus-daemon=/usr/bin/dbus-daemon \
    --with-dbus-sysconf-dir=/etc/dbus-1/system.d
    
    make
    
    sudo make install
    ```
    
- Start service
    
    ```bash
    # enable and start netatalk service
    sudo systemctl enable netatalk
    sudo systemctl start netatalk
    ```
    
- Check open port of service
    
    ```bash
    # check service started
    sudo systemctl status netatalk.service
    
    # check open port
    sudo ss -nap | grep 548
    ```
    
    ![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled.png)
    
    ![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%201.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%201.png)
    
- Change afp.conf follow challenge gives us
    
    config of this challenge
    
    ```bash
    [Global]
    afp port = 5566
    disconnect time = 0
    max connections = 1000
    sleep time = 0
    ```
    
    setup
    
    ```bash
    sudo nano /usr/local/etc/afp.conf
    
    # change infomation in file configuration of service
    ```
    
- After start netatalk service, the execute file programming will be placed `/usr/local/sbin`
    
    ![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%202.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%202.png)
    
    ![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%203.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%203.png)
    

### Debug afpd

For debugger, I used to `gdb-pwndbg`

Start, I attach to process `afpd` with highest privilege `sudo`  

```bash
# using commandline to run gdb (because I setup env = sudo)
sudo gdb attach 103712
```

And then

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%204.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%204.png)

# Code analysis

After search google, I found that bug in `dsi_opensess.c` [link](https://medium.com/tenable-techblog/exploiting-an-18-year-old-bug-b47afe54172)

Source code from `libatalk/dsi/dsi_opensess.c`

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%205.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%205.png)

Tại sao lại có lỗi ở đây? Nếu chúng ta có thể control được `commands` thì khi đó ta có thể ghi đè được các trường sau `attn_quantum` —> heap overflow

## Vậy hàm `dsi_opensession()` được gọi khi nào?

### Phân tích qua package struct overview

Khi một package DSI được gửi đến server, nó sẽ được parser theo một struct sau:

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%206.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%206.png)

Trường `commands` sẽ có một vài giá trị mà client có thể sử dụng để gọi đến những ứng dụng cấp từ server của `netatalk` như bảng dưới đây:

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%207.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%207.png)

Vậy nên, nếu chúng ta request một `dsi package` với `commands==4` thì khi đó trên server `netatalk` sẽ đi vào hàm `dsi_opensession.c`

### Phân tích qua source code của netatalk

Chương trình sử dụng `multi-proess` handling khi client request, mỗi client khi request đến chương trình sẽ `fork()` một sub-process.

Với mỗi client khi request tới server, yêu cầu mở một session mới:

```c
for (int i = 0; i < asev->used; i++) {
if (asev->fdset[i].revents & (POLLIN | POLLERR | POLLHUP | POLLNVAL)) {
switch (asev->data[i].fdtype) {

case LISTEN_FD:
    if ((child = dsi_start(&obj, (DSI *)(asev->data[i].private), server_children))) {
        if (!(asev_add_fd(asev, child->afpch_ipc_fd, IPC_FD, child))) {
            LOG(log_error, logtype_afpd, "out of asev slots");

            /*
                * Close IPC fd here and mark it as unused
                */
            close(child->afpch_ipc_fd);
            child->afpch_ipc_fd = -1;

            /*
                * Being unfriendly here, but we really
                * want to get rid of it. The 'child'
                * handle gets cleaned up in the SIGCLD
                * handler.
                */
            kill(child->afpch_pid, SIGKILL);
        }
    }
    break;

case IPC_FD:
    child = (afp_child_t *)(asev->data[i].private);
    LOG(log_debug, logtype_afpd, "main: IPC request from child[%u]", child->afpch_pid);

    if (ipc_server_read(server_children, child->afpch_ipc_fd) != 0) {
        if (!(asev_del_fd(asev, child->afpch_ipc_fd))) {
            LOG(log_error, logtype_afpd, "child[%u]: no IPC fd");
        }
        close(child->afpch_ipc_fd);
        child->afpch_ipc_fd = -1;
    }
    break;

default:
    LOG(log_debug, logtype_afpd, "main: IPC request for unknown type");
    break;
```

Chương trình sẽ gọi đến hàm `dsi_start` để mở một sub-process 

```c
static afp_child_t *dsi_start(AFPObj *obj, DSI *dsi, server_child_t *server_children)
{
    afp_child_t *child = NULL;

    if (dsi_getsession(dsi, server_children, obj->options.tickleval, &child) != 0) {
        LOG(log_error, logtype_afpd, "dsi_start: session error: %s", strerror(errno));
        return NULL;
    }

    /* we've forked. */
    if (child == NULL) {
        configfree(obj, dsi);
        afp_over_dsi(obj); /* start a session */
        exit (0);
    }

    return child;
}
```

```c
switch (pid = dsi->proto_open(dsi)) { /* in libatalk/dsi/dsi_tcp.c */
  case -1:
    /* if we fail, just return. it might work later */
    LOG(log_error, logtype_dsi, "dsi_getsess: %s", strerror(errno));
    return -1;

  case 0: /* child. mostly handled below. */
    break;
```

Sử dụng data request từ client, server parse theo struct qua hàm sau:

```c
/*!
 * Read DSI command and data
 *
 * @param  dsi   (rw) DSI handle
 *
 * @return    DSI function on success, 0 on failure
 */
int dsi_stream_receive(DSI *dsi)
{
  char block[DSI_BLOCKSIZ];

  LOG(log_maxdebug, logtype_dsi, "dsi_stream_receive: START");

  if (dsi->flags & DSI_DISCONNECTED)
      return 0;

  /* read in the header */
  if (dsi_buffered_stream_read(dsi, (uint8_t *)block, sizeof(block)) != sizeof(block)) 
    return 0;

  dsi->header.dsi_flags = block[0];
  dsi->header.dsi_command = block[1];

  if (dsi->header.dsi_command == 0)
      return 0;

  memcpy(&dsi->header.dsi_requestID, block + 2, sizeof(dsi->header.dsi_requestID));
  memcpy(&dsi->header.dsi_data.dsi_doff, block + 4, sizeof(dsi->header.dsi_data.dsi_doff));
  dsi->header.dsi_data.dsi_doff = htonl(dsi->header.dsi_data.dsi_doff);
  memcpy(&dsi->header.dsi_len, block + 8, sizeof(dsi->header.dsi_len));

  memcpy(&dsi->header.dsi_reserved, block + 12, sizeof(dsi->header.dsi_reserved));
  dsi->clientID = ntohs(dsi->header.dsi_requestID);
  
  /* make sure we don't over-write our buffers. */
  dsi->cmdlen = MIN(ntohl(dsi->header.dsi_len), dsi->server_quantum);

  /* Receiving DSIWrite data is done in AFP function, not here */
  if (dsi->header.dsi_data.dsi_doff) {
      LOG(log_maxdebug, logtype_dsi, "dsi_stream_receive: write request");
      dsi->cmdlen = dsi->header.dsi_data.dsi_doff;
  }

  if (dsi_stream_read(dsi, dsi->commands, dsi->cmdlen) != dsi->cmdlen)
    return 0;

  LOG(log_debug, logtype_dsi, "dsi_stream_receive: DSI cmdlen: %zd", dsi->cmdlen);

  return block[1];
}
```

Hàm `dsi_stream_receive` sẽ đọc data truyền vào một `block` sau đó parse vào `dsi_header` , `clientID` , `cmdlen` và `commands`

Để đảm bảo data được copy vào `dsi->commands` không bị overflow, chương trình sẽ lấy giá trị nhỏ hơn của `dsi->header.dsi_len` và `dsi->server_quantum` . Mà giá trị define bạn đầu của `servquant` như sau:

```c
#define DSI_SERVQUANT_MIN   32000       /* minimum server quantum */
#define DSI_SERVQUANT_DEF   0x100000L   /* default server quantum (1 MB) */
```

Vậy nên `dsi_len` trong pakage mà ta request đến server phải có giá trị `>32000`  

Struct của `DSI block`:

```c
#define DSI_BLOCKSIZ 16
struct dsi_block {
    uint8_t dsi_flags;       /* packet type: request or reply */
    uint8_t dsi_command;     /* command */
    uint16_t dsi_requestID;  /* request ID */
    union {
        uint32_t dsi_code;   /* error code */
        uint32_t dsi_doff;   /* data offset */
    } dsi_data;
    uint32_t dsi_len;        /* total data length */
    uint32_t dsi_reserved;   /* reserved field */
};
```

Struct của `DSI`:

```c
/* child and parent processes might interpret a couple of these
 * differently. */
typedef struct DSI {
    struct DSI *next;             /* multiple listening addresses */
    AFPObj   *AFPobj;
    int      statuslen;
    char     status[1400];
    char     *signature;
    struct dsi_block        header;
    struct sockaddr_storage server, client;
    struct itimerval        timer;
    int      tickle;            /* tickle count */
    int      in_write;          /* in the middle of writing multiple packets,
                                   signal handlers can't write to the socket */
    int      msg_request;       /* pending message to the client */
    int      down_request;      /* pending SIGUSR1 down in 5 mn */

    uint32_t attn_quantum, datasize, server_quantum;
    uint16_t serverID, clientID;
    uint8_t  *commands; /* DSI recieve buffer */
    uint8_t  data[DSI_DATASIZ];    /* DSI reply buffer */
    size_t   datalen, cmdlen;
    off_t    read_count, write_count;
    uint32_t flags;             /* DSI flags like DSI_SLEEPING, DSI_DISCONNECTED */
    int      socket;            /* AFP session socket */
    int      serversock;        /* listening socket */

    /* DSI readahead buffer used for buffered reads in dsi_peek */
    size_t   dsireadbuf;        /* size of the DSI readahead buffer used in dsi_peek() */
    char     *buffer;           /* buffer start */
    char     *start;            /* current buffer head */
    char     *eof;              /* end of currently used buffer */
    char     *end;

#ifdef USE_ZEROCONF
    char *bonjourname;      /* server name as UTF8 maxlen MAXINSTANCENAMELEN */
    int zeroconf_registered;
#endif

    /* protocol specific open/close, send/receive
     * send/receive fill in the header and use dsi->commands.
     * write/read just write/read data */
    pid_t  (*proto_open)(struct DSI *);
    void   (*proto_close)(struct DSI *);
} DSI;
```

Trong hàm `dsi_opensession()`:

```c
/* OpenSession. set up the connection */
void dsi_opensession(DSI *dsi)
{
  uint32_t i = 0; /* this serves double duty. it must be 4-bytes long */
  int offs;

  if (setnonblock(dsi->socket, 1) < 0) {
      LOG(log_error, logtype_dsi, "dsi_opensession: setnonblock: %s", strerror(errno));
      AFP_PANIC("setnonblock error");
  }

  /* parse options */
  while (i < dsi->cmdlen) {
    switch (dsi->commands[i++]) {
    case DSIOPT_ATTNQUANT:
      memcpy(&dsi->attn_quantum, dsi->commands + i + 1, dsi->commands[i]);
      dsi->attn_quantum = ntohl(dsi->attn_quantum);

    case DSIOPT_SERVQUANT: /* just ignore these */
    default:
      i += dsi->commands[i] + 1; /* forward past length tag + length */
      break;
    }
  }
```

Để đến được dòng code `vulnerability` thì `dsi->command[i++]` phải là `DSI_ATTNQUANT`

Theo define:

```c
/* DSI session options */
#define DSIOPT_SERVQUANT 0x00   /* server request quantum */
#define DSIOPT_ATTNQUANT 0x01   /* attention quantum */
#define DSIOPT_REPLCSIZE 0x02   /* AFP replaycache size supported by the server (that's us) */
```

Debugging

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%208.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%208.png)

Bug & fixbug

```bash
pwndbg> print *dsi
value of type `DSI' requires 67432 bytes, which is more than max-value-size

pwndbg> set max-value-size 67433
pwndbg> print *dsi
```

After that

```bash
tickle = 0,
  in_write = 0,
  msg_request = 0,
  down_request = 0,
  attn_quantum = 2863311530,
  datasize = 2863311530,
  server_quantum = 2863311530,
  serverID = 43690,
  clientID = 43690,
  commands = 0xdeadbeefcafebabe <error: Cannot access memory at address 0xdeadbeefcafebabe>,
  data = '\000' <repeats 65535 times>,
  datalen = 0,
  cmdlen = 26,
  read_count = 42,
  write_count = 0,
  flags = 0,
  socket = 10,
  serversock = -1,
  dsireadbuf = 12,
  buffer = 0x7fedeb238010 "",
  start = 0x7fedeb238010 "",
  eof = 0x7fedeb238010 "",
  end = 0x7fedebe38010 "",
  bonjourname = 0x0,
  zeroconf_registered = 0,
  proto_open = 0x7fedf4ff2490 <dsi_tcp_open>,
  proto_close = 0x7fedf4ff20f0 <dsi_tcp_close>
}
```

Thật không may, chúng ta chỉ có OOB write với địa chỉ đã biết, và file `afpd` còn enable `PIE`

![Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%209.png](Netatalk%203567d14f0e2c4e89bdc3f463e195b556/Untitled%209.png)

# Stuck in step found address libc -_-

fork() —> memory unchange —> disable ASRL 

### Relationship between fork() with runtimeASLR

[](https://cybersecurity.upv.es/solutions/aslr-ng/ASLRNG-BH-white-paper.pdf?_gclid=5afd2d1c397535.12123939-5afd2d1c3975e5.78570359&_utm_source=xakep&_utm_campaign=mention155231&_utm_medium=inline&_utm_content=lnk879049092195)

Ngâm cứu-ing :<