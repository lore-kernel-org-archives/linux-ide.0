From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Subject: mv 88SX5040 driver in Linux-2.6.15-rc5-git1
Date: Thu, 15 Dec 2005 17:30:56 +0800
Message-ID: <9FCDBA58F226D911B202000BDBAD4673041ACA75@zch01exm40.ap.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw02.freescale.net ([192.88.165.103]:31709 "EHLO
	de01egw02.freescale.net") by vger.kernel.org with ESMTP
	id S1422652AbVLOJbE (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 15 Dec 2005 04:31:04 -0500
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id jBF9bwfm001624
	for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2005 02:37:58 -0700 (MST)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net [10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id jBF9YGjT003968
	for <linux-ide@vger.kernel.org>; Thu, 15 Dec 2005 03:34:17 -0600 (CST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Zang Roy-r61911 <tie-fei.zang@freescale.com>

Hi, all

    I download Linux-2.6.15-rc5-git1 and apply it to my PowerPC(MPC7448) architecture board. There is a mv 88SX5040 chip on the board. I found there was some issue with this driver. Originally, my driver can work well in Linux 2.6.11.11, which make sure the hardware is OK.
    Is there any suggestion about this issue.
    The following is my screen information:
=> tftp 1000000 uImage.7448.git.118
Using TSI108_eth0 device
TFTP from server 10.193.20.105; our IP address is 10.193.20.118
Filename 'uImage.7448.git.118'.
Load address: 0x1000000
Loading: #################################################################
         #################################################################
         #################################################################
         #################################################################
         #################################################################
         ############
done
Bytes transferred = 1724306 (1a4f92 hex)
=> bootm 1000000
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.15-rc5-git1
   Created:      2005-12-15   5:48:31 UTC
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1724242 Bytes =  1.6 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
id mach(): done
MMU:enter
MMU:hw init
hash:enter
hash:find piece
hash:patch
hash:done
MMU:mapin
MMU:setio
MMU:exit
setup_arch: enter
setup_arch: bootmem
taiga_setup_arch: setup_bridge
tsi108: resources set
arch: exit
Total memory = 512MB; using 1024kB for hash table (at c0400000)
Linux version 2.6.15-rc5-git1 (roy@bus) (gcc version 3.4.3) #8 Thu Dec 15 13:48:
22 CST 2005
Taiga Platform
Jointly ported by Freescale and Tundra Semiconductor
Enabling L2 cache then enabling the HID0 prefetch engine.
Built 1 zonelists
Kernel command line: root=/dev/nfs nfsroot=10.193.20.105:/tftpboot/10.193.20.118
 ip=10.193.20.118:10.193.20.105:127.0.0.1:255.255.255.0:mpc7447a:eth0:off consol
e=ttyS0,115200
PID hash table entries: 4096 (order: 12, 65536 bytes)
time_init: decrementer frequency = 49.998772 MHz
Console: colour dummy device 80x25
Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
Memory: 514432k available (2728k kernel code, 852k data, 120k init, 0k highmem)
Mount-cache hash table entries: 512
NET: Registered protocol family 16

PCI: Probing PCI hardware
SCSI subsystem initialized
io scheduler noop registered
Generic RTC Driver v1.07
Macintosh non-volatile memory driver v1.1
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at MMIO 0x0 (irq = 12) is a 16550A
serial8250: ttyS1 at MMIO 0x0 (irq = 13) is a 16550A
RAMDISK driver initialized: 16 RAM disks of 163841K size 1024 blocksize
loop: loaded (max 8 devices)
pktcdvd: v0.2.0a 2004-07-14 Jens Axboe (axboe@suse.de) and petero2@telia.com
Intel(R) PRO/1000 Network Driver - version 6.1.16-k2
Copyright (c) 1999-2005 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.4.14-k4-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
e100: eth0: e100_probe: addr 0xe7fff000, irq 36, MAC addr 00:02:B3:4C:39:7D
eth1: Tsi108 Gigabit Ethernet, MAC: 00:06:d2:00:00:01
eth2: Tsi108 Gigabit Ethernet, MAC: 00:06:d2:00:01:3d
tsi108_ether_init: found 2 device(s)
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
sata_mv 0000:00:03.0: version 0.5
sata_mv 0000:00:03.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE10A2120 bmdma 0x0 irq 38
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE10A4120 bmdma 0x0 irq 38
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE10A6120 bmdma 0x0 irq 38
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE10A8120 bmdma 0x0 irq 38
ata1: no device found (phy stat 00000000)
scsi0 : sata_mv
ata2: dev 0 ATA-6, max UDMA/133, 156301488 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
  Vendor: ATA       Model: ST380817AS        Rev: 3.42
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 156301488 512-byte hdwr sectors (80026 MB)
SCSI device sda: drive cache: write back
 sda:<3>ata2: Entering mv_eng_timeout
mmio_base e1080000 ap dfc072f8 qc dfc077d0 scsi_cmnd c0bc08a0 &cmnd c0bc08e4
ata2: status=0x50 { DriveReady SeekComplete }
ata2: error=0x01 { AddrMarkNotFound }
Assertion failed! qc->flags & ATA_QCFLAG_ACTIVE,drivers/scsi/libata-core.c,ata_q
c_complete,line=3513
ata2: status=0x50 { DriveReady SeekComplete }
ata2: error=0x01 { AddrMarkNotFound }
sda: Current: sense key: No Sense
    Additional sense: No additional sense information
 unknown partition table
sd 1:0:0:0: Attached scsi disk sda
sd 1:0:0:0: Attached scsi generic sg0 type 0
mice: PS/2 mouse device common for all mice
i2c /dev entries driver
NET: Registered protocol family 2
IP route cache hash table entries: 32768 (order: 5, 131072 bytes)
TCP established hash table entries: 131072 (order: 9, 2097152 bytes)
TCP bind hash table entries: 65536 (order: 8, 1310720 bytes)
TCP: Hash tables configured (established 131072 bind 65536)
TCP reno registered
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 17
e100: eth0: e100_watchdog: link up, 100Mbps, full-duplex
IP-Config: Gateway not on directly connected network.
Looking up port of RPC 100003/2 on 10.193.20.105
Looking up port of RPC 100005/1 on 10.193.20.105
VFS: Mounted root (nfs filesystem) readonly.
Freeing unused kernel memory: 120k init
Setting the hostname to mpc7448hpcii
Mounting filesystems
Starting syslogd and klogd
Setting up networking on loopback device:
Setting up networking on eth0:
Adding static route for default gateway to 192.168.0.1:
route: SIOC[ADD|DEL]RT: Network is unreachable
Setting nameserver to 192.168.0.1 in /etc/resolv.conf:
Setting time from ntp server: ntp.cs.strath.ac.uk
ntp.cs.strath.ac.uk: Host name lookup failure
Starting inetd:
Starting the port mapper:


        Welcome to Freescale Semiconductor Embedded Linux Environment

!!!!! WARNING !!!!!!!

please set a password for root and then edit this message (/etc/issue)

mpc7448hpcii login:



Best Regards
Dr.  Roy Zang
Office: 86-10-58798039 
