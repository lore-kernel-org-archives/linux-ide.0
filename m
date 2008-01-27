From: Thomas Evans <evans02472@gmail.com>
Subject: Re: sata_sil24 / Alpha / 4726 PMP issue ..
Date: Sun, 27 Jan 2008 17:50:29 -0500
Message-ID: <479D0AB5.6070203@gmail.com>
References: <4794459C.3090200@gmail.com> <4796DC44.6010100@gmail.com>	 <864c1e490801231622n806b465g88a3f0448b5d8f29@mail.gmail.com>	 <4797ECF3.5000306@gmail.com>	 <864c1e490801231823v3e9cf61ds2a0d553ed5b61fb2@mail.gmail.com>	 <4797F8D0.6060302@gmail.com>	 <864c1e490801231939k6008bc95tf40565a8ef6f430d@mail.gmail.com>	 <47980B71.3000408@gmail.com>	 <864c1e490801240707x31ff53b1s3d72032968e1bcbc@mail.gmail.com>	 <4798AA88.5080107@gmail.com> <864c1e490801240840q5423a1beuf9b4b3a43416db2b@mail.gmail.com> <4798C617.10601@gmail.com> <4798CA71.20707@gmail.com> <4798CC90.4040707@gmail.com> <4798CCDF.9070305@gmail.com> <4798CE10.2050005@gmail.com> <4798D4A2.7030303@gmail.com> <47991AD9.6050804@gmail.com> <47993686.5040405@gmail.com> <479939E3.4020307@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030400070100020003050702"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.243]:34675 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752947AbYA0Wuj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 27 Jan 2008 17:50:39 -0500
Received: by an-out-0708.google.com with SMTP id d31so316262and.103
        for <linux-ide@vger.kernel.org>; Sun, 27 Jan 2008 14:50:36 -0800 (PST)
In-Reply-To: <479939E3.4020307@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>, IDE/ATA development list <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------030400070100020003050702
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit

Tejun and all -

I have a new log - I got somewhat further by setting this bit when 
init'd via HOST_CTRL:

Bit [28]: PERR Rpt Dsbl (R/W) – PERR Report Disable. This bit, when set 
to one, disables reporting of PCI bus
parity errors to the Command Execution State Machine (such errors would 
otherwise cause the state machine to stop
and report an error in the Command Error register).

This causes the PMP device to be noticed, but the first qc command never 
completes.

Please see the log and see if there is anything obvious.

Thanks,

...tom


--------------030400070100020003050702
Content-Type: text/plain;
 name="ds20.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ds20.log"

Linux version 2.6.24-ds20 (root@chronictown) (gcc version 4.1.2 20061115 (prerelease) (Debian 4.1.1-21)) #12 SMP Sun Jan 27 02:47:57 EST 2008
Booting on Tsunami variation Goldrush using machine vector DP264 from SRM
Major Options: SMP LEGACY_START VERBOSE_MCHECK MAGIC_SYSRQ 
Command line: ro root=/dev/sda3
memcluster 0, usage 1, start        0, end      256
memcluster 1, usage 0, start      256, end   130976
memcluster 2, usage 1, start   130976, end   131072
freeing pages 256:384
freeing pages 1257:130976
reserving pages 1257:1259
4096K Bcache detected; load hit latency 20 cycles, load miss latency 115 cycles
Console graphics on hose 0
SMP: 2 CPUs probed -- cpu_present_map = 3
On node 0 totalpages: 130976
  DMA zone: 895 pages used for memmap
  DMA zone: 0 pages reserved
  DMA zone: 130081 pages, LIFO batch:15
  Normal zone: 0 pages used for memmap
  Movable zone: 0 pages used for memmap
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130081
Kernel command line: ro root=/dev/sda3
PID hash table entries: 4096 (order: 12, 32768 bytes)
Using epoch = 2000
Console: colour VGA+ 80x25
console [tty0] enabled
Dentry cache hash table entries: 131072 (order: 7, 1048576 bytes)
Inode-cache hash table entries: 65536 (order: 6, 524288 bytes)
Memory: 1027192k/1047808k available (3073k kernel code, 17888k reserved, 321k data, 160k init)
SLUB: Genslabs=12, HWalign=64, Order=0-2, MinObjects=8, CPUs=2, Nodes=1
Calibrating delay loop... 996.00 BogoMIPS (lpj=486400)
Mount-cache hash table entries: 512
kobject fs: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
SMP starting up secondaries.
Calibrating delay loop... 992.88 BogoMIPS (lpj=484352)
Brought up 2 CPUs
SMP: Total of 2 processors activated (1994.13 BogoMIPS).
CPU0 attaching sched-domain:
 domain 0: span 3
  groups: 1 2
CPU1 attaching sched-domain:
 domain 0: span 3
  groups: 2 1
kobject devices: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject bus: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject class: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject firmware: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
DEV: registering device: ID = 'platform'
kobject platform: registering. parent: <NULL>, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
kobject platform: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/platform'
kobject devices: registering. parent: platform, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: platform, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'platform' registered
kobject system: registering. parent: devices, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
Registering sysdev class 'cpu'
kobject cpu: registering. parent: system, set: system
kobject_uevent_env
fill_kobj_path: path = '/devices/system/cpu'
net_namespace: 120 bytes
kobject kernel: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject uids: registering. parent: kernel, set: kernel
kobject 0: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/0'
kobject debug: registering. parent: <NULL>, set: kernel
kobject_uevent_env
fill_kobj_path: path = '/kernel/debug'
NET: Registered protocol family 16
device class 'pci_bus': registering
kobject pci_bus: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus'
kobject pci: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/pci'
kobject devices: registering. parent: pci, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: pci, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'pci' registered
device class 'tty': registering
kobject tty: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/tty'
device class 'vtconsole': registering
kobject vtconsole: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/vtconsole'
DEV: registering device: ID = 'vtcon0'
kobject vtcon0: registering. parent: vtconsole, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vtconsole/vtcon0'
Registering sys device 'cpu0'
kobject cpu0: registering. parent: <NULL>, set: cpu
kobject_uevent_env
fill_kobj_path: path = '/devices/system/cpu/cpu0'
Registering sys device 'cpu1'
kobject cpu1: registering. parent: <NULL>, set: cpu
kobject_uevent_env
fill_kobj_path: path = '/devices/system/cpu/cpu1'
DEV: registering device: ID = 'pci0000:00'
kobject pci0000:00: registering. parent: <NULL>, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = '0000:00'
kobject 0000:00: registering. parent: pci_bus, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:00'
class_uevent - name = 0000:00
PCI: Scanning bus 0000:00
mk_conf_addr(bus=0 ,device_fn=0x0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe000000
mk_conf_addr(bus=0 ,device_fn=0x8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe000800
mk_conf_addr(bus=0 ,device_fn=0x10, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe001000
mk_conf_addr(bus=0 ,device_fn=0x18, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe001800
mk_conf_addr(bus=0 ,device_fn=0x20, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002000
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002800
mk_conf_addr(bus=0 ,device_fn=0x28, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00280e
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002806
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002806
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe002806
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002808
PCI: Found 0000:00:05.0 [1080/c693] 000601 00
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00283d
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002810
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002810
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002810
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002810
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002814
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002814
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002814
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002814
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002818
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002818
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002818
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002818
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00281c
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00281c
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00281c
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00281c
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002820
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002820
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002820
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002820
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002824
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002824
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002824
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002824
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002830
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002830
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002830
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002830
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00282c
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00282e
PCI: Calling quirk fffffc00007387f0 for 0000:00:05.0
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002900
mk_conf_addr(bus=0 ,device_fn=0x29, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00290e
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002906
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002906
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe002906
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002908
PCI: Found 0000:00:05.1 [1080/c693] 000101 00
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00293d
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00293c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002910
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002910
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002910
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002910
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002914
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002914
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002914
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002914
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002918
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002918
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002918
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002918
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00291c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00291c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00291c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00291c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002924
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002924
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002924
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002924
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002930
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002930
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002930
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002930
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00292c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00292e
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x9, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002909
PCI: Calling quirk fffffc00007387f0 for 0000:00:05.1
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a00
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a0e
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a06
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a06
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a06
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a08
PCI: Found 0000:00:05.2 [1080/c693] 000101 00
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a3d
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a3c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a10
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a10
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a10
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a10
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a14
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a14
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a14
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a14
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a18
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a18
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a18
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a18
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a1c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a1c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a1c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a1c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a24
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a24
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a24
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a24
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a30
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a30
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a30
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a30
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a2c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a2e
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x9, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a09
PCI: Calling quirk fffffc00007387f0 for 0000:00:05.2
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b00
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b0e
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b06
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b06
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b06
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b08
PCI: Found 0000:00:05.3 [1080/c693] 000c03 00
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b3d
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b3c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b14
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b14
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b14
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b14
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b18
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b18
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b18
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b18
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b1c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b1c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b1c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b1c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b20
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b20
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b20
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b20
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b24
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b24
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b24
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b24
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b30
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b30
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b30
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b30
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b2c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b2e
PCI: Calling quirk fffffc00007387f0 for 0000:00:05.3
mk_conf_addr(bus=0 ,device_fn=0x2c, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002c00
mk_conf_addr(bus=0 ,device_fn=0x2d, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002d00
mk_conf_addr(bus=0 ,device_fn=0x2e, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002e00
mk_conf_addr(bus=0 ,device_fn=0x2f, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002f00
mk_conf_addr(bus=0 ,device_fn=0x30, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003000
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003800
mk_conf_addr(bus=0 ,device_fn=0x38, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00380e
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003806
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003834
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x64, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003864
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x65, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003865
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x40, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003840
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x41, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003841
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x54, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003854
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x55, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003855
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003806
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003834
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x64, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003864
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x65, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003865
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x40, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe003840
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x44, pci_addr=0xfffffc003f02bcb0, type1=0xfffffc003f02bca8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003844
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe003806
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x34, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003834
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x64, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003864
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x65, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003865
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x40, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003840
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x41, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003841
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x54, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003854
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x55, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003855
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003808
PCI: Found 0000:00:07.0 [1095/3124] 000180 00
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00383d
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00383c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003824
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003824
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003824
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003824
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003830
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003830
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003830
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe003830
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00382c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00382e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004000
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00400e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004006
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe004034
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdc, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dc
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdd, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dd
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004006
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe004034
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdc, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dc
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdd, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dd
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe004006
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x34, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004034
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdc, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dc
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdd, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dd
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004008
PCI: Found 0000:00:08.0 [1011/0024] 000604 01
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403d
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004010
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004010
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004010
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004010
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004014
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004014
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004014
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004014
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x38, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004038
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x38, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004038
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x38, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004038
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x38, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004038
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004800
mk_conf_addr(bus=0 ,device_fn=0x48, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00480e
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004806
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004806
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe004806
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004808
PCI: Found 0000:00:09.0 [5333/8811] 000300 00
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00483d
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00483c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004814
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004814
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004814
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004814
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004818
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004818
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004818
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004818
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00481c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00481c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe00481c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe00481c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004820
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004820
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004820
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004820
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004824
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004824
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004824
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004824
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004830
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004830
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd01fe004830
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004830
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00482c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00482e
mk_conf_addr(bus=0 ,device_fn=0x50, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe005000
mk_conf_addr(bus=0 ,device_fn=0x58, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe005800
mk_conf_addr(bus=0 ,device_fn=0x60, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe006000
mk_conf_addr(bus=0 ,device_fn=0x68, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe006800
mk_conf_addr(bus=0 ,device_fn=0x70, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe007000
mk_conf_addr(bus=0 ,device_fn=0x78, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe007800
mk_conf_addr(bus=0 ,device_fn=0x80, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe008000
mk_conf_addr(bus=0 ,device_fn=0x88, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe008800
mk_conf_addr(bus=0 ,device_fn=0x90, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe009000
mk_conf_addr(bus=0 ,device_fn=0x98, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe009800
mk_conf_addr(bus=0 ,device_fn=0xa0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00a000
mk_conf_addr(bus=0 ,device_fn=0xa8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00a800
mk_conf_addr(bus=0 ,device_fn=0xb0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00b000
mk_conf_addr(bus=0 ,device_fn=0xb8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00b800
mk_conf_addr(bus=0 ,device_fn=0xc0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00c000
mk_conf_addr(bus=0 ,device_fn=0xc8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00c800
mk_conf_addr(bus=0 ,device_fn=0xd0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00d000
mk_conf_addr(bus=0 ,device_fn=0xd8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00d800
mk_conf_addr(bus=0 ,device_fn=0xe0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00e000
mk_conf_addr(bus=0 ,device_fn=0xe8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00e800
mk_conf_addr(bus=0 ,device_fn=0xf0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00f000
mk_conf_addr(bus=0 ,device_fn=0xf8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00f800
PCI: Fixups for bus 0000:00
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x18, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004018
PCI: Scanning behind PCI bridge 0000:00:08.0, config 020200, pass 0
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x18, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004018
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x18, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004018
PCI: Scanning behind PCI bridge 0000:00:08.0, config 000000, pass 1
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x6, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004006
CLASS: registering class device: ID = '0000:01'
kobject 0000:01: registering. parent: pci_bus, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:01'
class_uevent - name = 0000:01
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x18, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004018
PCI: Scanning bus 0000:01
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010000
mk_conf_addr(bus=1 ,device_fn=0x0, where=0xe, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01000e
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010006
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010006
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x6, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010006
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x8, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010008
PCI: Found 0000:01:00.0 [1000/000f] 000100 00
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x3d, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01003d
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x3c, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01003c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01001c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01001c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01001c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01001c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010020
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010020
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010020
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010020
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010024
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010024
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010024
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010024
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010030
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010030
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010030
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010030
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x2c, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01002c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x2e, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01002e
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010800
mk_conf_addr(bus=1 ,device_fn=0x8, where=0xe, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01080e
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010806
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010806
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x6, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010806
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x8, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010808
PCI: Found 0000:01:01.0 [1000/000f] 000100 00
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x3d, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01083d
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x3c, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01083c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01081c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01081c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01081c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01081c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010820
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010820
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010820
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010820
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010824
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010824
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010824
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010824
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010830
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010830
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010830
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010830
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x2c, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01082c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x2e, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01082e
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe011000
mk_conf_addr(bus=1 ,device_fn=0x10, where=0xe, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01100e
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011006
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x6, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011006
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x6, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011006
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x8, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe011008
PCI: Found 0000:01:02.0 [1011/0009] 000200 00
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x3d, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01103d
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x3c, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01103c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011018
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011018
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011018
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011018
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01101c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01101c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x1c, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01101c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x1c, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01101c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011020
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011020
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x20, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011020
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x20, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011020
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011024
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011024
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x24, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011024
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x24, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011024
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011030
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011030
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x30, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011030
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x30, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011030
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x2c, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01102c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x2e, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01102e
mk_conf_addr(bus=1 ,device_fn=0x18, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe011800
mk_conf_addr(bus=1 ,device_fn=0x20, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe012000
mk_conf_addr(bus=1 ,device_fn=0x28, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe012800
mk_conf_addr(bus=1 ,device_fn=0x30, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe013000
mk_conf_addr(bus=1 ,device_fn=0x38, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe013800
mk_conf_addr(bus=1 ,device_fn=0x40, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe014000
mk_conf_addr(bus=1 ,device_fn=0x48, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe014800
mk_conf_addr(bus=1 ,device_fn=0x50, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe015000
mk_conf_addr(bus=1 ,device_fn=0x58, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe015800
mk_conf_addr(bus=1 ,device_fn=0x60, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe016000
mk_conf_addr(bus=1 ,device_fn=0x68, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe016800
mk_conf_addr(bus=1 ,device_fn=0x70, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe017000
mk_conf_addr(bus=1 ,device_fn=0x78, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe017800
mk_conf_addr(bus=1 ,device_fn=0x80, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe018000
mk_conf_addr(bus=1 ,device_fn=0x88, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe018800
mk_conf_addr(bus=1 ,device_fn=0x90, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe019000
mk_conf_addr(bus=1 ,device_fn=0x98, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe019800
mk_conf_addr(bus=1 ,device_fn=0xa0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01a000
mk_conf_addr(bus=1 ,device_fn=0xa8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01a800
mk_conf_addr(bus=1 ,device_fn=0xb0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01b000
mk_conf_addr(bus=1 ,device_fn=0xb8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01b800
mk_conf_addr(bus=1 ,device_fn=0xc0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01c000
mk_conf_addr(bus=1 ,device_fn=0xc8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01c800
mk_conf_addr(bus=1 ,device_fn=0xd0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01d000
mk_conf_addr(bus=1 ,device_fn=0xd8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01d800
mk_conf_addr(bus=1 ,device_fn=0xe0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01e000
mk_conf_addr(bus=1 ,device_fn=0xe8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01e800
mk_conf_addr(bus=1 ,device_fn=0xf0, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01f000
mk_conf_addr(bus=1 ,device_fn=0xf8, where=0x0, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe01f800
PCI: Fixups for bus 0000:01
PCI: Bus scan for 0000:01 returning with max=01
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x1a, pci_addr=0xfffffc003f02bd00, type1=0xfffffc003f02bcf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00401a
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
PCI: Bus scan for 0000:00 returning with max=01
DEV: registering device: ID = '0000:00:05.0'
kobject 0000:00:05.0: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:05.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.0'
DEV: registering device: ID = '0000:00:05.1'
kobject 0000:00:05.1: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:05.1
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1'
DEV: registering device: ID = '0000:00:05.2'
kobject 0000:00:05.2: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:05.2
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.2'
DEV: registering device: ID = '0000:00:05.3'
kobject 0000:00:05.3: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:05.3
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.3'
DEV: registering device: ID = '0000:00:07.0'
kobject 0000:00:07.0: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:07.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0'
DEV: registering device: ID = '0000:00:08.0'
kobject 0000:00:08.0: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:08.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0'
DEV: registering device: ID = '0000:00:09.0'
kobject 0000:00:09.0: registering. parent: pci0000:00, set: devices
bus pci: add device 0000:00:09.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:09.0'
DEV: registering device: ID = '0000:01:00.0'
kobject 0000:01:00.0: registering. parent: 0000:00:08.0, set: devices
bus pci: add device 0000:01:00.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0'
DEV: registering device: ID = '0000:01:01.0'
kobject 0000:01:01.0: registering. parent: 0000:00:08.0, set: devices
bus pci: add device 0000:01:01.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0'
DEV: registering device: ID = '0000:01:02.0'
kobject 0000:01:02.0: registering. parent: 0000:00:08.0, set: devices
bus pci: add device 0000:01:02.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
DEV: registering device: ID = 'pci0001:02'
kobject pci0001:02: registering. parent: <NULL>, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = '0001:02'
kobject 0001:02: registering. parent: pci_bus, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0001:02'
class_uevent - name = 0001:02
PCI: Scanning bus 0001:02
mk_conf_addr(bus=2 ,device_fn=0x0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe000000
mk_conf_addr(bus=2 ,device_fn=0x8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe000800
mk_conf_addr(bus=2 ,device_fn=0x10, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe001000
mk_conf_addr(bus=2 ,device_fn=0x18, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe001800
mk_conf_addr(bus=2 ,device_fn=0x20, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe002000
mk_conf_addr(bus=2 ,device_fn=0x28, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe002800
mk_conf_addr(bus=2 ,device_fn=0x30, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe003000
mk_conf_addr(bus=2 ,device_fn=0x38, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe003800
mk_conf_addr(bus=2 ,device_fn=0x40, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004000
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004800
mk_conf_addr(bus=2 ,device_fn=0x48, where=0xe, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00480e
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004806
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004834
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x50, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004850
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x51, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004851
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004806
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x34, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004834
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x50, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004850
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x51, pci_addr=0xfffffc003f02bc50, type1=0xfffffc003f02bc48)
mk_conf_addr: returning pci_addr 0xfffffd03fe004851
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd03fe004806
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x34, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004834
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x50, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004850
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x51, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004851
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x8, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004808
PCI: Found 0001:02:09.0 [1106/3119] 000200 00
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x3d, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00483d
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x3c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00483c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004818
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004818
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004818
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x18, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004818
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe00481c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe00481c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe00481c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x1c, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe00481c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004820
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004820
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004820
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x20, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004820
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004824
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004824
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004824
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x24, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004824
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004830
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004830
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc60, type1=0xfffffc003f02bc58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004830
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x30, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd03fe004830
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x2c, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00482c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x2e, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00482e
mk_conf_addr(bus=2 ,device_fn=0x50, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe005000
mk_conf_addr(bus=2 ,device_fn=0x58, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe005800
mk_conf_addr(bus=2 ,device_fn=0x60, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe006000
mk_conf_addr(bus=2 ,device_fn=0x68, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe006800
mk_conf_addr(bus=2 ,device_fn=0x70, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe007000
mk_conf_addr(bus=2 ,device_fn=0x78, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe007800
mk_conf_addr(bus=2 ,device_fn=0x80, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe008000
mk_conf_addr(bus=2 ,device_fn=0x88, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe008800
mk_conf_addr(bus=2 ,device_fn=0x90, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe009000
mk_conf_addr(bus=2 ,device_fn=0x98, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe009800
mk_conf_addr(bus=2 ,device_fn=0xa0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00a000
mk_conf_addr(bus=2 ,device_fn=0xa8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00a800
mk_conf_addr(bus=2 ,device_fn=0xb0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00b000
mk_conf_addr(bus=2 ,device_fn=0xb8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00b800
mk_conf_addr(bus=2 ,device_fn=0xc0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00c000
mk_conf_addr(bus=2 ,device_fn=0xc8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00c800
mk_conf_addr(bus=2 ,device_fn=0xd0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00d000
mk_conf_addr(bus=2 ,device_fn=0xd8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00d800
mk_conf_addr(bus=2 ,device_fn=0xe0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00e000
mk_conf_addr(bus=2 ,device_fn=0xe8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00e800
mk_conf_addr(bus=2 ,device_fn=0xf0, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00f000
mk_conf_addr(bus=2 ,device_fn=0xf8, where=0x0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00f800
PCI: Fixups for bus 0001:02
PCI: Bus scan for 0001:02 returning with max=02
DEV: registering device: ID = '0001:02:09.0'
kobject 0001:02:09.0: registering. parent: pci0001:02, set: devices
bus pci: add device 0001:02:09.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x1c, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00401c
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x24, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004024
  got res [9000000:97fffff] bus [9000000:97fffff] flags 200 for BAR 0 of 0000:00:09.0
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe004810
PCI: moved device 0000:00:09.0 resource 0 (200) to 9000000
  got res [9a00000:9a7ffff] bus [9a00000:9a7ffff] flags 7200 for BAR 6 of 0000:00:07.0
  got res [9a80000:9a8ffff] bus [9a80000:9a8ffff] flags 200 for BAR 4 of 0000:00:05.2
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x20, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a20
PCI: moved device 0000:00:05.2 resource 4 (200) to 9a80000
  got res [9a90000:9a9ffff] bus [9a90000:9a9ffff] flags 7200 for BAR 6 of 0000:00:09.0
  got res [9aa0000:9aa7fff] bus [9aa0000:9aa7fff] flags 204 for BAR 2 of 0000:00:07.0
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x18, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003818
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x1c, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe00381c
PCI: moved device 0000:00:07.0 resource 2 (204) to 0
  got res [9aa8000:9aa8fff] bus [9aa8000:9aa8fff] flags 200 for BAR 0 of 0000:00:05.3
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x10, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b10
PCI: moved device 0000:00:05.3 resource 0 (200) to 9aa8000
  got res [9aa9000:9aa907f] bus [9aa9000:9aa907f] flags 204 for BAR 0 of 0000:00:07.0
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x10, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003810
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x14, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003814
PCI: moved device 0000:00:07.0 resource 0 (204) to 0
  got res [9000:900f] bus [9000:900f] flags 101 for BAR 4 of 0000:00:05.1
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x20, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe002920
PCI: moved device 0000:00:05.1 resource 4 (101) to 9000
  got res [9010:901f] bus [9010:901f] flags 101 for BAR 4 of 0000:00:07.0
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x20, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003820
PCI: moved device 0000:00:07.0 resource 4 (101) to 9010
  got res [9900000:993ffff] bus [9900000:993ffff] flags 7200 for BAR 6 of 0000:01:02.0
  got res [9940000:994ffff] bus [9940000:994ffff] flags 7200 for BAR 6 of 0000:01:00.0
  got res [9950000:995ffff] bus [9950000:995ffff] flags 7200 for BAR 6 of 0000:01:01.0
  got res [9800000:9800fff] bus [9800000:9800fff] flags 200 for BAR 2 of 0000:01:00.0
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010018
PCI: moved device 0000:01:00.0 resource 2 (200) to 9800000
  got res [9801000:9801fff] bus [9801000:9801fff] flags 200 for BAR 2 of 0000:01:01.0
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x18, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010818
PCI: moved device 0000:01:01.0 resource 2 (200) to 9801000
  got res [8000:80ff] bus [8000:80ff] flags 101 for BAR 0 of 0000:01:00.0
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010010
PCI: moved device 0000:01:00.0 resource 0 (101) to 8000
  got res [9802000:98020ff] bus [9802000:98020ff] flags 200 for BAR 1 of 0000:01:00.0
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010014
PCI: moved device 0000:01:00.0 resource 1 (200) to 9802000
  got res [8400:84ff] bus [8400:84ff] flags 101 for BAR 0 of 0000:01:01.0
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010810
PCI: moved device 0000:01:01.0 resource 0 (101) to 8400
  got res [9803000:98030ff] bus [9803000:98030ff] flags 200 for BAR 1 of 0000:01:01.0
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010814
PCI: moved device 0000:01:01.0 resource 1 (200) to 9803000
  got res [8800:887f] bus [8800:887f] flags 101 for BAR 0 of 0000:01:02.0
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x10, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011010
PCI: moved device 0000:01:02.0 resource 0 (101) to 8800
  got res [9804000:980407f] bus [9804000:980407f] flags 200 for BAR 1 of 0000:01:02.0
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x14, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011014
PCI: moved device 0000:01:02.0 resource 1 (200) to 9804000
PCI: Bridge: 0000:00:08.0
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x1c, pci_addr=0xfffffc003f02bd00, type1=0xfffffc003f02bcf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00401c
  IO window: 8000-8fff
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x30, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe004030
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x1c, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00401c
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x30, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe004030
  MEM window: 09800000-098fffff
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x20, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe004020
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x2c, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00402c
  PREFETCH window: 09900000-099fffff
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x24, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe004024
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x28, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe004028
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3e, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403e
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x6, pci_addr=0xfffffc003f02bc90, type1=0xfffffc003f02bc88)
mk_conf_addr: returning pci_addr 0xfffffd01fe004006
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x34, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe004034
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xdc, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040dc
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xde, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040de
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xe0, pci_addr=0xfffffc003f02bcd0, type1=0xfffffc003f02bcc8)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040e0
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xe0, pci_addr=0xfffffc003f02bce0, type1=0xfffffc003f02bcd8)
mk_conf_addr: returning pci_addr 0xfffffd01fe0040e0
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x4, pci_addr=0xfffffc003f02bcf0, type1=0xfffffc003f02bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe004004
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x4, pci_addr=0xfffffc003f02bd20, type1=0xfffffc003f02bd18)
mk_conf_addr: returning pci_addr 0xfffffd01fe004004
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xd, pci_addr=0xfffffc003f02bd10, type1=0xfffffc003f02bd08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00400d
  got res [200008000:2000080ff] bus [8000:80ff] flags 101 for BAR 0 of 0001:02:09.0
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x10, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd03fe004810
PCI: moved device 0001:02:09.0 resource 0 (101) to 8000
  got res [209000000:2090000ff] bus [9000000:90000ff] flags 200 for BAR 1 of 0001:02:09.0
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc40, type1=0xfffffc003f02bc38)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x14, pci_addr=0xfffffc003f02bc30, type1=0xfffffc003f02bc28)
mk_conf_addr: returning pci_addr 0xfffffd03fe004814
PCI: moved device 0001:02:09.0 resource 1 (200) to 9000000
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00283d
PCI: fixup irq: (0000:00:05.0) got 0
mk_conf_addr(bus=0 ,device_fn=0x28, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00283c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00293d
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x3c, pci_addr=0xfffffc003f02bd30, type1=0xfffffc003f02bd28)
mk_conf_addr: returning pci_addr 0xfffffd01fe00293c
PCI: fixup irq: (0000:00:05.1) got 14
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00293c
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a3d
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x3c, pci_addr=0xfffffc003f02bd30, type1=0xfffffc003f02bd28)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a3c
PCI: fixup irq: (0000:00:05.2) got 15
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a3c
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b3d
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x3c, pci_addr=0xfffffc003f02bd30, type1=0xfffffc003f02bd28)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b3c
PCI: fixup irq: (0000:00:05.3) got 10
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b3c
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00383d
PCI: fixup irq: (0000:00:07.0) got 31
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00383c
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403d
PCI: fixup irq: (0000:00:08.0) got 0
mk_conf_addr(bus=0 ,device_fn=0x40, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00403c
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00483d
PCI: fixup irq: (0000:00:09.0) got 23
mk_conf_addr(bus=0 ,device_fn=0x48, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe00483c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01003d
PCI: fixup irq: (0000:01:00.0) got 27
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01003c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01083d
PCI: fixup irq: (0000:01:01.0) got 26
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01083c
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01103d
PCI: fixup irq: (0000:01:02.0) got 25
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd01fe01103c
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x3d, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd03fe00483d
PCI: fixup irq: (0001:02:09.0) got 39
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x3c, pci_addr=0xfffffc003f02bd50, type1=0xfffffc003f02bd48)
mk_conf_addr: returning pci_addr 0xfffffd03fe00483c
SMC37c669 Super I/O Controller found @ 0x3f0
kobject module: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject printk: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/printk'
kobject rcupdate: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/rcupdate'
kobject core: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/core'
kobject pty: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/pty'
kobject keyboard: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/keyboard'
kobject vt: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/vt'
kobject 8250: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/8250'
kobject devres: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/devres'
kobject via_velocity: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/via_velocity'
kobject tulip: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/tulip'
kobject generic: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/generic'
kobject ide_cd: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/ide_cd'
kobject scsi_mod: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/scsi_mod'
kobject scsi_transport_fc: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/scsi_transport_fc'
kobject qlogicfas: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/qlogicfas'
kobject qla2xxx: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/qla2xxx'
kobject qla4xxx: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/qla4xxx'
kobject sym53c8xx: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/sym53c8xx'
kobject sr_mod: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/sr_mod'
kobject cdrom: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/cdrom'
kobject i8042: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/i8042'
kobject mousedev: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/mousedev'
kobject atkbd: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/atkbd'
kobject psmouse: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/psmouse'
kobject hid: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/hid'
kobject oprofile: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/oprofile'
kobject tcp_cubic: registering. parent: <NULL>, set: module
kobject_uevent_env
fill_kobj_path: path = '/module/tcp_cubic'
kobject block: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
Linux Plug and Play Support v0.97 (c) Adam Belay
kobject pnp: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/pnp'
kobject devices: registering. parent: pnp, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: pnp, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'pnp' registered
device class 'misc': registering
kobject misc: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/misc'
device class 'scsi_host': registering
kobject scsi_host: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host'
kobject scsi: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi'
kobject devices: registering. parent: scsi, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: scsi, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'scsi' registered
device class 'scsi_device': registering
kobject scsi_device: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device'
SCSI subsystem initialized
kobject serio: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/serio'
kobject devices: registering. parent: serio, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: serio, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'serio' registered
device class 'input': registering
kobject input: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/input'
device class 'hwmon': registering
kobject hwmon: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/hwmon'
device class 'net': registering
kobject net: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/net'
bus pnp: add driver system
kobject system: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pnp/drivers/system'
device class 'mem': registering
kobject mem: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/mem'
DEV: registering device: ID = 'mem'
kobject mem: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/mem'
DEV: registering device: ID = 'kmem'
kobject kmem: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmem'
DEV: registering device: ID = 'null'
kobject null: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/null'
DEV: registering device: ID = 'port'
kobject port: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/port'
DEV: registering device: ID = 'zero'
kobject zero: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/zero'
DEV: registering device: ID = 'full'
kobject full: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/full'
DEV: registering device: ID = 'random'
kobject random: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/random'
DEV: registering device: ID = 'urandom'
kobject urandom: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/urandom'
DEV: registering device: ID = 'kmsg'
kobject kmsg: registering. parent: mem, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmsg'
device class 'firmware': registering
kobject firmware: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/firmware'
DEV: registering device: ID = 'lo'
kobject lo: registering. parent: net, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/net/lo'
NET: Registered protocol family 2
IP route cache hash table entries: 8192 (order: 3, 65536 bytes)
TCP established hash table entries: 32768 (order: 6, 524288 bytes)
TCP bind hash table entries: 32768 (order: 6, 524288 bytes)
TCP: Hash tables configured (established 32768 bind 32768)
TCP reno registered
Registering platform device 'pcspkr'. Parent at platform
DEV: registering device: ID = 'pcspkr'
kobject pcspkr: registering. parent: platform, set: devices
bus platform: add device pcspkr
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/pcspkr'
Registering sysdev class 'timekeeping'
kobject timekeeping: registering. parent: system, set: system
kobject_uevent_env
fill_kobj_path: path = '/devices/system/timekeeping'
Registering sys device 'timekeeping0'
kobject timekeeping0: registering. parent: <NULL>, set: timekeeping
kobject_uevent_env
fill_kobj_path: path = '/devices/system/timekeeping/timekeeping0'
Registering sysdev class 'clocksource'
kobject clocksource: registering. parent: system, set: system
kobject_uevent_env
fill_kobj_path: path = '/devices/system/clocksource'
Registering sys device 'clocksource0'
kobject clocksource0: registering. parent: <NULL>, set: clocksource
kobject_uevent_env
fill_kobj_path: path = '/devices/system/clocksource/clocksource0'
kobject slab: registering. parent: <NULL>, set: <NULL>
kobject_uevent_env
kobject attempted to send uevent without kset!
kobject shmem_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/shmem_inode_cache'
kobject :0000056: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000056'
kobject :0000136: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000136'
kobject :0000384: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000384'
kobject :0000768: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000768'
kobject :0001472: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001472'
kobject :0005120: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0005120'
kobject :0002560: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0002560'
kobject :0001280: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001280'
kobject :0000640: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000640'
kobject :0000320: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000320'
kobject :0000112: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000112'
kobject :0001568: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001568'
kobject :0000288: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000288'
kobject sock_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/sock_inode_cache'
kobject :0000448: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000448'
kobject file_lock_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/file_lock_cache'
kobject proc_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/proc_inode_cache'
kobject :0000160: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000160'
kobject radix_tree_node: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/radix_tree_node'
kobject bdev_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/bdev_cache'
kobject :0000072: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000072'
kobject inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/inode_cache'
kobject :a-0000208: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000208'
kobject idr_layer_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/idr_layer_cache'
kobject :a-0000104: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000104'
kobject :0000832: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000832'
kobject :0000168: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000168'
kobject :0000704: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000704'
kobject sighand_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/sighand_cache'
kobject :0001152: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001152'
kobject anon_vma: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/anon_vma'
kobject :0001080: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001080'
kobject :0004096: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0004096'
kobject :0002048: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0002048'
kobject :0001024: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0001024'
kobject :0000512: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000512'
kobject :0000256: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000256'
kobject :0000128: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000128'
kobject :0000064: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000064'
kobject :0000032: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000032'
kobject :0000016: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000016'
kobject :0000008: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000008'
kobject :0000192: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000192'
kobject :0000096: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000096'
kobject :0000024: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000024'
kobject :0000040: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000040'
kobject :a-0000088: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000088'
kobject ext3_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/ext3_inode_cache'
kobject :a-0000032: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000032'
kobject :a-0000016: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000016'
kobject :a-0000096: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000096'
kobject :a-0000024: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:a-0000024'
kobject ext2_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/ext2_inode_cache'
kobject fat_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/fat_cache'
kobject fat_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/fat_inode_cache'
kobject isofs_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/isofs_inode_cache'
kobject mqueue_inode_cache: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/mqueue_inode_cache'
io scheduler noop registered
io scheduler anticipatory registered
io scheduler deadline registered
kobject :0000152: registering. parent: <NULL>, set: slab
kobject_uevent_env
fill_kobj_path: path = '/slab/:0000152'
io scheduler cfq registered (default)
PCI: Calling quirk fffffc0000738890 for 0000:00:05.0
PCI: Calling quirk fffffc000046cc00 for 0000:00:05.0
PCI: Calling quirk fffffc000055c2c0 for 0000:00:05.0
PCI: Calling quirk fffffc0000738890 for 0000:00:05.1
PCI: Calling quirk fffffc000046cc00 for 0000:00:05.1
PCI: Calling quirk fffffc000055c2c0 for 0000:00:05.1
PCI: Calling quirk fffffc0000738890 for 0000:00:05.2
PCI: Calling quirk fffffc000046cc00 for 0000:00:05.2
PCI: Calling quirk fffffc000055c2c0 for 0000:00:05.2
PCI: Calling quirk fffffc0000738890 for 0000:00:05.3
PCI: Calling quirk fffffc000046cc00 for 0000:00:05.3
PCI: Calling quirk fffffc000055c2c0 for 0000:00:05.3
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0x4, pci_addr=0xfffffc003f02bd20, type1=0xfffffc003f02bd18)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b04
PCI: Calling quirk fffffc0000738890 for 0000:00:07.0
PCI: Calling quirk fffffc000046cc00 for 0000:00:07.0
PCI: Calling quirk fffffc000055c2c0 for 0000:00:07.0
PCI: Calling quirk fffffc0000738890 for 0000:00:08.0
PCI: Calling quirk fffffc000046cc00 for 0000:00:08.0
PCI: Calling quirk fffffc000055c2c0 for 0000:00:08.0
PCI: Calling quirk fffffc0000738890 for 0000:00:09.0
PCI: Calling quirk fffffc000046cc00 for 0000:00:09.0
PCI: Calling quirk fffffc000055c2c0 for 0000:00:09.0
PCI: Calling quirk fffffc0000738890 for 0000:01:00.0
PCI: Calling quirk fffffc000046cc00 for 0000:01:00.0
PCI: Calling quirk fffffc000055c2c0 for 0000:01:00.0
PCI: Calling quirk fffffc0000738890 for 0000:01:01.0
PCI: Calling quirk fffffc000046cc00 for 0000:01:01.0
PCI: Calling quirk fffffc000055c2c0 for 0000:01:01.0
PCI: Calling quirk fffffc0000738890 for 0000:01:02.0
PCI: Calling quirk fffffc000046cc00 for 0000:01:02.0
PCI: Calling quirk fffffc000055c2c0 for 0000:01:02.0
PCI: Calling quirk fffffc0000738890 for 0001:02:09.0
PCI: Calling quirk fffffc000046cc00 for 0001:02:09.0
PCI: Calling quirk fffffc000055c2c0 for 0001:02:09.0
DEV: registering device: ID = 'pnp0'
kobject pnp0: registering. parent: <NULL>, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
isapnp: Scanning for PnP cards...
isapnp: No Plug & Play device found
DEV: registering device: ID = 'tty'
kobject tty: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty'
DEV: registering device: ID = 'console'
kobject console: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/console'
DEV: registering device: ID = 'ptmx'
kobject ptmx: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptmx'
DEV: registering device: ID = 'tty0'
kobject tty0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty0'
device class 'vc': registering
kobject vc: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/vc'
DEV: registering device: ID = 'vcs'
kobject vcs: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs'
DEV: registering device: ID = 'vcsa'
kobject vcsa: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa'
DEV: registering device: ID = 'tty1'
kobject tty1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty1'
DEV: registering device: ID = 'tty2'
kobject tty2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty2'
DEV: registering device: ID = 'tty3'
kobject tty3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty3'
DEV: registering device: ID = 'tty4'
kobject tty4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty4'
DEV: registering device: ID = 'tty5'
kobject tty5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty5'
DEV: registering device: ID = 'tty6'
kobject tty6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty6'
DEV: registering device: ID = 'tty7'
kobject tty7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty7'
DEV: registering device: ID = 'tty8'
kobject tty8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty8'
DEV: registering device: ID = 'tty9'
kobject tty9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty9'
DEV: registering device: ID = 'tty10'
kobject tty10: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty10'
DEV: registering device: ID = 'tty11'
kobject tty11: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty11'
DEV: registering device: ID = 'tty12'
kobject tty12: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty12'
DEV: registering device: ID = 'tty13'
kobject tty13: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty13'
DEV: registering device: ID = 'tty14'
kobject tty14: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty14'
DEV: registering device: ID = 'tty15'
kobject tty15: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty15'
DEV: registering device: ID = 'tty16'
kobject tty16: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty16'
DEV: registering device: ID = 'tty17'
kobject tty17: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty17'
DEV: registering device: ID = 'tty18'
kobject tty18: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty18'
DEV: registering device: ID = 'tty19'
kobject tty19: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty19'
DEV: registering device: ID = 'tty20'
kobject tty20: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty20'
DEV: registering device: ID = 'tty21'
kobject tty21: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty21'
DEV: registering device: ID = 'tty22'
kobject tty22: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty22'
DEV: registering device: ID = 'tty23'
kobject tty23: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty23'
DEV: registering device: ID = 'tty24'
kobject tty24: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty24'
DEV: registering device: ID = 'tty25'
kobject tty25: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty25'
DEV: registering device: ID = 'tty26'
kobject tty26: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty26'
DEV: registering device: ID = 'tty27'
kobject tty27: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty27'
DEV: registering device: ID = 'tty28'
kobject tty28: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty28'
DEV: registering device: ID = 'tty29'
kobject tty29: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty29'
DEV: registering device: ID = 'tty30'
kobject tty30: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty30'
DEV: registering device: ID = 'tty31'
kobject tty31: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty31'
DEV: registering device: ID = 'tty32'
kobject tty32: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty32'
DEV: registering device: ID = 'tty33'
kobject tty33: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty33'
DEV: registering device: ID = 'tty34'
kobject tty34: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty34'
DEV: registering device: ID = 'tty35'
kobject tty35: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty35'
DEV: registering device: ID = 'tty36'
kobject tty36: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty36'
DEV: registering device: ID = 'tty37'
kobject tty37: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty37'
DEV: registering device: ID = 'tty38'
kobject tty38: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty38'
DEV: registering device: ID = 'tty39'
kobject tty39: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty39'
DEV: registering device: ID = 'tty40'
kobject tty40: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty40'
DEV: registering device: ID = 'tty41'
kobject tty41: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty41'
DEV: registering device: ID = 'tty42'
kobject tty42: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty42'
DEV: registering device: ID = 'tty43'
kobject tty43: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty43'
DEV: registering device: ID = 'tty44'
kobject tty44: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty44'
DEV: registering device: ID = 'tty45'
kobject tty45: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty45'
DEV: registering device: ID = 'tty46'
kobject tty46: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty46'
DEV: registering device: ID = 'tty47'
kobject tty47: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty47'
DEV: registering device: ID = 'tty48'
kobject tty48: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty48'
DEV: registering device: ID = 'tty49'
kobject tty49: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty49'
DEV: registering device: ID = 'tty50'
kobject tty50: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty50'
DEV: registering device: ID = 'tty51'
kobject tty51: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty51'
DEV: registering device: ID = 'tty52'
kobject tty52: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty52'
DEV: registering device: ID = 'tty53'
kobject tty53: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty53'
DEV: registering device: ID = 'tty54'
kobject tty54: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty54'
DEV: registering device: ID = 'tty55'
kobject tty55: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty55'
DEV: registering device: ID = 'tty56'
kobject tty56: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty56'
DEV: registering device: ID = 'tty57'
kobject tty57: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty57'
DEV: registering device: ID = 'tty58'
kobject tty58: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty58'
DEV: registering device: ID = 'tty59'
kobject tty59: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty59'
DEV: registering device: ID = 'tty60'
kobject tty60: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty60'
DEV: registering device: ID = 'tty61'
kobject tty61: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty61'
DEV: registering device: ID = 'tty62'
kobject tty62: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty62'
DEV: registering device: ID = 'tty63'
kobject tty63: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty63'
DEV: registering device: ID = 'ptyp0'
kobject ptyp0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp0'
DEV: registering device: ID = 'ptyp1'
kobject ptyp1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp1'
DEV: registering device: ID = 'ptyp2'
kobject ptyp2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp2'
DEV: registering device: ID = 'ptyp3'
kobject ptyp3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp3'
DEV: registering device: ID = 'ptyp4'
kobject ptyp4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp4'
DEV: registering device: ID = 'ptyp5'
kobject ptyp5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp5'
DEV: registering device: ID = 'ptyp6'
kobject ptyp6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp6'
DEV: registering device: ID = 'ptyp7'
kobject ptyp7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp7'
DEV: registering device: ID = 'ptyp8'
kobject ptyp8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp8'
DEV: registering device: ID = 'ptyp9'
kobject ptyp9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp9'
DEV: registering device: ID = 'ptypa'
kobject ptypa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypa'
DEV: registering device: ID = 'ptypb'
kobject ptypb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypb'
DEV: registering device: ID = 'ptypc'
kobject ptypc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypc'
DEV: registering device: ID = 'ptypd'
kobject ptypd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypd'
DEV: registering device: ID = 'ptype'
kobject ptype: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptype'
DEV: registering device: ID = 'ptypf'
kobject ptypf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypf'
DEV: registering device: ID = 'ptyq0'
kobject ptyq0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq0'
DEV: registering device: ID = 'ptyq1'
kobject ptyq1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq1'
DEV: registering device: ID = 'ptyq2'
kobject ptyq2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq2'
DEV: registering device: ID = 'ptyq3'
kobject ptyq3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq3'
DEV: registering device: ID = 'ptyq4'
kobject ptyq4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq4'
DEV: registering device: ID = 'ptyq5'
kobject ptyq5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq5'
DEV: registering device: ID = 'ptyq6'
kobject ptyq6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq6'
DEV: registering device: ID = 'ptyq7'
kobject ptyq7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq7'
DEV: registering device: ID = 'ptyq8'
kobject ptyq8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq8'
DEV: registering device: ID = 'ptyq9'
kobject ptyq9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq9'
DEV: registering device: ID = 'ptyqa'
kobject ptyqa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqa'
DEV: registering device: ID = 'ptyqb'
kobject ptyqb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqb'
DEV: registering device: ID = 'ptyqc'
kobject ptyqc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqc'
DEV: registering device: ID = 'ptyqd'
kobject ptyqd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqd'
DEV: registering device: ID = 'ptyqe'
kobject ptyqe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqe'
DEV: registering device: ID = 'ptyqf'
kobject ptyqf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqf'
DEV: registering device: ID = 'ptyr0'
kobject ptyr0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr0'
DEV: registering device: ID = 'ptyr1'
kobject ptyr1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr1'
DEV: registering device: ID = 'ptyr2'
kobject ptyr2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr2'
DEV: registering device: ID = 'ptyr3'
kobject ptyr3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr3'
DEV: registering device: ID = 'ptyr4'
kobject ptyr4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr4'
DEV: registering device: ID = 'ptyr5'
kobject ptyr5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr5'
DEV: registering device: ID = 'ptyr6'
kobject ptyr6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr6'
DEV: registering device: ID = 'ptyr7'
kobject ptyr7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr7'
DEV: registering device: ID = 'ptyr8'
kobject ptyr8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr8'
DEV: registering device: ID = 'ptyr9'
kobject ptyr9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr9'
DEV: registering device: ID = 'ptyra'
kobject ptyra: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyra'
DEV: registering device: ID = 'ptyrb'
kobject ptyrb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrb'
DEV: registering device: ID = 'ptyrc'
kobject ptyrc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrc'
DEV: registering device: ID = 'ptyrd'
kobject ptyrd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrd'
DEV: registering device: ID = 'ptyre'
kobject ptyre: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyre'
DEV: registering device: ID = 'ptyrf'
kobject ptyrf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrf'
DEV: registering device: ID = 'ptys0'
kobject ptys0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys0'
DEV: registering device: ID = 'ptys1'
kobject ptys1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys1'
DEV: registering device: ID = 'ptys2'
kobject ptys2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys2'
DEV: registering device: ID = 'ptys3'
kobject ptys3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys3'
DEV: registering device: ID = 'ptys4'
kobject ptys4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys4'
DEV: registering device: ID = 'ptys5'
kobject ptys5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys5'
DEV: registering device: ID = 'ptys6'
kobject ptys6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys6'
DEV: registering device: ID = 'ptys7'
kobject ptys7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys7'
DEV: registering device: ID = 'ptys8'
kobject ptys8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys8'
DEV: registering device: ID = 'ptys9'
kobject ptys9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys9'
DEV: registering device: ID = 'ptysa'
kobject ptysa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysa'
DEV: registering device: ID = 'ptysb'
kobject ptysb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysb'
DEV: registering device: ID = 'ptysc'
kobject ptysc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysc'
DEV: registering device: ID = 'ptysd'
kobject ptysd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysd'
DEV: registering device: ID = 'ptyse'
kobject ptyse: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyse'
DEV: registering device: ID = 'ptysf'
kobject ptysf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysf'
DEV: registering device: ID = 'ptyt0'
kobject ptyt0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt0'
DEV: registering device: ID = 'ptyt1'
kobject ptyt1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt1'
DEV: registering device: ID = 'ptyt2'
kobject ptyt2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt2'
DEV: registering device: ID = 'ptyt3'
kobject ptyt3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt3'
DEV: registering device: ID = 'ptyt4'
kobject ptyt4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt4'
DEV: registering device: ID = 'ptyt5'
kobject ptyt5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt5'
DEV: registering device: ID = 'ptyt6'
kobject ptyt6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt6'
DEV: registering device: ID = 'ptyt7'
kobject ptyt7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt7'
DEV: registering device: ID = 'ptyt8'
kobject ptyt8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt8'
DEV: registering device: ID = 'ptyt9'
kobject ptyt9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt9'
DEV: registering device: ID = 'ptyta'
kobject ptyta: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyta'
DEV: registering device: ID = 'ptytb'
kobject ptytb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytb'
DEV: registering device: ID = 'ptytc'
kobject ptytc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytc'
DEV: registering device: ID = 'ptytd'
kobject ptytd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytd'
DEV: registering device: ID = 'ptyte'
kobject ptyte: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyte'
DEV: registering device: ID = 'ptytf'
kobject ptytf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytf'
DEV: registering device: ID = 'ptyu0'
kobject ptyu0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu0'
DEV: registering device: ID = 'ptyu1'
kobject ptyu1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu1'
DEV: registering device: ID = 'ptyu2'
kobject ptyu2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu2'
DEV: registering device: ID = 'ptyu3'
kobject ptyu3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu3'
DEV: registering device: ID = 'ptyu4'
kobject ptyu4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu4'
DEV: registering device: ID = 'ptyu5'
kobject ptyu5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu5'
DEV: registering device: ID = 'ptyu6'
kobject ptyu6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu6'
DEV: registering device: ID = 'ptyu7'
kobject ptyu7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu7'
DEV: registering device: ID = 'ptyu8'
kobject ptyu8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu8'
DEV: registering device: ID = 'ptyu9'
kobject ptyu9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu9'
DEV: registering device: ID = 'ptyua'
kobject ptyua: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyua'
DEV: registering device: ID = 'ptyub'
kobject ptyub: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyub'
DEV: registering device: ID = 'ptyuc'
kobject ptyuc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuc'
DEV: registering device: ID = 'ptyud'
kobject ptyud: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyud'
DEV: registering device: ID = 'ptyue'
kobject ptyue: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyue'
DEV: registering device: ID = 'ptyuf'
kobject ptyuf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuf'
DEV: registering device: ID = 'ptyv0'
kobject ptyv0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv0'
DEV: registering device: ID = 'ptyv1'
kobject ptyv1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv1'
DEV: registering device: ID = 'ptyv2'
kobject ptyv2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv2'
DEV: registering device: ID = 'ptyv3'
kobject ptyv3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv3'
DEV: registering device: ID = 'ptyv4'
kobject ptyv4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv4'
DEV: registering device: ID = 'ptyv5'
kobject ptyv5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv5'
DEV: registering device: ID = 'ptyv6'
kobject ptyv6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv6'
DEV: registering device: ID = 'ptyv7'
kobject ptyv7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv7'
DEV: registering device: ID = 'ptyv8'
kobject ptyv8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv8'
DEV: registering device: ID = 'ptyv9'
kobject ptyv9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv9'
DEV: registering device: ID = 'ptyva'
kobject ptyva: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyva'
DEV: registering device: ID = 'ptyvb'
kobject ptyvb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvb'
DEV: registering device: ID = 'ptyvc'
kobject ptyvc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvc'
DEV: registering device: ID = 'ptyvd'
kobject ptyvd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvd'
DEV: registering device: ID = 'ptyve'
kobject ptyve: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyve'
DEV: registering device: ID = 'ptyvf'
kobject ptyvf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvf'
DEV: registering device: ID = 'ptyw0'
kobject ptyw0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw0'
DEV: registering device: ID = 'ptyw1'
kobject ptyw1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw1'
DEV: registering device: ID = 'ptyw2'
kobject ptyw2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw2'
DEV: registering device: ID = 'ptyw3'
kobject ptyw3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw3'
DEV: registering device: ID = 'ptyw4'
kobject ptyw4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw4'
DEV: registering device: ID = 'ptyw5'
kobject ptyw5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw5'
DEV: registering device: ID = 'ptyw6'
kobject ptyw6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw6'
DEV: registering device: ID = 'ptyw7'
kobject ptyw7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw7'
DEV: registering device: ID = 'ptyw8'
kobject ptyw8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw8'
DEV: registering device: ID = 'ptyw9'
kobject ptyw9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw9'
DEV: registering device: ID = 'ptywa'
kobject ptywa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywa'
DEV: registering device: ID = 'ptywb'
kobject ptywb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywb'
DEV: registering device: ID = 'ptywc'
kobject ptywc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywc'
DEV: registering device: ID = 'ptywd'
kobject ptywd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywd'
DEV: registering device: ID = 'ptywe'
kobject ptywe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywe'
DEV: registering device: ID = 'ptywf'
kobject ptywf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywf'
DEV: registering device: ID = 'ptyx0'
kobject ptyx0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx0'
DEV: registering device: ID = 'ptyx1'
kobject ptyx1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx1'
DEV: registering device: ID = 'ptyx2'
kobject ptyx2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx2'
DEV: registering device: ID = 'ptyx3'
kobject ptyx3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx3'
DEV: registering device: ID = 'ptyx4'
kobject ptyx4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx4'
DEV: registering device: ID = 'ptyx5'
kobject ptyx5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx5'
DEV: registering device: ID = 'ptyx6'
kobject ptyx6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx6'
DEV: registering device: ID = 'ptyx7'
kobject ptyx7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx7'
DEV: registering device: ID = 'ptyx8'
kobject ptyx8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx8'
DEV: registering device: ID = 'ptyx9'
kobject ptyx9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx9'
DEV: registering device: ID = 'ptyxa'
kobject ptyxa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxa'
DEV: registering device: ID = 'ptyxb'
kobject ptyxb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxb'
DEV: registering device: ID = 'ptyxc'
kobject ptyxc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxc'
DEV: registering device: ID = 'ptyxd'
kobject ptyxd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxd'
DEV: registering device: ID = 'ptyxe'
kobject ptyxe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxe'
DEV: registering device: ID = 'ptyxf'
kobject ptyxf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxf'
DEV: registering device: ID = 'ptyy0'
kobject ptyy0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy0'
DEV: registering device: ID = 'ptyy1'
kobject ptyy1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy1'
DEV: registering device: ID = 'ptyy2'
kobject ptyy2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy2'
DEV: registering device: ID = 'ptyy3'
kobject ptyy3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy3'
DEV: registering device: ID = 'ptyy4'
kobject ptyy4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy4'
DEV: registering device: ID = 'ptyy5'
kobject ptyy5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy5'
DEV: registering device: ID = 'ptyy6'
kobject ptyy6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy6'
DEV: registering device: ID = 'ptyy7'
kobject ptyy7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy7'
DEV: registering device: ID = 'ptyy8'
kobject ptyy8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy8'
DEV: registering device: ID = 'ptyy9'
kobject ptyy9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy9'
DEV: registering device: ID = 'ptyya'
kobject ptyya: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyya'
DEV: registering device: ID = 'ptyyb'
kobject ptyyb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyb'
DEV: registering device: ID = 'ptyyc'
kobject ptyyc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyc'
DEV: registering device: ID = 'ptyyd'
kobject ptyyd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyd'
DEV: registering device: ID = 'ptyye'
kobject ptyye: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyye'
DEV: registering device: ID = 'ptyyf'
kobject ptyyf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyf'
DEV: registering device: ID = 'ptyz0'
kobject ptyz0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz0'
DEV: registering device: ID = 'ptyz1'
kobject ptyz1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz1'
DEV: registering device: ID = 'ptyz2'
kobject ptyz2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz2'
DEV: registering device: ID = 'ptyz3'
kobject ptyz3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz3'
DEV: registering device: ID = 'ptyz4'
kobject ptyz4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz4'
DEV: registering device: ID = 'ptyz5'
kobject ptyz5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz5'
DEV: registering device: ID = 'ptyz6'
kobject ptyz6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz6'
DEV: registering device: ID = 'ptyz7'
kobject ptyz7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz7'
DEV: registering device: ID = 'ptyz8'
kobject ptyz8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz8'
DEV: registering device: ID = 'ptyz9'
kobject ptyz9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz9'
DEV: registering device: ID = 'ptyza'
kobject ptyza: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyza'
DEV: registering device: ID = 'ptyzb'
kobject ptyzb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzb'
DEV: registering device: ID = 'ptyzc'
kobject ptyzc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzc'
DEV: registering device: ID = 'ptyzd'
kobject ptyzd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzd'
DEV: registering device: ID = 'ptyze'
kobject ptyze: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyze'
DEV: registering device: ID = 'ptyzf'
kobject ptyzf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzf'
DEV: registering device: ID = 'ptya0'
kobject ptya0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya0'
DEV: registering device: ID = 'ptya1'
kobject ptya1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya1'
DEV: registering device: ID = 'ptya2'
kobject ptya2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya2'
DEV: registering device: ID = 'ptya3'
kobject ptya3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya3'
DEV: registering device: ID = 'ptya4'
kobject ptya4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya4'
DEV: registering device: ID = 'ptya5'
kobject ptya5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya5'
DEV: registering device: ID = 'ptya6'
kobject ptya6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya6'
DEV: registering device: ID = 'ptya7'
kobject ptya7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya7'
DEV: registering device: ID = 'ptya8'
kobject ptya8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya8'
DEV: registering device: ID = 'ptya9'
kobject ptya9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya9'
DEV: registering device: ID = 'ptyaa'
kobject ptyaa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaa'
DEV: registering device: ID = 'ptyab'
kobject ptyab: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyab'
DEV: registering device: ID = 'ptyac'
kobject ptyac: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyac'
DEV: registering device: ID = 'ptyad'
kobject ptyad: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyad'
DEV: registering device: ID = 'ptyae'
kobject ptyae: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyae'
DEV: registering device: ID = 'ptyaf'
kobject ptyaf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaf'
DEV: registering device: ID = 'ptyb0'
kobject ptyb0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb0'
DEV: registering device: ID = 'ptyb1'
kobject ptyb1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb1'
DEV: registering device: ID = 'ptyb2'
kobject ptyb2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb2'
DEV: registering device: ID = 'ptyb3'
kobject ptyb3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb3'
DEV: registering device: ID = 'ptyb4'
kobject ptyb4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb4'
DEV: registering device: ID = 'ptyb5'
kobject ptyb5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb5'
DEV: registering device: ID = 'ptyb6'
kobject ptyb6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb6'
DEV: registering device: ID = 'ptyb7'
kobject ptyb7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb7'
DEV: registering device: ID = 'ptyb8'
kobject ptyb8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb8'
DEV: registering device: ID = 'ptyb9'
kobject ptyb9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb9'
DEV: registering device: ID = 'ptyba'
kobject ptyba: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyba'
DEV: registering device: ID = 'ptybb'
kobject ptybb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybb'
DEV: registering device: ID = 'ptybc'
kobject ptybc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybc'
DEV: registering device: ID = 'ptybd'
kobject ptybd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybd'
DEV: registering device: ID = 'ptybe'
kobject ptybe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybe'
DEV: registering device: ID = 'ptybf'
kobject ptybf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybf'
DEV: registering device: ID = 'ptyc0'
kobject ptyc0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc0'
DEV: registering device: ID = 'ptyc1'
kobject ptyc1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc1'
DEV: registering device: ID = 'ptyc2'
kobject ptyc2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc2'
DEV: registering device: ID = 'ptyc3'
kobject ptyc3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc3'
DEV: registering device: ID = 'ptyc4'
kobject ptyc4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc4'
DEV: registering device: ID = 'ptyc5'
kobject ptyc5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc5'
DEV: registering device: ID = 'ptyc6'
kobject ptyc6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc6'
DEV: registering device: ID = 'ptyc7'
kobject ptyc7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc7'
DEV: registering device: ID = 'ptyc8'
kobject ptyc8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc8'
DEV: registering device: ID = 'ptyc9'
kobject ptyc9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc9'
DEV: registering device: ID = 'ptyca'
kobject ptyca: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyca'
DEV: registering device: ID = 'ptycb'
kobject ptycb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycb'
DEV: registering device: ID = 'ptycc'
kobject ptycc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycc'
DEV: registering device: ID = 'ptycd'
kobject ptycd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycd'
DEV: registering device: ID = 'ptyce'
kobject ptyce: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyce'
DEV: registering device: ID = 'ptycf'
kobject ptycf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycf'
DEV: registering device: ID = 'ptyd0'
kobject ptyd0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd0'
DEV: registering device: ID = 'ptyd1'
kobject ptyd1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd1'
DEV: registering device: ID = 'ptyd2'
kobject ptyd2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd2'
DEV: registering device: ID = 'ptyd3'
kobject ptyd3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd3'
DEV: registering device: ID = 'ptyd4'
kobject ptyd4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd4'
DEV: registering device: ID = 'ptyd5'
kobject ptyd5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd5'
DEV: registering device: ID = 'ptyd6'
kobject ptyd6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd6'
DEV: registering device: ID = 'ptyd7'
kobject ptyd7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd7'
DEV: registering device: ID = 'ptyd8'
kobject ptyd8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd8'
DEV: registering device: ID = 'ptyd9'
kobject ptyd9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd9'
DEV: registering device: ID = 'ptyda'
kobject ptyda: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyda'
DEV: registering device: ID = 'ptydb'
kobject ptydb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydb'
DEV: registering device: ID = 'ptydc'
kobject ptydc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydc'
DEV: registering device: ID = 'ptydd'
kobject ptydd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydd'
DEV: registering device: ID = 'ptyde'
kobject ptyde: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyde'
DEV: registering device: ID = 'ptydf'
kobject ptydf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydf'
DEV: registering device: ID = 'ptye0'
kobject ptye0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye0'
DEV: registering device: ID = 'ptye1'
kobject ptye1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye1'
DEV: registering device: ID = 'ptye2'
kobject ptye2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye2'
DEV: registering device: ID = 'ptye3'
kobject ptye3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye3'
DEV: registering device: ID = 'ptye4'
kobject ptye4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye4'
DEV: registering device: ID = 'ptye5'
kobject ptye5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye5'
DEV: registering device: ID = 'ptye6'
kobject ptye6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye6'
DEV: registering device: ID = 'ptye7'
kobject ptye7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye7'
DEV: registering device: ID = 'ptye8'
kobject ptye8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye8'
DEV: registering device: ID = 'ptye9'
kobject ptye9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye9'
DEV: registering device: ID = 'ptyea'
kobject ptyea: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyea'
DEV: registering device: ID = 'ptyeb'
kobject ptyeb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyeb'
DEV: registering device: ID = 'ptyec'
kobject ptyec: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyec'
DEV: registering device: ID = 'ptyed'
kobject ptyed: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyed'
DEV: registering device: ID = 'ptyee'
kobject ptyee: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyee'
DEV: registering device: ID = 'ptyef'
kobject ptyef: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyef'
DEV: registering device: ID = 'ttyp0'
kobject ttyp0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp0'
DEV: registering device: ID = 'ttyp1'
kobject ttyp1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp1'
DEV: registering device: ID = 'ttyp2'
kobject ttyp2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp2'
DEV: registering device: ID = 'ttyp3'
kobject ttyp3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp3'
DEV: registering device: ID = 'ttyp4'
kobject ttyp4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp4'
DEV: registering device: ID = 'ttyp5'
kobject ttyp5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp5'
DEV: registering device: ID = 'ttyp6'
kobject ttyp6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp6'
DEV: registering device: ID = 'ttyp7'
kobject ttyp7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp7'
DEV: registering device: ID = 'ttyp8'
kobject ttyp8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp8'
DEV: registering device: ID = 'ttyp9'
kobject ttyp9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp9'
DEV: registering device: ID = 'ttypa'
kobject ttypa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypa'
DEV: registering device: ID = 'ttypb'
kobject ttypb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypb'
DEV: registering device: ID = 'ttypc'
kobject ttypc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypc'
DEV: registering device: ID = 'ttypd'
kobject ttypd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypd'
DEV: registering device: ID = 'ttype'
kobject ttype: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttype'
DEV: registering device: ID = 'ttypf'
kobject ttypf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypf'
DEV: registering device: ID = 'ttyq0'
kobject ttyq0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq0'
DEV: registering device: ID = 'ttyq1'
kobject ttyq1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq1'
DEV: registering device: ID = 'ttyq2'
kobject ttyq2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq2'
DEV: registering device: ID = 'ttyq3'
kobject ttyq3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq3'
DEV: registering device: ID = 'ttyq4'
kobject ttyq4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq4'
DEV: registering device: ID = 'ttyq5'
kobject ttyq5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq5'
DEV: registering device: ID = 'ttyq6'
kobject ttyq6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq6'
DEV: registering device: ID = 'ttyq7'
kobject ttyq7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq7'
DEV: registering device: ID = 'ttyq8'
kobject ttyq8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq8'
DEV: registering device: ID = 'ttyq9'
kobject ttyq9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq9'
DEV: registering device: ID = 'ttyqa'
kobject ttyqa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqa'
DEV: registering device: ID = 'ttyqb'
kobject ttyqb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqb'
DEV: registering device: ID = 'ttyqc'
kobject ttyqc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqc'
DEV: registering device: ID = 'ttyqd'
kobject ttyqd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqd'
DEV: registering device: ID = 'ttyqe'
kobject ttyqe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqe'
DEV: registering device: ID = 'ttyqf'
kobject ttyqf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqf'
DEV: registering device: ID = 'ttyr0'
kobject ttyr0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr0'
DEV: registering device: ID = 'ttyr1'
kobject ttyr1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr1'
DEV: registering device: ID = 'ttyr2'
kobject ttyr2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr2'
DEV: registering device: ID = 'ttyr3'
kobject ttyr3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr3'
DEV: registering device: ID = 'ttyr4'
kobject ttyr4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr4'
DEV: registering device: ID = 'ttyr5'
kobject ttyr5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr5'
DEV: registering device: ID = 'ttyr6'
kobject ttyr6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr6'
DEV: registering device: ID = 'ttyr7'
kobject ttyr7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr7'
DEV: registering device: ID = 'ttyr8'
kobject ttyr8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr8'
DEV: registering device: ID = 'ttyr9'
kobject ttyr9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr9'
DEV: registering device: ID = 'ttyra'
kobject ttyra: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyra'
DEV: registering device: ID = 'ttyrb'
kobject ttyrb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrb'
DEV: registering device: ID = 'ttyrc'
kobject ttyrc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrc'
DEV: registering device: ID = 'ttyrd'
kobject ttyrd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrd'
DEV: registering device: ID = 'ttyre'
kobject ttyre: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyre'
DEV: registering device: ID = 'ttyrf'
kobject ttyrf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrf'
DEV: registering device: ID = 'ttys0'
kobject ttys0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys0'
DEV: registering device: ID = 'ttys1'
kobject ttys1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys1'
DEV: registering device: ID = 'ttys2'
kobject ttys2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys2'
DEV: registering device: ID = 'ttys3'
kobject ttys3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys3'
DEV: registering device: ID = 'ttys4'
kobject ttys4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys4'
DEV: registering device: ID = 'ttys5'
kobject ttys5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys5'
DEV: registering device: ID = 'ttys6'
kobject ttys6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys6'
DEV: registering device: ID = 'ttys7'
kobject ttys7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys7'
DEV: registering device: ID = 'ttys8'
kobject ttys8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys8'
DEV: registering device: ID = 'ttys9'
kobject ttys9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys9'
DEV: registering device: ID = 'ttysa'
kobject ttysa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysa'
DEV: registering device: ID = 'ttysb'
kobject ttysb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysb'
DEV: registering device: ID = 'ttysc'
kobject ttysc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysc'
DEV: registering device: ID = 'ttysd'
kobject ttysd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysd'
DEV: registering device: ID = 'ttyse'
kobject ttyse: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyse'
DEV: registering device: ID = 'ttysf'
kobject ttysf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysf'
DEV: registering device: ID = 'ttyt0'
kobject ttyt0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt0'
DEV: registering device: ID = 'ttyt1'
kobject ttyt1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt1'
DEV: registering device: ID = 'ttyt2'
kobject ttyt2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt2'
DEV: registering device: ID = 'ttyt3'
kobject ttyt3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt3'
DEV: registering device: ID = 'ttyt4'
kobject ttyt4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt4'
DEV: registering device: ID = 'ttyt5'
kobject ttyt5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt5'
DEV: registering device: ID = 'ttyt6'
kobject ttyt6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt6'
DEV: registering device: ID = 'ttyt7'
kobject ttyt7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt7'
DEV: registering device: ID = 'ttyt8'
kobject ttyt8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt8'
DEV: registering device: ID = 'ttyt9'
kobject ttyt9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt9'
DEV: registering device: ID = 'ttyta'
kobject ttyta: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyta'
DEV: registering device: ID = 'ttytb'
kobject ttytb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytb'
DEV: registering device: ID = 'ttytc'
kobject ttytc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytc'
DEV: registering device: ID = 'ttytd'
kobject ttytd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytd'
DEV: registering device: ID = 'ttyte'
kobject ttyte: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyte'
DEV: registering device: ID = 'ttytf'
kobject ttytf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytf'
DEV: registering device: ID = 'ttyu0'
kobject ttyu0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu0'
DEV: registering device: ID = 'ttyu1'
kobject ttyu1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu1'
DEV: registering device: ID = 'ttyu2'
kobject ttyu2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu2'
DEV: registering device: ID = 'ttyu3'
kobject ttyu3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu3'
DEV: registering device: ID = 'ttyu4'
kobject ttyu4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu4'
DEV: registering device: ID = 'ttyu5'
kobject ttyu5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu5'
DEV: registering device: ID = 'ttyu6'
kobject ttyu6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu6'
DEV: registering device: ID = 'ttyu7'
kobject ttyu7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu7'
DEV: registering device: ID = 'ttyu8'
kobject ttyu8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu8'
DEV: registering device: ID = 'ttyu9'
kobject ttyu9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu9'
DEV: registering device: ID = 'ttyua'
kobject ttyua: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyua'
DEV: registering device: ID = 'ttyub'
kobject ttyub: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyub'
DEV: registering device: ID = 'ttyuc'
kobject ttyuc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuc'
DEV: registering device: ID = 'ttyud'
kobject ttyud: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyud'
DEV: registering device: ID = 'ttyue'
kobject ttyue: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyue'
DEV: registering device: ID = 'ttyuf'
kobject ttyuf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuf'
DEV: registering device: ID = 'ttyv0'
kobject ttyv0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv0'
DEV: registering device: ID = 'ttyv1'
kobject ttyv1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv1'
DEV: registering device: ID = 'ttyv2'
kobject ttyv2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv2'
DEV: registering device: ID = 'ttyv3'
kobject ttyv3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv3'
DEV: registering device: ID = 'ttyv4'
kobject ttyv4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv4'
DEV: registering device: ID = 'ttyv5'
kobject ttyv5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv5'
DEV: registering device: ID = 'ttyv6'
kobject ttyv6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv6'
DEV: registering device: ID = 'ttyv7'
kobject ttyv7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv7'
DEV: registering device: ID = 'ttyv8'
kobject ttyv8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv8'
DEV: registering device: ID = 'ttyv9'
kobject ttyv9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv9'
DEV: registering device: ID = 'ttyva'
kobject ttyva: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyva'
DEV: registering device: ID = 'ttyvb'
kobject ttyvb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvb'
DEV: registering device: ID = 'ttyvc'
kobject ttyvc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvc'
DEV: registering device: ID = 'ttyvd'
kobject ttyvd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvd'
DEV: registering device: ID = 'ttyve'
kobject ttyve: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyve'
DEV: registering device: ID = 'ttyvf'
kobject ttyvf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvf'
DEV: registering device: ID = 'ttyw0'
kobject ttyw0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw0'
DEV: registering device: ID = 'ttyw1'
kobject ttyw1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw1'
DEV: registering device: ID = 'ttyw2'
kobject ttyw2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw2'
DEV: registering device: ID = 'ttyw3'
kobject ttyw3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw3'
DEV: registering device: ID = 'ttyw4'
kobject ttyw4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw4'
DEV: registering device: ID = 'ttyw5'
kobject ttyw5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw5'
DEV: registering device: ID = 'ttyw6'
kobject ttyw6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw6'
DEV: registering device: ID = 'ttyw7'
kobject ttyw7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw7'
DEV: registering device: ID = 'ttyw8'
kobject ttyw8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw8'
DEV: registering device: ID = 'ttyw9'
kobject ttyw9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw9'
DEV: registering device: ID = 'ttywa'
kobject ttywa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywa'
DEV: registering device: ID = 'ttywb'
kobject ttywb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywb'
DEV: registering device: ID = 'ttywc'
kobject ttywc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywc'
DEV: registering device: ID = 'ttywd'
kobject ttywd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywd'
DEV: registering device: ID = 'ttywe'
kobject ttywe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywe'
DEV: registering device: ID = 'ttywf'
kobject ttywf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywf'
DEV: registering device: ID = 'ttyx0'
kobject ttyx0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx0'
DEV: registering device: ID = 'ttyx1'
kobject ttyx1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx1'
DEV: registering device: ID = 'ttyx2'
kobject ttyx2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx2'
DEV: registering device: ID = 'ttyx3'
kobject ttyx3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx3'
DEV: registering device: ID = 'ttyx4'
kobject ttyx4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx4'
DEV: registering device: ID = 'ttyx5'
kobject ttyx5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx5'
DEV: registering device: ID = 'ttyx6'
kobject ttyx6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx6'
DEV: registering device: ID = 'ttyx7'
kobject ttyx7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx7'
DEV: registering device: ID = 'ttyx8'
kobject ttyx8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx8'
DEV: registering device: ID = 'ttyx9'
kobject ttyx9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx9'
DEV: registering device: ID = 'ttyxa'
kobject ttyxa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxa'
DEV: registering device: ID = 'ttyxb'
kobject ttyxb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxb'
DEV: registering device: ID = 'ttyxc'
kobject ttyxc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxc'
DEV: registering device: ID = 'ttyxd'
kobject ttyxd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxd'
DEV: registering device: ID = 'ttyxe'
kobject ttyxe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxe'
DEV: registering device: ID = 'ttyxf'
kobject ttyxf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxf'
DEV: registering device: ID = 'ttyy0'
kobject ttyy0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy0'
DEV: registering device: ID = 'ttyy1'
kobject ttyy1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy1'
DEV: registering device: ID = 'ttyy2'
kobject ttyy2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy2'
DEV: registering device: ID = 'ttyy3'
kobject ttyy3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy3'
DEV: registering device: ID = 'ttyy4'
kobject ttyy4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy4'
DEV: registering device: ID = 'ttyy5'
kobject ttyy5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy5'
DEV: registering device: ID = 'ttyy6'
kobject ttyy6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy6'
DEV: registering device: ID = 'ttyy7'
kobject ttyy7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy7'
DEV: registering device: ID = 'ttyy8'
kobject ttyy8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy8'
DEV: registering device: ID = 'ttyy9'
kobject ttyy9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy9'
DEV: registering device: ID = 'ttyya'
kobject ttyya: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyya'
DEV: registering device: ID = 'ttyyb'
kobject ttyyb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyb'
DEV: registering device: ID = 'ttyyc'
kobject ttyyc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyc'
DEV: registering device: ID = 'ttyyd'
kobject ttyyd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyd'
DEV: registering device: ID = 'ttyye'
kobject ttyye: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyye'
DEV: registering device: ID = 'ttyyf'
kobject ttyyf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyf'
DEV: registering device: ID = 'ttyz0'
kobject ttyz0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz0'
DEV: registering device: ID = 'ttyz1'
kobject ttyz1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz1'
DEV: registering device: ID = 'ttyz2'
kobject ttyz2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz2'
DEV: registering device: ID = 'ttyz3'
kobject ttyz3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz3'
DEV: registering device: ID = 'ttyz4'
kobject ttyz4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz4'
DEV: registering device: ID = 'ttyz5'
kobject ttyz5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz5'
DEV: registering device: ID = 'ttyz6'
kobject ttyz6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz6'
DEV: registering device: ID = 'ttyz7'
kobject ttyz7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz7'
DEV: registering device: ID = 'ttyz8'
kobject ttyz8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz8'
DEV: registering device: ID = 'ttyz9'
kobject ttyz9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz9'
DEV: registering device: ID = 'ttyza'
kobject ttyza: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyza'
DEV: registering device: ID = 'ttyzb'
kobject ttyzb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzb'
DEV: registering device: ID = 'ttyzc'
kobject ttyzc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzc'
DEV: registering device: ID = 'ttyzd'
kobject ttyzd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzd'
DEV: registering device: ID = 'ttyze'
kobject ttyze: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyze'
DEV: registering device: ID = 'ttyzf'
kobject ttyzf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzf'
DEV: registering device: ID = 'ttya0'
kobject ttya0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya0'
DEV: registering device: ID = 'ttya1'
kobject ttya1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya1'
DEV: registering device: ID = 'ttya2'
kobject ttya2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya2'
DEV: registering device: ID = 'ttya3'
kobject ttya3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya3'
DEV: registering device: ID = 'ttya4'
kobject ttya4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya4'
DEV: registering device: ID = 'ttya5'
kobject ttya5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya5'
DEV: registering device: ID = 'ttya6'
kobject ttya6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya6'
DEV: registering device: ID = 'ttya7'
kobject ttya7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya7'
DEV: registering device: ID = 'ttya8'
kobject ttya8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya8'
DEV: registering device: ID = 'ttya9'
kobject ttya9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya9'
DEV: registering device: ID = 'ttyaa'
kobject ttyaa: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaa'
DEV: registering device: ID = 'ttyab'
kobject ttyab: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyab'
DEV: registering device: ID = 'ttyac'
kobject ttyac: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyac'
DEV: registering device: ID = 'ttyad'
kobject ttyad: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyad'
DEV: registering device: ID = 'ttyae'
kobject ttyae: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyae'
DEV: registering device: ID = 'ttyaf'
kobject ttyaf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaf'
DEV: registering device: ID = 'ttyb0'
kobject ttyb0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb0'
DEV: registering device: ID = 'ttyb1'
kobject ttyb1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb1'
DEV: registering device: ID = 'ttyb2'
kobject ttyb2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb2'
DEV: registering device: ID = 'ttyb3'
kobject ttyb3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb3'
DEV: registering device: ID = 'ttyb4'
kobject ttyb4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb4'
DEV: registering device: ID = 'ttyb5'
kobject ttyb5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb5'
DEV: registering device: ID = 'ttyb6'
kobject ttyb6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb6'
DEV: registering device: ID = 'ttyb7'
kobject ttyb7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb7'
DEV: registering device: ID = 'ttyb8'
kobject ttyb8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb8'
DEV: registering device: ID = 'ttyb9'
kobject ttyb9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb9'
DEV: registering device: ID = 'ttyba'
kobject ttyba: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyba'
DEV: registering device: ID = 'ttybb'
kobject ttybb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybb'
DEV: registering device: ID = 'ttybc'
kobject ttybc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybc'
DEV: registering device: ID = 'ttybd'
kobject ttybd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybd'
DEV: registering device: ID = 'ttybe'
kobject ttybe: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybe'
DEV: registering device: ID = 'ttybf'
kobject ttybf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybf'
DEV: registering device: ID = 'ttyc0'
kobject ttyc0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc0'
DEV: registering device: ID = 'ttyc1'
kobject ttyc1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc1'
DEV: registering device: ID = 'ttyc2'
kobject ttyc2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc2'
DEV: registering device: ID = 'ttyc3'
kobject ttyc3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc3'
DEV: registering device: ID = 'ttyc4'
kobject ttyc4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc4'
DEV: registering device: ID = 'ttyc5'
kobject ttyc5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc5'
DEV: registering device: ID = 'ttyc6'
kobject ttyc6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc6'
DEV: registering device: ID = 'ttyc7'
kobject ttyc7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc7'
DEV: registering device: ID = 'ttyc8'
kobject ttyc8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc8'
DEV: registering device: ID = 'ttyc9'
kobject ttyc9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc9'
DEV: registering device: ID = 'ttyca'
kobject ttyca: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyca'
DEV: registering device: ID = 'ttycb'
kobject ttycb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycb'
DEV: registering device: ID = 'ttycc'
kobject ttycc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycc'
DEV: registering device: ID = 'ttycd'
kobject ttycd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycd'
DEV: registering device: ID = 'ttyce'
kobject ttyce: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyce'
DEV: registering device: ID = 'ttycf'
kobject ttycf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycf'
DEV: registering device: ID = 'ttyd0'
kobject ttyd0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd0'
DEV: registering device: ID = 'ttyd1'
kobject ttyd1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd1'
DEV: registering device: ID = 'ttyd2'
kobject ttyd2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd2'
DEV: registering device: ID = 'ttyd3'
kobject ttyd3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd3'
DEV: registering device: ID = 'ttyd4'
kobject ttyd4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd4'
DEV: registering device: ID = 'ttyd5'
kobject ttyd5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd5'
DEV: registering device: ID = 'ttyd6'
kobject ttyd6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd6'
DEV: registering device: ID = 'ttyd7'
kobject ttyd7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd7'
DEV: registering device: ID = 'ttyd8'
kobject ttyd8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd8'
DEV: registering device: ID = 'ttyd9'
kobject ttyd9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd9'
DEV: registering device: ID = 'ttyda'
kobject ttyda: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyda'
DEV: registering device: ID = 'ttydb'
kobject ttydb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydb'
DEV: registering device: ID = 'ttydc'
kobject ttydc: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydc'
DEV: registering device: ID = 'ttydd'
kobject ttydd: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydd'
DEV: registering device: ID = 'ttyde'
kobject ttyde: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyde'
DEV: registering device: ID = 'ttydf'
kobject ttydf: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydf'
DEV: registering device: ID = 'ttye0'
kobject ttye0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye0'
DEV: registering device: ID = 'ttye1'
kobject ttye1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye1'
DEV: registering device: ID = 'ttye2'
kobject ttye2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye2'
DEV: registering device: ID = 'ttye3'
kobject ttye3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye3'
DEV: registering device: ID = 'ttye4'
kobject ttye4: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye4'
DEV: registering device: ID = 'ttye5'
kobject ttye5: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye5'
DEV: registering device: ID = 'ttye6'
kobject ttye6: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye6'
DEV: registering device: ID = 'ttye7'
kobject ttye7: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye7'
DEV: registering device: ID = 'ttye8'
kobject ttye8: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye8'
DEV: registering device: ID = 'ttye9'
kobject ttye9: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye9'
DEV: registering device: ID = 'ttyea'
kobject ttyea: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyea'
DEV: registering device: ID = 'ttyeb'
kobject ttyeb: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyeb'
DEV: registering device: ID = 'ttyec'
kobject ttyec: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyec'
DEV: registering device: ID = 'ttyed'
kobject ttyed: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyed'
DEV: registering device: ID = 'ttyee'
kobject ttyee: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyee'
DEV: registering device: ID = 'ttyef'
kobject ttyef: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyef'
DEV: registering device: ID = 'rtc'
kobject rtc: registering. parent: misc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/misc/rtc'
rtc: SRM (post-2000) epoch (2000) detected
Real Time Clock Driver v1.12ac
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
Registering platform device 'serial8250'. Parent at platform
DEV: registering device: ID = 'serial8250'
kobject serial8250: registering. parent: platform, set: devices
bus platform: add device serial8250
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/serial8250'
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
DEV: registering device: ID = 'ttyS0'
kobject ttyS0: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS0'
fill_kobj_path: path = '/devices/platform/serial8250'
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
DEV: registering device: ID = 'ttyS1'
kobject ttyS1: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS1'
fill_kobj_path: path = '/devices/platform/serial8250'
DEV: registering device: ID = 'ttyS2'
kobject ttyS2: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS2'
fill_kobj_path: path = '/devices/platform/serial8250'
DEV: registering device: ID = 'ttyS3'
kobject ttyS3: registering. parent: tty, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS3'
fill_kobj_path: path = '/devices/platform/serial8250'
bus platform: add driver serial8250
kobject serial8250: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/platform/drivers/serial8250'
platform: Matched Device serial8250 with Driver serial8250
platform: Probing driver serial8250 with device serial8250
bound device 'serial8250' to driver 'serial8250'
platform: Bound Device serial8250 to Driver serial8250
bus pnp: add driver serial
kobject serial: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pnp/drivers/serial'
bus pci: add driver serial
kobject serial: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/serial'
kobject isa: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/isa'
kobject devices: registering. parent: isa, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: isa, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'isa' registered
DEV: registering device: ID = 'isa'
kobject isa: registering. parent: <NULL>, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
Floppy drive(s): fd0 is 2.88M
FDC 0 is a post-1991 82077
Registering platform device 'floppy.0'. Parent at platform
DEV: registering device: ID = 'floppy.0'
kobject floppy.0: registering. parent: platform, set: devices
bus platform: add device floppy.0
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject fd0: registering. parent: <NULL>, set: block
kobject holders: registering. parent: fd0, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject slaves: registering. parent: fd0, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/block/fd0'
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject queue: registering. parent: fd0, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject iosched: registering. parent: queue, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus pci: add driver via-velocity
kobject via-velocity: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/via-velocity'
pci: Matched Device 0001:02:09.0 with Driver via-velocity
pci: Probing driver via-velocity with device 0001:02:09.0
VIA Networking Velocity Family Gigabit Ethernet Adapter Driver Ver. 1.14
Copyright (c) 2002, 2003 VIA Networking Technologies, Inc.
Copyright (c) 2004 Red Hat Inc.
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bb80, type1=0xfffffc003f02bb78)
mk_conf_addr: returning pci_addr 0xfffffd03fe004806
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x34, pci_addr=0xfffffc003f02bb60, type1=0xfffffc003f02bb58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004834
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x50, pci_addr=0xfffffc003f02bb60, type1=0xfffffc003f02bb58)
mk_conf_addr: returning pci_addr 0xfffffd03fe004850
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x52, pci_addr=0xfffffc003f02bbc0, type1=0xfffffc003f02bbb8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004852
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x54, pci_addr=0xfffffc003f02bbc0, type1=0xfffffc003f02bbb8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004854
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x54, pci_addr=0xfffffc003f02bbd0, type1=0xfffffc003f02bbc8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004854
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x4, pci_addr=0xfffffc003f02bbe0, type1=0xfffffc003f02bbd8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004804
PCI: Calling quirk fffffc000046d600 for 0001:02:09.0
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x4, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd03fe004804
mk_conf_addr(bus=2 ,device_fn=0x48, where=0xd, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00480d
DEV: registering device: ID = 'eth0'
kobject eth0: registering. parent: net, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
eth0: VIA Networking Velocity Family Gigabit Ethernet Adapter
eth0: Ethernet Address: 00:13:49:12:44:DD
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x6, pci_addr=0xfffffc003f02bbb0, type1=0xfffffc003f02bba8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004806
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x34, pci_addr=0xfffffc003f02bb90, type1=0xfffffc003f02bb88)
mk_conf_addr: returning pci_addr 0xfffffd03fe004834
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x50, pci_addr=0xfffffc003f02bb90, type1=0xfffffc003f02bb88)
mk_conf_addr: returning pci_addr 0xfffffd03fe004850
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x52, pci_addr=0xfffffc003f02bbf0, type1=0xfffffc003f02bbe8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004852
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x54, pci_addr=0xfffffc003f02bbf0, type1=0xfffffc003f02bbe8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004854
mk_conf_addr(bus=2 ,device_fn=0x48, where=0x54, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd03fe004854
bound device '0001:02:09.0' to driver 'via-velocity'
pci: Bound Device 0001:02:09.0 to Driver via-velocity
kobject drivers: registering. parent: via_velocity, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus pci: add driver tulip
kobject tulip: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/tulip'
pci: Matched Device 0000:01:02.0 with Driver tulip
pci: Probing driver tulip with device 0000:01:02.0
Linux Tulip driver version 1.1.15 (Feb 27, 2007)
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x6, pci_addr=0xfffffc003f02bb30, type1=0xfffffc003f02bb28)
mk_conf_addr: returning pci_addr 0xfffffd01fe011006
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x4, pci_addr=0xfffffc003f02bb90, type1=0xfffffc003f02bb88)
mk_conf_addr: returning pci_addr 0xfffffd01fe011004
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x4, pci_addr=0xfffffc003f02bbc0, type1=0xfffffc003f02bbb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe011004
mk_conf_addr(bus=1 ,device_fn=0x10, where=0xd, pci_addr=0xfffffc003f02bbb0, type1=0xfffffc003f02bba8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01100d
tulip0:  EEPROM default media type Autosense.
tulip0:  Index #0 - Media MII (#11) described by a 21140 MII PHY (1) block.
tulip0:  MII transceiver #5 config 2100 status 784b advertising 01e1.
DEV: registering device: ID = 'eth1'
kobject eth1: registering. parent: net, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
eth1: Digital DS21140 Tulip rev 34 at MMIO 0x9804000, 00:06:2b:00:d8:05, IRQ 25.
bound device '0000:01:02.0' to driver 'tulip'
pci: Bound Device 0000:01:02.0 to Driver tulip
kobject drivers: registering. parent: tulip, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
kobject ide: registering. parent: <NULL>, set: bus
kobject_uevent_env
fill_kobj_path: path = '/bus/ide'
kobject devices: registering. parent: ide, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: registering. parent: ide, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus type 'ide' registered
CY82C693: IDE controller (0x1080:0xc693 rev 0x00) at  PCI slot 0000:00:05.1
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x6, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd01fe002906
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x4, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002904
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x4, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002904
CY82C693: not 100% native mode: will probe irqs later
CY82C693U driver v0.34 99-13-12 Andreas S. Krebs (akrebs@altavista.net)
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x4, pci_addr=0xfffffc003f02bbc0, type1=0xfffffc003f02bbb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002904
    ide0: BM-DMA at 0x9000-0x9007, BIOS settings: hda:DMA, hdb:pio
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x6, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a06
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x4, pci_addr=0xfffffc003f02bc70, type1=0xfffffc003f02bc68)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a04
PCI: Enabling device: (0000:00:05.2), cmd 7
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x4, pci_addr=0xfffffc003f02bc80, type1=0xfffffc003f02bc78)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a04
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0x4, pci_addr=0xfffffc003f02bcc0, type1=0xfffffc003f02bcb8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a04
CY82C693: port 0x01f0 already claimed by ide0
Probing IDE interface ide0...
hdb: IRQ probe failed (0xfffffffffffffeba)
hdb: IRQ probe failed (0xfffffffffffffeba)
hda: SAMSUNG SP2514N, ATA DISK drive
DEV: registering device: ID = 'ide0'
kobject ide0: registering. parent: 0000:00:05.1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
hda: host max PIO4 wanted PIO255(auto-tune) selected PIO4
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x48, pci_addr=0xfffffc003f02bbf0, type1=0xfffffc003f02bbe8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002948
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x48, pci_addr=0xfffffc003f02bc00, type1=0xfffffc003f02bbf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002948
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x4c, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00294c
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x4d, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd01fe00294d
mk_conf_addr(bus=0 ,device_fn=0x29, where=0x50, pci_addr=0xfffffc003f02bc10, type1=0xfffffc003f02bc08)
mk_conf_addr: returning pci_addr 0xfffffd01fe002950
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
DEV: registering device: ID = '0.0'
kobject 0.0: registering. parent: ide0, set: devices
bus ide: add device 0.0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
bus pci: add driver ALI15x3_IDE
kobject ALI15x3_IDE: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/ALI15x3_IDE'
bus pci: add driver CMD64x_IDE
kobject CMD64x_IDE: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/CMD64x_IDE'
bus pci: add driver Cypress_IDE
kobject Cypress_IDE: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/Cypress_IDE'
pci: Matched Device 0000:00:05.0 with Driver Cypress_IDE
pci: Probing driver Cypress_IDE with device 0000:00:05.0
pci: Matched Device 0000:00:05.1 with Driver Cypress_IDE
pci: Probing driver Cypress_IDE with device 0000:00:05.1
bound device '0000:00:05.1' to driver 'Cypress_IDE'
pci: Bound Device 0000:00:05.1 to Driver Cypress_IDE
pci: Matched Device 0000:00:05.2 with Driver Cypress_IDE
pci: Probing driver Cypress_IDE with device 0000:00:05.2
pci: Matched Device 0000:00:05.3 with Driver Cypress_IDE
pci: Probing driver Cypress_IDE with device 0000:00:05.3
bus pci: add driver PCI_IDE
kobject PCI_IDE: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/PCI_IDE'
pci: Matched Device 0000:00:05.2 with Driver PCI_IDE
pci: Probing driver PCI_IDE with device 0000:00:05.2
Probing IDE interface ide1...
Probing IDE interface ide2...
Probing IDE interface ide3...
bus ide: add driver ide-disk
kobject ide-disk: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/ide/drivers/ide-disk'
ide: Matched Device 0.0 with Driver ide-disk
ide: Probing driver ide-disk with device 0.0
hda: max request size: 512KiB
hda: 488397168 sectors (250059 MB) w/8192KiB Cache, CHS=30401/255/63
hda: cache flushes supported
kobject hda: registering. parent: <NULL>, set: block
kobject holders: registering. parent: hda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject slaves: registering. parent: hda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
 hda: hda1
kobject hda1: registering. parent: hda, set: <NULL>
kobject holders: registering. parent: hda1, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/block/hda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
kobject_uevent_env
fill_kobj_path: path = '/block/hda/hda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
kobject queue: registering. parent: hda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject iosched: registering. parent: queue, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bound device '0.0' to driver 'ide-disk'
ide: Bound Device 0.0 to Driver ide-disk
bus ide: add driver ide-cdrom
kobject ide-cdrom: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/ide/drivers/ide-cdrom'
device class 'spi_transport': registering
kobject spi_transport: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport'
device class 'spi_host': registering
kobject spi_host: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host'
device class 'fc_host': registering
kobject fc_host: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/fc_host'
device class 'fc_vports': registering
kobject fc_vports: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/fc_vports'
device class 'fc_remote_ports': registering
kobject fc_remote_ports: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/fc_remote_ports'
device class 'fc_transport': registering
kobject fc_transport: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/fc_transport'
Loading iSCSI transport class v2.0-724.
device class 'iscsi_transport': registering
kobject iscsi_transport: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_transport'
device class 'iscsi_host': registering
kobject iscsi_host: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_host'
device class 'iscsi_connection': registering
kobject iscsi_connection: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_connection'
device class 'iscsi_session': registering
kobject iscsi_session: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_session'
qlogicfas: no cards were found, please specify I/O address and IRQ using iobase= and irq= options<7>bus pci: add driver qla1280
kobject qla1280: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/qla1280'
QLogic Fibre Channel HBA Driver
bus pci: add driver qla2xxx
kobject qla2xxx: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/qla2xxx'
kobject drivers: registering. parent: qla2xxx, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'qla4xxx'
kobject qla4xxx: registering. parent: iscsi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_transport/qla4xxx'
class_uevent - name = qla4xxx
iscsi: registered transport (qla4xxx)
bus pci: add driver qla4xxx
kobject qla4xxx: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/qla4xxx'
kobject drivers: registering. parent: qla4xxx, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
QLogic iSCSI HBA Driver
bus pci: add driver sym53c8xx
kobject sym53c8xx: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sym53c8xx'
pci: Matched Device 0000:01:00.0 with Driver sym53c8xx
pci: Probing driver sym53c8xx with device 0000:01:00.0
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x6, pci_addr=0xfffffc003f02b990, type1=0xfffffc003f02b988)
mk_conf_addr: returning pci_addr 0xfffffd01fe010006
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x4, pci_addr=0xfffffc003f02b9f0, type1=0xfffffc003f02b9e8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010004
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x4, pci_addr=0xfffffc003f02ba20, type1=0xfffffc003f02ba18)
mk_conf_addr: returning pci_addr 0xfffffd01fe010004
mk_conf_addr(bus=1 ,device_fn=0x0, where=0xd, pci_addr=0xfffffc003f02ba10, type1=0xfffffc003f02ba08)
mk_conf_addr: returning pci_addr 0xfffffd01fe01000d
mk_conf_addr(bus=1 ,device_fn=0x0, where=0xc, pci_addr=0xfffffc003f02ba30, type1=0xfffffc003f02ba28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01000c
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x4, pci_addr=0xfffffc003f02ba20, type1=0xfffffc003f02ba18)
mk_conf_addr: returning pci_addr 0xfffffd01fe010004
PCI: Enabling Mem-Wr-Inval for device 0000:01:00.0
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x4, pci_addr=0xfffffc003f02ba30, type1=0xfffffc003f02ba28)
mk_conf_addr: returning pci_addr 0xfffffd01fe010004
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x6, pci_addr=0xfffffc003f02ba40, type1=0xfffffc003f02ba38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010006
mk_conf_addr(bus=1 ,device_fn=0x0, where=0x84, pci_addr=0xfffffc003f02ba50, type1=0xfffffc003f02ba48)
mk_conf_addr: returning pci_addr 0xfffffd01fe010084
sym0: <875> rev 0x4 at pci 0000:01:00.0 irq 27
sym0: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym0: open drain IRQ line driver, using on-chip SRAM
sym0: using LOAD/STORE-based firmware.
sym0: SCSI BUS has been reset.
scsi0 : sym-2.2.3
DEV: registering device: ID = 'host0'
kobject host0: registering. parent: 0000:01:00.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host0'
kobject host0: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
CLASS: registering class device: ID = 'host0'
kobject host0: registering. parent: spi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
DEV: registering device: ID = 'target0:0:0'
kobject target0:0:0: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:0'
kobject target0:0:0: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:0'
class_uevent - name = target0:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:0'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:0'
class_uevent - name = target0:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:0'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:0: cleaning up
device class 'target0:0:0': release.
kobject target0:0:0: cleaning up
DEV: registering device: ID = 'target0:0:1'
kobject target0:0:1: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:1'
kobject target0:0:1: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:1'
class_uevent - name = target0:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:1'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:1'
class_uevent - name = target0:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:1'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:1: cleaning up
device class 'target0:0:1': release.
kobject target0:0:1: cleaning up
DEV: registering device: ID = 'target0:0:2'
kobject target0:0:2: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:2'
kobject target0:0:2: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:2'
class_uevent - name = target0:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:2'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:2'
class_uevent - name = target0:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:2'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:2: cleaning up
device class 'target0:0:2': release.
kobject target0:0:2: cleaning up
DEV: registering device: ID = 'target0:0:3'
kobject target0:0:3: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:3'
kobject target0:0:3: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:3'
class_uevent - name = target0:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:3'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:3'
class_uevent - name = target0:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:3'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:3: cleaning up
device class 'target0:0:3': release.
kobject target0:0:3: cleaning up
DEV: registering device: ID = 'target0:0:4'
kobject target0:0:4: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:4'
kobject target0:0:4: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:4'
class_uevent - name = target0:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4'
scsi 0:0:4:0: Sequential-Access ARCHIVE  Python 04106-XXX 743B PQ: 0 ANSI: 2
 target0:0:4: Beginning Domain Validation
 target0:0:4: asynchronous
 target0:0:4: FAST-10 SCSI 10.0 MB/s ST (100 ns, offset 15)
 target0:0:4: Domain Validation skipping write tests
 target0:0:4: Ending Domain Validation
DEV: registering device: ID = '0:0:4:0'
kobject 0:0:4:0: registering. parent: target0:0:4, set: devices
bus scsi: add device 0:0:4:0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
CLASS: registering class device: ID = '0:0:4:0'
kobject 0:0:4:0: registering. parent: scsi_device, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/0:0:4:0'
class_uevent - name = 0:0:4:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
DEV: registering device: ID = 'target0:0:5'
kobject target0:0:5: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:5'
kobject target0:0:5: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:5'
class_uevent - name = target0:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:5'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:5'
class_uevent - name = target0:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:5'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:5: cleaning up
device class 'target0:0:5': release.
kobject target0:0:5: cleaning up
DEV: registering device: ID = 'target0:0:6'
kobject target0:0:6: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:6'
kobject target0:0:6: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:6'
class_uevent - name = target0:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:6'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:6'
class_uevent - name = target0:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:6'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:6: cleaning up
device class 'target0:0:6': release.
kobject target0:0:6: cleaning up
DEV: registering device: ID = 'target0:0:8'
kobject target0:0:8: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:8'
kobject target0:0:8: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:8'
class_uevent - name = target0:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:8'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:8'
class_uevent - name = target0:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:8'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:8: cleaning up
device class 'target0:0:8': release.
kobject target0:0:8: cleaning up
DEV: registering device: ID = 'target0:0:9'
kobject target0:0:9: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:9'
kobject target0:0:9: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:9'
class_uevent - name = target0:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:9'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:9'
class_uevent - name = target0:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:9'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:9: cleaning up
device class 'target0:0:9': release.
kobject target0:0:9: cleaning up
DEV: registering device: ID = 'target0:0:10'
kobject target0:0:10: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:10'
kobject target0:0:10: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:10'
class_uevent - name = target0:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:10'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:10'
class_uevent - name = target0:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:10'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:10: cleaning up
device class 'target0:0:10': release.
kobject target0:0:10: cleaning up
DEV: registering device: ID = 'target0:0:11'
kobject target0:0:11: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:11'
kobject target0:0:11: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:11'
class_uevent - name = target0:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:11'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:11'
class_uevent - name = target0:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:11'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:11: cleaning up
device class 'target0:0:11': release.
kobject target0:0:11: cleaning up
DEV: registering device: ID = 'target0:0:12'
kobject target0:0:12: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:12'
kobject target0:0:12: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:12'
class_uevent - name = target0:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:12'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:12'
class_uevent - name = target0:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:12'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:12: cleaning up
device class 'target0:0:12': release.
kobject target0:0:12: cleaning up
DEV: registering device: ID = 'target0:0:13'
kobject target0:0:13: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:13'
kobject target0:0:13: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:13'
class_uevent - name = target0:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:13'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:13'
class_uevent - name = target0:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:13'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:13: cleaning up
device class 'target0:0:13': release.
kobject target0:0:13: cleaning up
DEV: registering device: ID = 'target0:0:14'
kobject target0:0:14: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:14'
kobject target0:0:14: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:14'
class_uevent - name = target0:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:14'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:14'
class_uevent - name = target0:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:14'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:14: cleaning up
device class 'target0:0:14': release.
kobject target0:0:14: cleaning up
DEV: registering device: ID = 'target0:0:15'
kobject target0:0:15: registering. parent: host0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target0:0:15'
kobject target0:0:15: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:15'
class_uevent - name = target0:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:15'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:15'
class_uevent - name = target0:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:15'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target0:0:15: cleaning up
device class 'target0:0:15': release.
kobject target0:0:15: cleaning up
bound device '0000:01:00.0' to driver 'sym53c8xx'
pci: Bound Device 0000:01:00.0 to Driver sym53c8xx
pci: Matched Device 0000:01:01.0 with Driver sym53c8xx
pci: Probing driver sym53c8xx with device 0000:01:01.0
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x6, pci_addr=0xfffffc003f02b990, type1=0xfffffc003f02b988)
mk_conf_addr: returning pci_addr 0xfffffd01fe010806
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x4, pci_addr=0xfffffc003f02b9f0, type1=0xfffffc003f02b9e8)
mk_conf_addr: returning pci_addr 0xfffffd01fe010804
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x4, pci_addr=0xfffffc003f02ba20, type1=0xfffffc003f02ba18)
mk_conf_addr: returning pci_addr 0xfffffd01fe010804
mk_conf_addr(bus=1 ,device_fn=0x8, where=0xd, pci_addr=0xfffffc003f02ba10, type1=0xfffffc003f02ba08)
mk_conf_addr: returning pci_addr 0xfffffd01fe01080d
mk_conf_addr(bus=1 ,device_fn=0x8, where=0xc, pci_addr=0xfffffc003f02ba30, type1=0xfffffc003f02ba28)
mk_conf_addr: returning pci_addr 0xfffffd01fe01080c
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x4, pci_addr=0xfffffc003f02ba20, type1=0xfffffc003f02ba18)
mk_conf_addr: returning pci_addr 0xfffffd01fe010804
PCI: Enabling Mem-Wr-Inval for device 0000:01:01.0
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x4, pci_addr=0xfffffc003f02ba30, type1=0xfffffc003f02ba28)
mk_conf_addr: returning pci_addr 0xfffffd01fe010804
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x6, pci_addr=0xfffffc003f02ba40, type1=0xfffffc003f02ba38)
mk_conf_addr: returning pci_addr 0xfffffd01fe010806
mk_conf_addr(bus=1 ,device_fn=0x8, where=0x84, pci_addr=0xfffffc003f02ba50, type1=0xfffffc003f02ba48)
mk_conf_addr: returning pci_addr 0xfffffd01fe010884
sym1: <875> rev 0x4 at pci 0000:01:01.0 irq 26
sym1: Symbios NVRAM, ID 7, Fast-20, SE, parity checking
sym1: open drain IRQ line driver, using on-chip SRAM
sym1: using LOAD/STORE-based firmware.
sym1: SCSI BUS has been reset.
scsi1 : sym-2.2.3
DEV: registering device: ID = 'host1'
kobject host1: registering. parent: 0000:01:01.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host1'
kobject host1: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
CLASS: registering class device: ID = 'host1'
kobject host1: registering. parent: spi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
DEV: registering device: ID = 'target1:0:0'
kobject target1:0:0: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:0'
kobject target1:0:0: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:0'
class_uevent - name = target1:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:0'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:0'
class_uevent - name = target1:0:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:0'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:0: cleaning up
device class 'target1:0:0': release.
kobject target1:0:0: cleaning up
DEV: registering device: ID = 'target1:0:1'
kobject target1:0:1: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:1'
kobject target1:0:1: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:1'
class_uevent - name = target1:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1'
scsi 1:0:1:0: Direct-Access     FUJITSU  MAJ3091MP        5508 PQ: 0 ANSI: 4
 target1:0:1: tagged command queuing enabled, command queue depth 16.
 target1:0:1: Beginning Domain Validation
 target1:0:1: asynchronous
 target1:0:1: wide asynchronous
 target1:0:1: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 16)
 target1:0:1: Domain Validation skipping write tests
 target1:0:1: Ending Domain Validation
DEV: registering device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: target1:0:1, set: devices
bus scsi: add device 1:0:1:0
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
CLASS: registering class device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: scsi_device, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
DEV: registering device: ID = 'target1:0:2'
kobject target1:0:2: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:2'
kobject target1:0:2: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:2'
class_uevent - name = target1:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:2'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:2'
class_uevent - name = target1:0:2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:2'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:2: cleaning up
device class 'target1:0:2': release.
kobject target1:0:2: cleaning up
DEV: registering device: ID = 'target1:0:3'
kobject target1:0:3: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:3'
kobject target1:0:3: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:3'
class_uevent - name = target1:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:3'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:3'
class_uevent - name = target1:0:3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:3'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:3: cleaning up
device class 'target1:0:3': release.
kobject target1:0:3: cleaning up
DEV: registering device: ID = 'target1:0:4'
kobject target1:0:4: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:4'
kobject target1:0:4: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:4'
class_uevent - name = target1:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:4'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:4'
class_uevent - name = target1:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:4'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:4: cleaning up
device class 'target1:0:4': release.
kobject target1:0:4: cleaning up
DEV: registering device: ID = 'target1:0:5'
kobject target1:0:5: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:5'
kobject target1:0:5: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:5'
class_uevent - name = target1:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:5'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:5'
class_uevent - name = target1:0:5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:5'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:5: cleaning up
device class 'target1:0:5': release.
kobject target1:0:5: cleaning up
DEV: registering device: ID = 'target1:0:6'
kobject target1:0:6: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:6'
kobject target1:0:6: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:6'
class_uevent - name = target1:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:6'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:6'
class_uevent - name = target1:0:6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:6'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:6: cleaning up
device class 'target1:0:6': release.
kobject target1:0:6: cleaning up
DEV: registering device: ID = 'target1:0:8'
kobject target1:0:8: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:8'
kobject target1:0:8: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:8'
class_uevent - name = target1:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:8'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:8'
class_uevent - name = target1:0:8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:8'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:8: cleaning up
device class 'target1:0:8': release.
kobject target1:0:8: cleaning up
DEV: registering device: ID = 'target1:0:9'
kobject target1:0:9: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:9'
kobject target1:0:9: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:9'
class_uevent - name = target1:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:9'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:9'
class_uevent - name = target1:0:9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:9'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:9: cleaning up
device class 'target1:0:9': release.
kobject target1:0:9: cleaning up
DEV: registering device: ID = 'target1:0:10'
kobject target1:0:10: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:10'
kobject target1:0:10: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:10'
class_uevent - name = target1:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:10'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:10'
class_uevent - name = target1:0:10
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:10'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:10: cleaning up
device class 'target1:0:10': release.
kobject target1:0:10: cleaning up
DEV: registering device: ID = 'target1:0:11'
kobject target1:0:11: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:11'
kobject target1:0:11: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:11'
class_uevent - name = target1:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:11'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:11'
class_uevent - name = target1:0:11
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:11'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:11: cleaning up
device class 'target1:0:11': release.
kobject target1:0:11: cleaning up
DEV: registering device: ID = 'target1:0:12'
kobject target1:0:12: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:12'
kobject target1:0:12: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:12'
class_uevent - name = target1:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:12'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:12'
class_uevent - name = target1:0:12
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:12'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:12: cleaning up
device class 'target1:0:12': release.
kobject target1:0:12: cleaning up
DEV: registering device: ID = 'target1:0:13'
kobject target1:0:13: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:13'
kobject target1:0:13: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:13'
class_uevent - name = target1:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:13'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:13'
class_uevent - name = target1:0:13
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:13'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:13: cleaning up
device class 'target1:0:13': release.
kobject target1:0:13: cleaning up
DEV: registering device: ID = 'target1:0:14'
kobject target1:0:14: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:14'
kobject target1:0:14: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:14'
class_uevent - name = target1:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:14'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:14'
class_uevent - name = target1:0:14
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:14'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:14: cleaning up
device class 'target1:0:14': release.
kobject target1:0:14: cleaning up
DEV: registering device: ID = 'target1:0:15'
kobject target1:0:15: registering. parent: host1, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'target1:0:15'
kobject target1:0:15: registering. parent: spi_transport, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:15'
class_uevent - name = target1:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:15'
kobject <NULL>: cleaning up
kobject iosched: cleaning up
kobject queue: cleaning up
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:15'
class_uevent - name = target1:0:15
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:15'
kobject_uevent_env
kobject filter function caused the event to drop!
kobject target1:0:15: cleaning up
device class 'target1:0:15': release.
kobject target1:0:15: cleaning up
bound device '0000:01:01.0' to driver 'sym53c8xx'
pci: Bound Device 0000:01:01.0 to Driver sym53c8xx
kobject drivers: registering. parent: sym53c8xx, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
device class 'scsi_disk': registering
kobject scsi_disk: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk'
Driver 'sd' needs updating - please use bus_type methods
bus scsi: add driver sd
kobject sd: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/sd'
scsi: Matched Device 0:0:4:0 with Driver sd
scsi: Probing driver sd with device 0:0:4:0
scsi: Matched Device 1:0:1:0 with Driver sd
scsi: Probing driver sd with device 1:0:1:0
CLASS: registering class device: ID = '1:0:1:0'
kobject 1:0:1:0: registering. parent: scsi_disk, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
sd 1:0:1:0: [sda] Write Protect is off
sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
kobject sda: registering. parent: <NULL>, set: block
kobject holders: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject slaves: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
sd 1:0:1:0: [sda] 17783239 512-byte hardware sectors (9105 MB)
sd 1:0:1:0: [sda] Write Protect is off
sd 1:0:1:0: [sda] Mode Sense: ab 00 10 08
sd 1:0:1:0: [sda] Write cache: enabled, read cache: enabled, supports DPO and FUA
 sda: sda1 sda2 sda3 sda4
kobject sda1: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda1, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda2: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda2, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda3: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda3, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject sda4: registering. parent: sda, set: <NULL>
kobject holders: registering. parent: sda4, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/block/sda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda2'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda3'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda4'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject queue: registering. parent: sda, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject iosched: registering. parent: queue, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
sd 1:0:1:0: [sda] Attached SCSI disk
bound device '1:0:1:0' to driver 'sd'
scsi: Bound Device 1:0:1:0 to Driver sd
Driver 'sr' needs updating - please use bus_type methods
bus scsi: add driver sr
kobject sr: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/sr'
scsi: Matched Device 0:0:4:0 with Driver sr
scsi: Probing driver sr with device 0:0:4:0
bus platform: add driver i8042
kobject i8042: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/platform/drivers/i8042'
Registering platform device 'i8042'. Parent at platform
DEV: registering device: ID = 'i8042'
kobject i8042: registering. parent: platform, set: devices
bus platform: add device i8042
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042'
platform: Matched Device i8042 with Driver i8042
platform: Probing driver i8042 with device i8042
serio: i8042 KBD port at 0x60,0x64 irq 1
serio: i8042 AUX port at 0x60,0x64 irq 12
bound device 'i8042' to driver 'i8042'
platform: Bound Device i8042 to Driver i8042
DEV: registering device: ID = 'mice'
kobject mice: registering. parent: input, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/input/mice'
DEV: registering device: ID = 'serio0'
kobject serio0: registering. parent: i8042, set: devices
bus serio: add device serio0
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio0'
DEV: registering device: ID = 'psaux'
kobject psaux: registering. parent: misc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/misc/psaux'
DEV: registering device: ID = 'serio1'
kobject serio1: registering. parent: i8042, set: devices
bus serio: add device serio1
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio1'
mice: PS/2 mouse device common for all mice
bus serio: add driver atkbd
kobject atkbd: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/serio/drivers/atkbd'
kobject drivers: registering. parent: atkbd, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
serio: Matched Device serio0 with Driver atkbd
serio: Probing driver atkbd with device serio0
bus serio: add driver psmouse
kobject psmouse: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/serio/drivers/psmouse'
DEV: registering device: ID = 'input0'
kobject input0: registering. parent: input, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/input/input0'
fill_kobj_path: path = '/devices/platform/i8042/serio0'
fill_kobj_path: path = '/class/input/input0'
input: AT Raw Set 2 keyboard as /class/input/input0
bound device 'serio0' to driver 'atkbd'
serio: Bound Device serio0 to Driver atkbd
serio: Matched Device serio1 with Driver atkbd
serio: Probing driver atkbd with device serio1
atkbd.c: keyboard reset failed on isa0060/serio1
kobject <NULL>: cleaning up
kobject drivers: registering. parent: psmouse, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
oprofile: using alpha/ev6 performance monitoring.
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
driver_probe_done: probe_count = 0
serio: Matched Device serio1 with Driver psmouse
serio: Probing driver psmouse with device serio1
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kobject <NULL>: cleaning up
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 160k freed
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/block/fd0'
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject_uevent_env
fill_kobj_path: path = '/block/hda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
kobject_uevent_env
fill_kobj_path: path = '/block/hda/hda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda2'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda3'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/block/sda/sda4'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/input/input0'
fill_kobj_path: path = '/devices/platform/i8042/serio0'
kobject_uevent_env
fill_kobj_path: path = '/class/input/mice'
kobject_uevent_env
fill_kobj_path: path = '/class/iscsi_transport/qla4xxx'
class_uevent - name = qla4xxx
kobject_uevent_env
fill_kobj_path: path = '/class/mem/full'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmem'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/kmsg'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/mem'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/null'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/port'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/random'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/urandom'
kobject_uevent_env
fill_kobj_path: path = '/class/mem/zero'
kobject_uevent_env
fill_kobj_path: path = '/class/misc/psaux'
kobject_uevent_env
fill_kobj_path: path = '/class/misc/rtc'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth1'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/lo'
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:00'
class_uevent - name = 0000:00
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0000:01'
class_uevent - name = 0000:01
kobject_uevent_env
fill_kobj_path: path = '/class/pci_bus/0001:02'
class_uevent - name = 0001:02
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/0:0:4:0'
class_uevent - name = 0:0:4:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_device/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_disk/1:0:1:0'
class_uevent - name = 1:0:1:0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host0'
class_uevent - name = host0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_host/host1'
class_uevent - name = host1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target0:0:4'
class_uevent - name = target0:0:4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4'
kobject_uevent_env
fill_kobj_path: path = '/class/spi_transport/target1:0:1'
class_uevent - name = target1:0:1
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/console'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptmx'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptya9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyab'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyac'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyad'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyae'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyaf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyb9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyba'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptybf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyc9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyca'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyce'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptycf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyd9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyda'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyde'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptydf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptye9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyea'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyeb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyec'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyed'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyee'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyef'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyp9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptype'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptypf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyq9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyqf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyr9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyra'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyre'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyrf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptys9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyse'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptysf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyt9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyta'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyte'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptytf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyu9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyua'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyub'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyud'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyue'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyuf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyv9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyva'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyve'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyvf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyw9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptywf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyx9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyxf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyy9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyya'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyye'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyyf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyz9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyza'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyze'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ptyzf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty10'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty11'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty12'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty13'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty14'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty15'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty16'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty17'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty18'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty19'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty20'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty21'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty22'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty23'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty24'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty25'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty26'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty27'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty28'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty29'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty30'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty31'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty32'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty33'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty34'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty35'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty36'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty37'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty38'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty39'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty40'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty41'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty42'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty43'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty44'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty45'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty46'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty47'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty48'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty49'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty50'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty51'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty52'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty53'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty54'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty55'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty56'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty57'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty58'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty59'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty60'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty61'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty62'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty63'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/tty9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS0'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS1'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS2'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyS3'
fill_kobj_path: path = '/devices/platform/serial8250'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttya9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyab'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyac'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyad'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyae'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyaf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyb9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyba'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttybf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyc9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyca'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyce'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttycf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyd9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyda'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyde'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttydf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttye9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyea'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyeb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyec'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyed'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyee'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyef'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyp9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttype'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttypf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyq9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyqf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr6'
DEVICE: renaming 'eth0' to 'eth0_rename'
fill_kobj_path: path = '/class/net/eth0'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0_rename'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyr9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyra'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyre'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyrf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttys9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyse'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttysf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt1'
DEVICE: renaming 'eth1' to 'eth0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt3'
fill_kobj_path: path = '/class/net/eth1'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth0'
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyt9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyta'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyte'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttytf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyu9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyua'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyub'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyud'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyue'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyuf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyv9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyva'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyve'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyvf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyw9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttywf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyx9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxa'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxe'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyxf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyy9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyya'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyye'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyyf'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz0'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz1'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz2'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz3'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz4'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz5'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz6'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz7'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz8'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyz9'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyza'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzb'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzc'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzd'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyze'
kobject_uevent_env
fill_kobj_path: path = '/class/tty/ttyzf'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vtconsole/vtcon0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.1/ide0/0.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.2'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:05.3'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:01.0/host1/target1:0:1/1:0:1:0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:02.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0000:00/0000:00:09.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/floppy.0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio0'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/i8042/serio1'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/pcspkr'
kobject_uevent_env
fill_kobj_path: path = '/devices/platform/serial8250'
DEVICE: renaming 'eth0_rename' to 'eth1'
fill_kobj_path: path = '/class/net/eth0_rename'
kobject_uevent_env
fill_kobj_path: path = '/class/net/eth1'
fill_kobj_path: path = '/devices/pci0001:02/0001:02:09.0'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject st: registering. parent: <NULL>, set: module
kobject holders: registering. parent: st, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/st'
kobject notes: registering. parent: st, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
st: Version 20070203, fixed bufsize 32768, s/g segs 256
device class 'scsi_tape': registering
kobject scsi_tape: registering. parent: <NULL>, set: class
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape'
Driver 'st' needs updating - please use bus_type methods
bus scsi: add driver st
kobject st: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/scsi/drivers/st'
scsi: Matched Device 0:0:4:0 with Driver st
scsi: Probing driver st with device 0:0:4:0
CLASS: registering class device: ID = 'st0'
kobject st0: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0'
class_uevent - name = st0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0
CLASS: registering class device: ID = 'nst0'
kobject nst0: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0'
class_uevent - name = nst0
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0
CLASS: registering class device: ID = 'st0l'
kobject st0l: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0l'
class_uevent - name = st0l
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0l
CLASS: registering class device: ID = 'nst0l'
kobject nst0l: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0l'
class_uevent - name = nst0l
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0l
CLASS: registering class device: ID = 'st0m'
kobject st0m: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0m'
class_uevent - name = st0m
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0m
CLASS: registering class device: ID = 'nst0m'
kobject nst0m: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0m'
class_uevent - name = nst0m
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0m
CLASS: registering class device: ID = 'st0a'
kobject st0a: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/st0a'
class_uevent - name = st0a
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for st0a
CLASS: registering class device: ID = 'nst0a'
kobject nst0a: registering. parent: scsi_tape, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_tape/nst0a'
class_uevent - name = nst0a
fill_kobj_path: path = '/devices/pci0000:00/0000:00:08.0/0000:01:00.0/host0/target0:0:4/0:0:4:0'
class_device_create_uevent called for nst0a
st 0:0:4:0: Attached scsi tape st0
st 0:0:4:0: st0: try direct i/o: yes (alignment 512 B)
bound device '0:0:4:0' to driver 'st'
scsi: Bound Device 0:0:4:0 to Driver st
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
Adding 1976560k swap on /dev/sda4.  Priority:-1 extents:1 across:1976560k
EXT3 FS on sda3, internal journal
mk_conf_addr(bus=0 ,device_fn=0x28, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00280a
mk_conf_addr(bus=0 ,device_fn=0x29, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00290a
mk_conf_addr(bus=0 ,device_fn=0x2a, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002a0a
mk_conf_addr(bus=0 ,device_fn=0x2b, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe002b0a
mk_conf_addr(bus=0 ,device_fn=0x38, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00380a
mk_conf_addr(bus=0 ,device_fn=0x40, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00400a
mk_conf_addr(bus=0 ,device_fn=0x48, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe00480a
mk_conf_addr(bus=1 ,device_fn=0x0, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01000a
mk_conf_addr(bus=1 ,device_fn=0x8, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01080a
mk_conf_addr(bus=1 ,device_fn=0x10, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd01fe01100a
mk_conf_addr(bus=2 ,device_fn=0x48, where=0xa, pci_addr=0xfffffc003f6d3df0, type1=0xfffffc003f6d3de8)
mk_conf_addr: returning pci_addr 0xfffffd03fe00480a
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x4, pci_addr=0xfffffc003f7a3c80, type1=0xfffffc003f7a3c78)
mk_conf_addr: returning pci_addr 0xfffffd01fe011004
mk_conf_addr(bus=1 ,device_fn=0x10, where=0x4, pci_addr=0xfffffc003f7a3c80, type1=0xfffffc003f7a3c78)
mk_conf_addr: returning pci_addr 0xfffffd01fe011004
kobject 1: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1'
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: Unregistering device. ID = 'vcs2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
kobject vcs2: cleaning up
device_create_release called for vcs2
DEV: Unregistering device. ID = 'vcsa2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
kobject vcsa2: cleaning up
device_create_release called for vcsa2
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: Unregistering device. ID = 'vcs3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
kobject vcs3: cleaning up
device_create_release called for vcs3
DEV: Unregistering device. ID = 'vcsa3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
kobject vcsa3: cleaning up
device_create_release called for vcsa3
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: Unregistering device. ID = 'vcs4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
kobject vcs4: cleaning up
device_create_release called for vcs4
DEV: Unregistering device. ID = 'vcsa4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
kobject vcsa4: cleaning up
device_create_release called for vcsa4
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: Unregistering device. ID = 'vcs5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
kobject vcs5: cleaning up
device_create_release called for vcs5
DEV: Unregistering device. ID = 'vcsa5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
kobject vcsa5: cleaning up
device_create_release called for vcsa5
eth0: Setting full-duplex based on MII#5 link partner capability of c5e1.
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: Unregistering device. ID = 'vcs2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
kobject vcs2: cleaning up
device_create_release called for vcs2
DEV: Unregistering device. ID = 'vcsa2'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
kobject vcsa2: cleaning up
device_create_release called for vcsa2
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: Unregistering device. ID = 'vcs3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
kobject vcs3: cleaning up
device_create_release called for vcs3
DEV: Unregistering device. ID = 'vcsa3'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
kobject vcsa3: cleaning up
device_create_release called for vcsa3
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: Unregistering device. ID = 'vcs4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
kobject vcs4: cleaning up
device_create_release called for vcs4
DEV: Unregistering device. ID = 'vcsa4'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
kobject vcsa4: cleaning up
device_create_release called for vcsa4
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: Unregistering device. ID = 'vcs5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
kobject vcs5: cleaning up
device_create_release called for vcs5
DEV: Unregistering device. ID = 'vcsa5'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
kobject vcsa5: cleaning up
device_create_release called for vcsa5
DEV: registering device: ID = 'vcs6'
kobject vcs6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
DEV: registering device: ID = 'vcsa6'
kobject vcsa6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
DEV: Unregistering device. ID = 'vcs6'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
kobject vcs6: cleaning up
device_create_release called for vcs6
DEV: Unregistering device. ID = 'vcsa6'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
kobject vcsa6: cleaning up
device_create_release called for vcsa6
ndbd(2666): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
ndbd(2666): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
ndbd(2666): unaligned trap at 000000012025652c: 00000001203f00b5 28 1
ndbd(2666): unaligned trap at 0000000120256538: 00000001203f00b5 2c 2
kobject 106: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/106'
kobject 114: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/114'
kobject 115: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/115'
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc77331 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc77331 2c 3
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc77331 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc77331 2c 3
kobject 104: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/104'
kobject 65534: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/65534'
kobject 111: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/111'
kobject 110: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
device eth0 entered promiscuous mode
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc77331 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc77331 2c 3
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc77331 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc77331 2c 3
DEV: Unregistering device. ID = 'vcs1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
kobject vcs1: cleaning up
device_create_release called for vcs1
DEV: Unregistering device. ID = 'vcsa1'
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
kobject vcsa1: cleaning up
device_create_release called for vcsa1
DEV: registering device: ID = 'vcs1'
kobject vcs1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs1'
DEV: registering device: ID = 'vcsa1'
kobject vcsa1: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa1'
DEV: registering device: ID = 'vcs3'
kobject vcs3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs3'
DEV: registering device: ID = 'vcsa3'
kobject vcsa3: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa3'
DEV: registering device: ID = 'vcs2'
kobject vcs2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs2'
DEV: registering device: ID = 'vcsa2'
kobject vcsa2: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa2'
DEV: registering device: ID = 'vcs4'
kobject vcs4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs4'
DEV: registering device: ID = 'vcsa4'
kobject vcsa4: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa4'
DEV: registering device: ID = 'vcs5'
kobject vcs5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs5'
DEV: registering device: ID = 'vcsa5'
kobject vcsa5: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa5'
DEV: registering device: ID = 'vcs6'
kobject vcs6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcs6'
DEV: registering device: ID = 'vcsa6'
kobject vcsa6: registering. parent: vc, set: devices
kobject_uevent_env
fill_kobj_path: path = '/class/vc/vcsa6'
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc772f1 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc772f1 2c 3
dbus-daemon(2826): unaligned trap at 000000012003aef4: 000000011fc772f1 28 3
dbus-daemon(2826): unaligned trap at 000000012003af14: 000000011fc772f1 2c 3
kobject 33: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/33'
kobject 101: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
kobject 1000: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
kobject 110: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/110'
kobject 1000: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject 102: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/1000'
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/102'
kobject libata: registering. parent: <NULL>, set: module
kobject holders: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/libata'
kobject notes: registering. parent: libata, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
libata version 3.00 loaded.
kobject sata_sil24: registering. parent: <NULL>, set: module
kobject holders: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
kobject notes: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus pci: add driver sata_sil24
kobject sata_sil24: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
pci: Matched Device 0000:00:07.0 with Driver sata_sil24
pci: Probing driver sata_sil24 with device 0000:00:07.0
sata_sil24 0000:00:07.0: version 1.1
sata_sil24 0000:00:07.0: init_one ->pcim_enable_device
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x6, pci_addr=0xfffffc003d67ba80, type1=0xfffffc003d67ba78)
mk_conf_addr: returning pci_addr 0xfffffd01fe003806
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x34, pci_addr=0xfffffc003d67ba60, type1=0xfffffc003d67ba58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003834
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x64, pci_addr=0xfffffc003d67ba60, type1=0xfffffc003d67ba58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003864
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x66, pci_addr=0xfffffc003d67bac0, type1=0xfffffc003d67bab8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003866
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x68, pci_addr=0xfffffc003d67bac0, type1=0xfffffc003d67bab8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003868
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x68, pci_addr=0xfffffc003d67bad0, type1=0xfffffc003d67bac8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003868
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc003d67bae0, type1=0xfffffc003d67bad8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_regions
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_table
sata_sil24 0000:00:07.0: init_one -> IRQ-loss PCI-X Errata.
sata_sil24 0000:00:07.0: readl(iomap[SIL24_HOST_BAR] + HOST_CTRL) = 81100000
sata_sil24 0000:00:07.0: Clearing completion IRQ loss on PCI-X errata fix
sata_sil24 0000:00:07.0: init_one -> allocate and fill host
ata_host_alloc_pinfo - allocating 4 ports
ata_host_alloc - ENTER - 4 max_ports
ata_host_alloc - allocating port #0 for host @ 0xfffffc003d636ce8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #1 for host @ 0xfffffc003d636ce8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #2 for host @ 0xfffffc003d636ce8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #3 for host @ 0xfffffc003d636ce8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
sil24_init_one init_one: port:FFFFFD00:09AA0000
sil24_init_one init_one: port:FFFFFD00:09AA2000
sil24_init_one init_one: port:FFFFFD00:09AA4000
sil24_init_one init_one: port:FFFFFD00:09AA6000
sata_sil24 0000:00:07.0: init_one -> setting 64 bit DMA
sata_sil24 0000:00:07.0: init_one -> sil24_init_controller
sil24_init_controller - ENTER
sil24_init_controller - HOST_FLASH_CMD=0C00002F mem present yes
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #0 PORT_CTRL_STAT=001F0001
sil24_init_controller -> sil24_config_port #0.
sil24_config_port port@0xFFFFFC001B878000: - STD PCIX WOC
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #1 PORT_CTRL_STAT=001F0001
sil24_init_controller -> sil24_config_port #1.
sil24_config_port port@0xFFFFFC003D7A4000: - STD PCIX WOC
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #2 PORT_CTRL_STAT=001F0001
sil24_init_controller -> sil24_config_port #2.
sil24_config_port port@0xFFFFFC003D794000: - STD PCIX WOC
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #3 PORT_CTRL_STAT=001F0001
sil24_init_controller -> sil24_config_port #3.
sil24_config_port port@0xFFFFFC003D744000: - STD PCIX WOC
sil24_init_controller - Enabling interrupts...
sata_sil24 0000:00:07.0: init_one -> setting master
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc003d67bb30, type1=0xfffffc003d67bb28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
mk_conf_addr(bus=0 ,device_fn=0x38, where=0xd, pci_addr=0xfffffc003d67bb20, type1=0xfffffc003d67bb18)
mk_conf_addr: returning pci_addr 0xfffffd01fe00380d
sata_sil24 0000:00:07.0: init_one -> ata_host_activate
ata_host_activate - ENTER
ata_host_activate - 2
ata_host_activate - 3
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
ata_host_activate - 4
ata_host_activate - 6
ata_host_activate - 7 registering
scsi2 : sata_sil24
DEV: registering device: ID = 'host2'
kobject host2: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host2'
kobject host2: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host2'
class_uevent - name = host2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host2'
scsi3 : sata_sil24
DEV: registering device: ID = 'host3'
kobject host3: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host3'
kobject host3: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host3'
class_uevent - name = host3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host3'
scsi4 : sata_sil24
DEV: registering device: ID = 'host4'
kobject host4: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host4'
kobject host4: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host4'
class_uevent - name = host4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host4'
scsi5 : sata_sil24
DEV: registering device: ID = 'host5'
kobject host5: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host5'
kobject host5: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host5'
class_uevent - name = host5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host5'
ata1: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata2: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata3: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata4: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata1: ata_port_flush_task: EXIT
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata1.00: ata_eh_recover - 6
ata1.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: sil24_hardreset - ENTER
ata1: hardreset - sata_set_spd!
ata1: hardreset - link is online - tout = 5000!
ata1: hardreset - debouncing!
ata1: hardreset  -EAGAIN!
ata1: PHYS - something is attached.
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: sil24_exec_polled_cmd irq_enabled = 00B40000
ata1: sil24_exec_polled_cmd paddr  HI:00000000  LO:9B800000
ata1: sil24_exec_polled_cmd irq_stat = 00B50000
ata1: sil24_exec_polled_cmd cleared IRQs
ata1: sil24_exec_polled_cmd IRQ_COMPLETE
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0 SError 4050000)
ata1: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA0000) PORT_IRQ_STAT=00040000
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata1: ata_eh_revalidate_and_attach - Seems to be a PMP attached.
ata1.00: sata_pmp_attach - ENTER
ata1.15: ata_exec_internal_sg - ENTER
ata1.15: ata_exec_internal_sg - tag = 1F.
ata1.15: ata_exec_internal_sg - ata_qc_reinit.
ata1.15: ata_exec_internal_sg - DMA_NONE
ata_qc_issue - ENTER
ata_qc_issue - protocol is non-NCQ - sactive=00000000
ata_qc_issue - not mapping DMA
sil24_qc_issue - issuing qc cmd to port @ 9AA0000
sil24_qc_issue - paddr:9b800000
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
sil24_qc_issue - qc cmd err for port @ 9AA0000 (00000000)
ata1: ata_port_flush_task: EXIT
ata1.15: ata_exec_internal_sg - wait_for_completion_timeout returned (0)
ata1: ata_exec_internal_sg - freezing port
__ata_qc_complete - ENTER
ata_qc_complete_internal - ENTER
ata1.15: qc timeout (cmd 0xe4)
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=80000000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: sata_pmp_attach - sata_pmp_read_gscr FAILED. (-5)
ata1.15: sata_pmp_attach - failed to attach PMP. (-5)
ata1: failed to recover some devices, retrying in 5 secs
kobject 101: registering. parent: uids, set: <NULL>
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: sil24_hardreset - ENTER
ata1: hardreset - sata_set_spd!
ata1: hardreset - link is online - tout = 5000!
ata1: hardreset - debouncing!
ata1: hardreset  -EAGAIN!
ata1: PHYS - something is attached.
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: sil24_exec_polled_cmd irq_enabled = 00B40000
ata1: sil24_exec_polled_cmd paddr  HI:00000000  LO:9B800000
ata1: sil24_exec_polled_cmd irq_stat = 00B50000
ata1: sil24_exec_polled_cmd cleared IRQs
ata1: sil24_exec_polled_cmd IRQ_COMPLETE
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0 SError 4050000)
ata1: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA0000) PORT_IRQ_STAT=00040000
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata1: ata_eh_revalidate_and_attach - Seems to be a PMP attached.
ata1.00: sata_pmp_attach - ENTER
ata1.15: ata_exec_internal_sg - ENTER
ata1.15: ata_exec_internal_sg - tag = 1F.
ata1.15: ata_exec_internal_sg - ata_qc_reinit.
ata1.15: ata_exec_internal_sg - DMA_NONE
ata_qc_issue - ENTER
ata_qc_issue - protocol is non-NCQ - sactive=00000000
ata_qc_issue - not mapping DMA
sil24_qc_issue - issuing qc cmd to port @ 9AA0000
sil24_qc_issue - paddr:9b800000
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
sil24_qc_issue - qc cmd err for port @ 9AA0000 (00000000)
ata1: ata_port_flush_task: EXIT
ata1.15: ata_exec_internal_sg - wait_for_completion_timeout returned (0)
ata1: ata_exec_internal_sg - freezing port
__ata_qc_complete - ENTER
ata_qc_complete_internal - ENTER
ata1.15: qc timeout (cmd 0xe4)
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=80000000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: sata_pmp_attach - sata_pmp_read_gscr FAILED. (-5)
ata1.15: sata_pmp_attach - failed to attach PMP. (-5)
ata1: failed to recover some devices, retrying in 5 secs
kobject_uevent_env
fill_kobj_path: path = '/kernel/uids/101'
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: sil24_hardreset - ENTER
ata1: hardreset - sata_set_spd!
ata1: hardreset - link is online - tout = 5000!
ata1: hardreset - debouncing!
ata1: hardreset  -EAGAIN!
ata1: PHYS - something is attached.
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: sil24_exec_polled_cmd irq_enabled = 00B40000
ata1: sil24_exec_polled_cmd paddr  HI:00000000  LO:9B800000
ata1: sil24_exec_polled_cmd irq_stat = 00B50000
ata1: sil24_exec_polled_cmd cleared IRQs
ata1: sil24_exec_polled_cmd IRQ_COMPLETE
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0 SError 4050000)
ata1: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA0000) PORT_IRQ_STAT=00040000
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata1: ata_eh_revalidate_and_attach - Seems to be a PMP attached.
ata1.00: sata_pmp_attach - ENTER
ata1.15: ata_exec_internal_sg - ENTER
ata1.15: ata_exec_internal_sg - tag = 1F.
ata1.15: ata_exec_internal_sg - ata_qc_reinit.
ata1.15: ata_exec_internal_sg - DMA_NONE
ata_qc_issue - ENTER
ata_qc_issue - protocol is non-NCQ - sactive=00000000
ata_qc_issue - not mapping DMA
sil24_qc_issue - issuing qc cmd to port @ 9AA0000
sil24_qc_issue - paddr:9b800000
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
sil24_qc_issue - qc cmd err for port @ 9AA0000 (00000000)
ata1: ata_port_flush_task: EXIT
ata1.15: ata_exec_internal_sg - wait_for_completion_timeout returned (0)
ata1: ata_exec_internal_sg - freezing port
__ata_qc_complete - ENTER
ata_qc_complete_internal - ENTER
ata1.15: qc timeout (cmd 0xe4)
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=80000000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1.15: failed to read PMP GSCR[0] (Emask=0x4)
ata1.15: sata_pmp_attach - sata_pmp_read_gscr FAILED. (-5)
ata1.15: sata_pmp_attach - failed to attach PMP. (-5)
ata1: failed to recover some devices, retrying in 5 secs
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata1: ata_eh_recover -> ata_eh_reset

ata1: hard resetting link
ata1: sil24_hardreset - ENTER
ata1: hardreset - sata_set_spd!
ata1: hardreset - link is online - tout = 5000!
ata1: hardreset - debouncing!
ata1: hardreset  -EAGAIN!
ata1: PHYS - something is attached.
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: sil24_exec_polled_cmd irq_enabled = 00B40000
ata1: sil24_exec_polled_cmd paddr  HI:00000000  LO:9B800000
ata1: sil24_exec_polled_cmd irq_stat = 00B50000
ata1: sil24_exec_polled_cmd cleared IRQs
ata1: sil24_exec_polled_cmd IRQ_COMPLETE
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 0 SError 4050000)
ata1: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA0000) PORT_IRQ_STAT=00040000
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata_eh_recover -> link okay?!
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=80000000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - no reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata_eh_recover -> link okay?!
ata2: ata_port_flush_task: EXIT
ata2: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata2: sil24_init_port - PORT_SLOT_STAT=00000000
ata2: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata2: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata2: sil24_init_port - port is ready.
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata2.00: ata_eh_recover - 6
ata2.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata2: ata_eh_recover -> ata_eh_reset

ata2: hard resetting link
ata2: sil24_hardreset - ENTER
ata2: hardreset - sata_set_spd!
ata2: hardreset - debouncing!
ata2: hardreset  -EAGAIN!
ata2: PHYS - no device
ata2: SATA link down (SStatus 0 SControl 0 SError 0)
ata2: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA2000) PORT_IRQ_STAT=00040000
ata2: ata_eh_recover -> revalidate_and_attach
ata2: ata_eh_revalidate_and_attach - ENTER
ata_eh_recover -> link okay?!
ata3: ata_port_flush_task: EXIT
ata3: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata3: sil24_init_port - PORT_SLOT_STAT=00000000
ata3: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata3: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata3: sil24_init_port - port is ready.
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata3.00: ata_eh_recover - 6
ata3.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - reset
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata3: ata_eh_recover -> ata_eh_reset

ata3: hard resetting link
ata3: sil24_hardreset - ENTER
ata3: hardreset - sata_set_spd!
ata3: hardreset - debouncing!
ata3: hardreset  -EAGAIN!
ata3: PHYS - no device
ata3: SATA link down (SStatus 0 SControl 0 SError 0)
ata3: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA4000) PORT_IRQ_STAT=00040000
ata3: ata_eh_recover -> revalidate_and_attach
ata3: ata_eh_revalidate_and_attach - ENTER
ata_eh_recover -> link okay?!
ata4: ata_port_flush_task: EXIT
ata4: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata4: sil24_init_port - PORT_SLOT_STAT=00000000
ata4: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata4: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata4: sil24_init_port - port is ready.
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata4.00: ata_eh_recover - 6
ata4.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata4: ata_eh_recover -> ata_eh_reset

ata4: hard resetting link
ata4: sil24_hardreset - ENTER
ata4: hardreset - sata_set_spd!
ata4: hardreset - debouncing!
ata4: hardreset  -EAGAIN!
ata4: PHYS - no device
ata4: SATA link down (SStatus 0 SControl 0 SError 0)
ata4: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA6000) PORT_IRQ_STAT=00040000
ata4: ata_eh_recover -> revalidate_and_attach
ata4: ata_eh_revalidate_and_attach - ENTER
ata_eh_recover -> link okay?!
bound device '0000:00:07.0' to driver 'sata_sil24'
pci: Bound Device 0000:00:07.0 to Driver sata_sil24
kobject drivers: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
ata1: ata_port_flush_task: EXIT
ata1: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - PORT_SLOT_STAT=00000000
ata1: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata1: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata1: sil24_init_port - port is ready.
ata1: ata_eh_recover - 1
ata1: ata_eh_recover - 2 re-enable link?
ata1.00: ata_eh_recover - 3
ata1.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata1: ata_eh_recover - 8a prep for EH
ata1: ata_eh_recover - no reset
ata1: ata_eh_recover - ATA_DEV_UNKNOWN
ata1: ata_eh_recover -> revalidate_and_attach
ata1: ata_eh_revalidate_and_attach - ENTER
ata1: attemping to enable power management!
ata_eh_recover -> link okay?!
ata2: ata_port_flush_task: EXIT
ata2: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata2: sil24_init_port - PORT_SLOT_STAT=00000000
ata2: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata2: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata2: sil24_init_port - port is ready.
ata2: ata_eh_recover - 1
ata2: ata_eh_recover - 2 re-enable link?
ata2.00: ata_eh_recover - 3
ata2.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata2: ata_eh_recover - 8a prep for EH
ata2: ata_eh_recover - no reset
ata2: ata_eh_recover - ATA_DEV_UNKNOWN
ata2: ata_eh_recover -> revalidate_and_attach
ata2: ata_eh_revalidate_and_attach - ENTER
ata2: attemping to enable power management!
ata_eh_recover -> link okay?!
ata3: ata_port_flush_task: EXIT
ata3: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata3: sil24_init_port - PORT_SLOT_STAT=00000000
ata3: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata3: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata3: sil24_init_port - port is ready.
ata3: ata_eh_recover - 1
ata3: ata_eh_recover - 2 re-enable link?
ata3.00: ata_eh_recover - 3
ata3.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata3: ata_eh_recover - 8a prep for EH
ata3: ata_eh_recover - no reset
ata4: ata_port_flush_task: EXIT
ata4: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=001F0000
ata4: sil24_init_port - PORT_SLOT_STAT=00000000
ata4: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata4: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata4: sil24_init_port - port is ready.
ata4: ata_eh_recover - 1
ata4: ata_eh_recover - 2 re-enable link?
ata4.00: ata_eh_recover - 3
ata4.00: ata_eh_recover - 5
ata_eh_recover - 8 - retry
ata4: ata_eh_recover - 8a prep for EH
ata4: ata_eh_recover - no reset
ata4: ata_eh_recover - ATA_DEV_UNKNOWN
ata4: ata_eh_recover -> revalidate_and_attach
ata4: ata_eh_revalidate_and_attach - ENTER
ata4: attemping to enable power management!
ata_eh_recover -> link okay?!
ata3: ata_eh_recover - ATA_DEV_UNKNOWN
ata3: ata_eh_recover -> revalidate_and_attach
ata3: ata_eh_revalidate_and_attach - ENTER
ata3: attemping to enable power management!
ata_eh_recover -> link okay?!
bus pci: remove driver sata_sil24
ata1: ata_port_flush_task: EXIT
CLASS: Unregistering class device. ID = 'host2'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host2'
class_uevent - name = host2
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host2'
kobject host2: cleaning up
device class 'host2': release.
kobject_uevent_env
kobject filter function caused the event to drop!
ata2: ata_port_flush_task: EXIT
CLASS: Unregistering class device. ID = 'host3'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host3'
class_uevent - name = host3
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host3'
kobject host3: cleaning up
device class 'host3': release.
kobject_uevent_env
kobject filter function caused the event to drop!
ata3: ata_port_flush_task: EXIT
CLASS: Unregistering class device. ID = 'host4'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host4'
class_uevent - name = host4
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host4'
kobject host4: cleaning up
device class 'host4': release.
kobject_uevent_env
kobject filter function caused the event to drop!
ata4: ata_port_flush_task: EXIT
CLASS: Unregistering class device. ID = 'host5'
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host5'
class_uevent - name = host5
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host5'
kobject host5: cleaning up
device class 'host5': release.
kobject_uevent_env
kobject filter function caused the event to drop!
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
kobject host2: cleaning up
kobject host3: cleaning up
kobject host4: cleaning up
kobject host5: cleaning up
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc003d67bcf0, type1=0xfffffc003d67bce8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc003d67bd00, type1=0xfffffc003d67bcf8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
kobject sata_sil24: cleaning up
kobject drivers: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject drivers: cleaning up
kobject holders: unregistering
kobject_uevent_env
kobject filter function caused the event to drop!
kobject holders: cleaning up
kobject sata_sil24: unregistering
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
kobject sata_sil24: registering. parent: <NULL>, set: module
kobject holders: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
kobject_uevent_env
fill_kobj_path: path = '/module/sata_sil24'
kobject notes: registering. parent: sata_sil24, set: <NULL>
kobject_uevent_env
kobject filter function caused the event to drop!
bus pci: add driver sata_sil24
kobject sata_sil24: registering. parent: <NULL>, set: drivers
kobject_uevent_env
fill_kobj_path: path = '/bus/pci/drivers/sata_sil24'
pci: Matched Device 0000:00:07.0 with Driver sata_sil24
pci: Probing driver sata_sil24 with device 0000:00:07.0
sata_sil24 0000:00:07.0: version 1.1
sata_sil24 0000:00:07.0: init_one ->pcim_enable_device
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x6, pci_addr=0xfffffc001b87ba80, type1=0xfffffc001b87ba78)
mk_conf_addr: returning pci_addr 0xfffffd01fe003806
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x34, pci_addr=0xfffffc001b87ba60, type1=0xfffffc001b87ba58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003834
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x64, pci_addr=0xfffffc001b87ba60, type1=0xfffffc001b87ba58)
mk_conf_addr: returning pci_addr 0xfffffd01fe003864
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x66, pci_addr=0xfffffc001b87bac0, type1=0xfffffc001b87bab8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003866
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x68, pci_addr=0xfffffc001b87bac0, type1=0xfffffc001b87bab8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003868
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x68, pci_addr=0xfffffc001b87bad0, type1=0xfffffc001b87bac8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003868
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc001b87bae0, type1=0xfffffc001b87bad8)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_regions
sata_sil24 0000:00:07.0: init_one ->pcim_iomap_table
sata_sil24 0000:00:07.0: init_one -> IRQ-loss PCI-X Errata.
sata_sil24 0000:00:07.0: readl(iomap[SIL24_HOST_BAR] + HOST_CTRL) = 1110000F
sata_sil24 0000:00:07.0: Clearing completion IRQ loss on PCI-X errata fix
sata_sil24 0000:00:07.0: init_one -> allocate and fill host
ata_host_alloc_pinfo - allocating 4 ports
ata_host_alloc - ENTER - 4 max_ports
ata_host_alloc - allocating port #0 for host @ 0xfffffc003d6367a8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #1 for host @ 0xfffffc003d6367a8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #2 for host @ 0xfffffc003d6367a8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
ata_host_alloc - allocating port #3 for host @ 0xfffffc003d6367a8
ata_port_alloc - ENTER - 1 max_ports
ata_link_init - pmp = 0
sil24_init_one init_one: port:FFFFFD00:09AA0000
sil24_init_one init_one: port:FFFFFD00:09AA2000
sil24_init_one init_one: port:FFFFFD00:09AA4000
sil24_init_one init_one: port:FFFFFD00:09AA6000
sata_sil24 0000:00:07.0: init_one -> setting 64 bit DMA
sata_sil24 0000:00:07.0: init_one -> sil24_init_controller
sil24_init_controller - ENTER
sil24_init_controller - HOST_FLASH_CMD=0C000000 mem present no
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #0 PORT_CTRL_STAT=801F0000
sil24_init_controller - port #0 PORT_CS_PORT_RST not set.
sil24_init_controller -> sil24_config_port #0.
sil24_config_port port@0x9AA0000: - STD PCIX WOC
sil24_config_port - port @ 9AA0000, handshake errors: 0
sil24_config_port - port @ 9AA0000, decode errors: 0
sil24_config_port - port @ 9AA0000, crc errors: 0
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #1 PORT_CTRL_STAT=801F0000
sil24_init_controller - port #1 PORT_CS_PORT_RST not set.
sil24_init_controller -> sil24_config_port #1.
sil24_config_port port@0x9AA2000: - STD PCIX WOC
sil24_config_port - port @ 9AA2000, handshake errors: 0
sil24_config_port - port @ 9AA2000, decode errors: 0
sil24_config_port - port @ 9AA2000, crc errors: 0
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #2 PORT_CTRL_STAT=801F0000
sil24_init_controller - port #2 PORT_CS_PORT_RST not set.
sil24_init_controller -> sil24_config_port #2.
sil24_config_port port@0x9AA4000: - STD PCIX WOC
sil24_config_port - port @ 9AA4000, handshake errors: 0
sil24_config_port - port @ 9AA4000, decode errors: 0
sil24_config_port - port @ 9AA4000, crc errors: 0
sil24_init_controller - setting initial PHY
sil24_init_controller - PORT_PHY_CFG=0000020C
sil24_init_controller - port #3 PORT_CTRL_STAT=801F0000
sil24_init_controller - port #3 PORT_CS_PORT_RST not set.
sil24_init_controller -> sil24_config_port #3.
sil24_config_port port@0x9AA6000: - STD PCIX WOC
sil24_config_port - port @ 9AA6000, handshake errors: 0
sil24_config_port - port @ 9AA6000, decode errors: 0
sil24_config_port - port @ 9AA6000, crc errors: 0
sil24_init_controller - Enabling interrupts...
sata_sil24 0000:00:07.0: init_one -> setting master
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc001b87bb30, type1=0xfffffc001b87bb28)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
PCI: Enabling bus mastering for device 0000:00:07.0
mk_conf_addr(bus=0 ,device_fn=0x38, where=0x4, pci_addr=0xfffffc001b87bb40, type1=0xfffffc001b87bb38)
mk_conf_addr: returning pci_addr 0xfffffd01fe003804
mk_conf_addr(bus=0 ,device_fn=0x38, where=0xd, pci_addr=0xfffffc001b87bb20, type1=0xfffffc001b87bb18)
mk_conf_addr: returning pci_addr 0xfffffd01fe00380d
sata_sil24 0000:00:07.0: init_one -> ata_host_activate
ata_host_activate - ENTER
ata_host_activate - 2
ata_host_activate - 3
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
ata_host_activate - 4
ata_host_activate - 6
ata_host_activate - 7 registering
scsi6 : sata_sil24
DEV: registering device: ID = 'host6'
kobject host6: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host6'
kobject host6: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host6'
class_uevent - name = host6
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host6'
scsi7 : sata_sil24
DEV: registering device: ID = 'host7'
kobject host7: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host7'
kobject host7: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host7'
class_uevent - name = host7
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host7'
scsi8 : sata_sil24
DEV: registering device: ID = 'host8'
kobject host8: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host8'
kobject host8: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host8'
class_uevent - name = host8
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host8'
scsi9 : sata_sil24
DEV: registering device: ID = 'host9'
kobject host9: registering. parent: 0000:00:07.0, set: devices
kobject_uevent_env
kobject filter function caused the event to drop!
CLASS: registering class device: ID = 'host9'
kobject host9: registering. parent: scsi_host, set: class_obj
kobject_uevent_env
fill_kobj_path: path = '/class/scsi_host/host9'
class_uevent - name = host9
fill_kobj_path: path = '/devices/pci0000:00/0000:00:07.0/host9'
ata5: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa0000 irq 31
ata6: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa2000 irq 31
ata7: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa4000 irq 31
ata8: SATA max UDMA/100 host m128@0x9aa9000 port 0x9aa6000 irq 31
ata5: ata_port_flush_task: EXIT
ata5: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - PORT_SLOT_STAT=00000000
ata5: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - port is ready.
ata5: ata_eh_recover - 1
ata5: ata_eh_recover - 2 re-enable link?
ata5.00: ata_eh_recover - 3
ata5.00: ata_eh_recover - 5
ata5.00: ata_eh_recover - 6
ata5.00: ata_eh_recover -> ata_dev_init 7
ata_eh_recover - 8 - retry
ata5: ata_eh_recover - 8a prep for EH
ata5: ata_eh_recover - reset
ata5: ata_eh_recover - ATA_DEV_UNKNOWN
ata_eh_recover - 9 - reset is true
ata_eh_recover -> freezing port -> nr_pmp_links == 0
ata5: ata_eh_recover -> ata_eh_reset

ata5: hard resetting link
ata5: sil24_hardreset - ENTER
ata5: hardreset - sata_set_spd!
ata5: hardreset - link is online - tout = 5000!
ata5: hardreset - debouncing!
ata5: hardreset  -EAGAIN!
ata5: PHYS - something is attached.
ata5: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - PORT_SLOT_STAT=00000000
ata5: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - port is ready.
ata5: sil24_exec_polled_cmd irq_enabled = 00B40000
ata5: sil24_exec_polled_cmd paddr  HI:00000000  LO:9B980000
ata5: sil24_exec_polled_cmd irq_stat = 00B50000
ata5: sil24_exec_polled_cmd cleared IRQs
ata5: sil24_exec_polled_cmd IRQ_COMPLETE
ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 0 SError 4050000)
ata5: ata_eh_recover -> thawing
sil24_thaw - ENTER (port @ 9AA0000) PORT_IRQ_STAT=00040000
ata5: ata_eh_recover -> revalidate_and_attach
ata5: ata_eh_revalidate_and_attach - ENTER
ata5: ata_eh_revalidate_and_attach - Seems to be a PMP attached.
ata5.00: sata_pmp_attach - ENTER
ata5.15: ata_exec_internal_sg - ENTER
ata5.15: ata_exec_internal_sg - tag = 1F.
ata5.15: ata_exec_internal_sg - ata_qc_reinit.
ata5.15: ata_exec_internal_sg - DMA_NONE
ata_qc_issue - ENTER
ata_qc_issue - protocol is non-NCQ - sactive=00000000
ata_qc_issue - not mapping DMA
sil24_qc_issue - issuing qc cmd to port @ 9AA0000
sil24_qc_issue - paddr:9b980000
sil24_interrupt - ENTER via irq 31
sil24_interrupt - HOST_SLOT_STAT = 00000000
sil24_interrupt - HOST_IRQ_STAT = 00000000
sil24_interrupt - IRQ_STAT_4PORTS - goto out;
ata5: ata_port_flush_task: EXIT
ata5.15: ata_exec_internal_sg - wait_for_completion_timeout returned (0)
ata5: ata_exec_internal_sg - freezing port
__ata_qc_complete - ENTER
ata_qc_complete_internal - ENTER
ata5.15: qc timeout (cmd 0xe4)
ata5: sil24_init_port - ENTER nr_pmp_links = 0, PORT_CTRL_STAT=80000000
ata5: sil24_init_port - PORT_SLOT_STAT=00000000
ata5: sil24_init_port - post PORT_CS_INIT, PORT_CTRL_STAT=001F0000
ata5: sil24_init_port - waiting for PORT_CS_RDY, PORT_CTRL_STAT=801F0000
ata5: sil24_init_port - port is ready.
ata5.15: failed to read PMP GSCR[0] (Emask=0x4)
ata5.15: sata_pmp_attach - sata_pmp_read_gscr FAILED. (-5)
ata5.15: sata_pmp_attach - failed to attach PMP. (-5)
ata5: failed to recover some devices, retrying in 5 secs

--------------030400070100020003050702--
