From: Martin Michlmayr <tbm@cyrius.com>
Subject: sata_via (pata): problems when write cache is disabled
Date: Sun, 29 Apr 2007 12:50:01 +0200
Message-ID: <20070429105001.GA4530@deprecation.cyrius.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from sorrow.cyrius.com ([65.19.161.204]:1432 "EHLO sorrow.cyrius.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756371AbXD2LRZ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 29 Apr 2007 07:17:25 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: "Williams, Dan J" <dan.j.williams@intel.com>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I tried to start Linux on an Intel XScale (ARM, IOP13xx) based board
but there are problems with accesses to PATA disks.  I use a VIA
VT6421 PCI SATA/PATA card and some old PATA disks.  During fsck (which
happens because I didn't have RTC compiled into the kernel), I get
various ATA bus errors.  I noticed that I get such errors with two
different PATA disks (one of which is definitely known to be good
because it works in another machine), but the third disk I tried work.
Looking at dmesg, the difference appears to be that on the disks that
don't work the write cache is disabled hereas it's enabled on the disk
that works.

I've included some example errors below and the lspci information
about the controller.  I've also attached the full boot log from all
two disks.

Is this a bug in the VIA driver?

Sample errors:

ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
...
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: limiting speed to UDMA/25:PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
sd 2:0:0:0: SCSI error: return code = 0x08000002
sda: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
        00 04 80 0f 
end_request: I/O error, dev sda, sector 294920
Buffer I/O error on device sda2, logical block 1
lost page write due to I/O error on sda2
...

lspci information:

00:01.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID Controller (rev 50)
        Subsystem: VIA Technologies, Inc. VT6421 IDE RAID Controller
        Flags: bus master, medium devsel, latency 32, IRQ 25
        I/O ports at fffb14a0 [size=16]
        I/O ports at fffb14b0 [size=16]
        I/O ports at fffb14c0 [size=16]
        I/O ports at fffb14d0 [size=16]
        I/O ports at fffb1480 [size=32]
        I/O ports at fffb1000 [size=256]
        Capabilities: [e0] Power Management version 2

-- 
Martin Michlmayr
http://www.cyrius.com/

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=2560-bad
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.21 (tbm@em64t) (gcc version 4.1.2 20061028 (prerelease) (=
Debian 4.1.1-19)) #33 Sat Apr 28 20:58:55 UTC 2007
CPU: XScale-V3 based processor [69056818] revision 8 (ARMv5TE), cr=3D040039=
7f
Machine: Intel IQ81340MC
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 65024
Kernel command line: console=3DttyS1,115200 root=3D/dev/sda1
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 255744KB available (3628K code, 273K data, 128K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
ATUX: Initialized (16M @ resource/virtual: 80000000/51000000)
ATUE: Initialized (0M @ resource/virtual: c0000000/00000000)
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xffd82340 (irq =3D 52) is a XScale
serial8250.1: ttyS1 at MMIO 0xffd82300 (irq =3D 51) is a XScale
RAMDISK driver initialized: 2 RAM disks of 8192K size 1024 blocksize
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:00:02.0: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:72
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:00:02.1: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:73
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Loading iSCSI transport class v2.0-724.
sata_via 0000:00:01.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xfec614a0 ctl 0xfec614aa bmdma 0xfec61480 irq =
25
ata2: SATA max UDMA/133 cmd 0xfec614b0 ctl 0xfec614ba bmdma 0xfec61488 irq =
25
ata3: PATA max UDMA/133 cmd 0xfec614c0 ctl 0xfec614ca bmdma 0xfec61490 irq =
25
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614a7
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614b7
scsi2 : sata_via
ata3.00: ATA-3: WDC AC22500L, 32.41N35, max UDMA/33
ata3.00: 4999680 sectors, multi 0: LBA=20
ata3.00: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      WDC AC22500L     32.4 PQ: 0 ANSI: 5
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 < sda5 sda6 >
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
physmap platform flash device: 02000000 at fa000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
Searching for RedBoot partition table in physmap-flash.0 at offset 0x1fe0000
No RedBoot partition table detected in physmap-flash.0
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    105 MB/s
raid6: int32x2    118 MB/s
raid6: int32x4    113 MB/s
raid6: int32x8     91 MB/s
raid6: using algorithm int32x2 (118 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: measuring checksumming speed
   arm4regs  :   687.200 MB/sec
   8regs     :   576.800 MB/sec
   32regs    :   618.400 MB/sec
raid5: using function: arm4regs (687.200 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redha=
t.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
NET: Registered protocol family 17
NET: Registered protocol family 15
XScale DSP coprocessor detected.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 128K
modprobe: FATAL: Could not load /lib/modules/2.6.21/modules.dep: No such fi=
le or directory
=0D
INIT: version 2.86 booting=0D=0D

Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...Adding 96348k swap on /dev/sda5.  Priority:-1 extents:1 a=
cross:96348k
done.
Checking root file system...fsck 1.40-WIP (14-Nov-2006)
/dev/sda1: Superblock last mount time is in the future.  FIXED.
/dev/sda1: Superblock last write time is in the future.  FIXED.
/dev/sda1 has gone 36081 days without being checked, check forced.
=01/dev/sda1: |=3D=3D=3D=3D=3D                                             =
      |  8.8%   =02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         at=
a3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen=0D
                                     / 17.5%   =02=01/dev/sda1: |=3D=3Data3=
=2E00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out=
=0D
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                    =
     - 26.2%   ata3: soft resetting port
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                                    \ 35.0%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                            | 43.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                        / 52.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D                      - 61.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                 \ 70.0%   =0D=02=01/dev/sda1=
: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                 | 70.1%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
  / 70.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                 - 70.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D                \ 70.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                | 71.2%   =0D=02=01/dev=
/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                / 71.=
4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
             - 71.6%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D                \ 71.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                | 71.9%   =0D=02=01/dev/sd=
a1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                / 72.1% =
  =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
            - 72.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D               \ 72.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               | 72.7%   =0D=02=01/d=
ev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
/ 72.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D               - 72.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D               \ 73.0%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               | 73.1%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
         / 73.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D               - 73.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               \ 73.4%   =0D=02=01/dev/=
sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               | 7=
3.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D               / 73.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D               - 73.8%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               \ 73.9%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
      | 74.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D              / 74.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3Data3.00: configured for UDMA/33=0D
=3D=3D=3D=3D=3D=3D=3D=3D              - 74.4%   =02=01/dev/sda1: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Data3: EH complete=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
              \ 74.5%   =02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D              | 74.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              / 74.9%   =0D=02=01/de=
v/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              -=
 75.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D              \ 75.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D              | 75.4%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              / 75.5%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
        - 75.6%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D              \ 75.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              | 75.9%   =0D=02=01/dev/s=
da1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             / =
76.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D             - 76.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             \ 76.3%   =0D=02=01/dev/sda1:=
 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             | 76.=
4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D             / 76.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             - 76.6%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             \ 76.7% =
  =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D             | 76.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D             / 76.9%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             - 77.0%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
             \ 77.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D             | 77.4%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             / 77.5%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
            - 77.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D            \ 78.0%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            | 78.1%  =
 =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D            / 78.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            - 78.3%   =0D=02=01/dev/sda1: =
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            \ 7=
8.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D            | 78.6%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            / 78.8%   =0D=02=01/dev/=
sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
   - 78.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D            \ 79.0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            | 79.2%   =0D=02=
=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
         / 79.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D            - 79.5%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           \ 79.7%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D           | 79.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           / 79.9%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           - 80=
=2E0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D           \ 80.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           | 80.2%   =0D=02=01/de=
v/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
     / 80.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D           - 80.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           \ 80.5%   =0D=02=
=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
           | 80.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D           / 80.9%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           - 81.0%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D           \ 81.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           | 81.2%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          / =
81.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D          - 81.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          \ 81.5%   =0D=02=
=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D          | 81.6%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          / 81.7%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          - =
81.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D          \ 81.9%   =0D=02ata3.00: exception Emask 0x0 SA=
ct 0x0 SErr 0x0 action 0x2 frozen=0D
ata3.00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: limiting speed to UDMA/25:PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:17:11:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
sd 2:0:0:0: SCSI error: return code =3D 0x08000002
sda: Current [descriptor]: sense key: Aborted Command
    Additional sense: No additional sense information
Descriptor sense data with sense descriptors (in hex):
        72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00=20
        00 00 00 00=20
end_request: I/O error, dev sda, sector 4375
Buffer I/O error on device sda1, logical block 539
lost page write due to I/O error on sda1
ata3: EH complete
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D     sda: Write Protect is off
     | 82.0%  SCSI device sda: write cache: disabled, read cache: enabled, =
doesn't support DPO or FUA
 =02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D          / 82.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Data3.00: exception Emask 0x0 SAct 0x0 SErr=
 0x0 action 0x2 frozen=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D          - 82.3%   =02=01/dev/sda1: |=3D=3Data3.00: cmd ca/00:08:47:=
00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out=0D
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          \ 82.4% =
  ata3: soft resetting port
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D          | 82.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          / 82.7%   =0D=02=01/dev/sda1:=
 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
 - 82.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D          \ 83.0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         | 83.1%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D         / 83.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         - 83.3%   =0D=02=01/d=
ev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D         \ 83.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         | 83.5%   =0D=02=01/dev/sda1: =
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
   / 83.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D         - 83.8%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         \ 83.9=
%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D         | 84.0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         / 84.1%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D         - 84.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         \ 84.4%   =0D=02=01/dev/=
sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
         | 84.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         / 84.6%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
- 84.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D         \ 84.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        | 84.9%=
   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D        / 85.0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        - 85.1%   =0D=02=
=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D        \ 85.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        | 85.3%   =0D=02=01/dev/s=
da1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
        / 85.4%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        - 85.5%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        \=
 85.6%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D        | 85.8%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        / 85.9%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D        - 86.0%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3Data3.00: configured for UDMA/25=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        \ 86.1%   ata3: EH comple=
te
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D        | 86.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        / 86.4%   =0D=02=01/de=
v/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D       - 86.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       \ 86.8%   =0D=02=01/dev/sd=
a1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D       | 86.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       / 87.1%   =0D=02=01/dev/sda1:=
 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
       - 87.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       \ 87.4%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
    | 87.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       / 87.7%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
 - 87.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       \ 88.0%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       | =
88.1%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D       / 88.3%   =0D=02=01/dev/sda1: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      - 8=
8.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      \ 88.7%   =0D=02=01/dev/sda1: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
| 88.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      / 89.0%   =0D=02=01/dev/sda1: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
   - 89.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      \ 89.3%   =0D=02=01/dev/sda1: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
      | 89.5%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      / 89.6%   =0D=02=01/dev/sda1: =
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D      - 89.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      \ 89.8%   =0D=02=01/dev/sda=
1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D      | 89.9%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      / 90.0%   =0D=02=01/dev/=
sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D     - 91.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   \ 95.3%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D| 100.0%   =0D=02=01                   =
                                                            =0D=02/dev/sda1=
: ***** REBOOT LINUX *****=0D
/dev/sda1: 53888/120576 files (0.8% non-contiguous), 223523/240967 blocks
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:47:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:47:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:47:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:47:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:47:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:4e:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
sd 2:0:0:0: SCSI error: return code =3D 0x08000002
sda: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00=20
        00 00 00 4e=20
end_request: I/O error, dev sda, sector 71
Buffer I/O error on device sda1, logical block 1
lost page write due to I/O error on sda1
ata3: EH complete
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:3f:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:46:00:00/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:3f:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:46:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: limiting speed to PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
ata3.00: cmd ca/00:08:3f:00:00/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 40/00:00:46:00:00/00:00:00:00:00/e0 Emask 0x4 (timeout)
ata3: soft resetting port
ata3.00: configured for PIO4
ata3: EH complete
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
SCSI device sda: 4999680 512-byte hdwr sectors (2560 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
fsck died with exit status 3
=1B[31mfailed (code 3).=1B[39;49m
=1B[31m*=1B[39;49m The file system check corrected errors on the root parti=
tion=20
but requested that the system be restarted.
=1B[33m*=1B[39;49m The system will be restarted in 5 seconds.
md: stopping all md devices.
Restarting system.

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=16907-bad
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.21 (tbm@em64t) (gcc version 4.1.2 20061028 (prerelease) (=
Debian 4.1.1-19)) #33 Sat Apr 28 20:58:55 UTC 2007
CPU: XScale-V3 based processor [69056818] revision 8 (ARMv5TE), cr=3D040039=
7f
Machine: Intel IQ81340MC
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 65024
Kernel command line: console=3DttyS1,115200 root=3D/dev/sda2
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 255744KB available (3628K code, 273K data, 128K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
ATUX: Initialized (16M @ resource/virtual: 80000000/51000000)
ATUE: Initialized (0M @ resource/virtual: c0000000/00000000)
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xffd82340 (irq =3D 52) is a XScale
serial8250.1: ttyS1 at MMIO 0xffd82300 (irq =3D 51) is a XScale
RAMDISK driver initialized: 2 RAM disks of 8192K size 1024 blocksize
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:00:02.0: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:72
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:00:02.1: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:73
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Loading iSCSI transport class v2.0-724.
sata_via 0000:00:01.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xfec614a0 ctl 0xfec614aa bmdma 0xfec61480 irq =
25
ata2: SATA max UDMA/133 cmd 0xfec614b0 ctl 0xfec614ba bmdma 0xfec61488 irq =
25
ata3: PATA max UDMA/133 cmd 0xfec614c0 ctl 0xfec614ca bmdma 0xfec61490 irq =
25
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614a7
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614b7
scsi2 : sata_via
ata3.00: ATA-4: IBM-DTTA-351680, T51OA73A, max UDMA/33
ata3.00: 33022080 sectors, multi 0: LBA=20
ata3.00: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      IBM-DTTA-351680  T51O PQ: 0 ANSI: 5
SCSI device sda: 33022080 512-byte hdwr sectors (16907 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
SCSI device sda: 33022080 512-byte hdwr sectors (16907 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 >
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
physmap platform flash device: 02000000 at fa000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
Searching for RedBoot partition table in physmap-flash.0 at offset 0x1fe0000
No RedBoot partition table detected in physmap-flash.0
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    105 MB/s
raid6: int32x2    118 MB/s
raid6: int32x4    113 MB/s
raid6: int32x8     91 MB/s
raid6: using algorithm int32x2 (118 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: measuring checksumming speed
   arm4regs  :   687.200 MB/sec
   8regs     :   576.800 MB/sec
   32regs    :   618.400 MB/sec
raid5: using function: arm4regs (687.200 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redha=
t.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
NET: Registered protocol family 17
NET: Registered protocol family 15
XScale DSP coprocessor detected.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 128K
INIT: version 2.86 booting=0D=0D
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully popAdding 977896k swap on /dev/sda5.  Priority=
:-1 extents:1 across:977896k
ulated...done.
Activating swap...done.
Checking root file system...fsck 1.40-WIP (14-Nov-2006)
/dev/sda2: Superblock last mount time is in the future.  FIXED.
/dev/sda2: Superblock last write time is in the future.  FIXED.
/dev/sda2 has gone 36197 days without being checked, check forced.
=01/dev/sda2: |=3D                                                       | =
 2.6%   =02=01/dev/sda2: |=3D=3D=3D                                        =
             /  5.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D                   =
                                 -  7.8%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D                                                  \ 10.4%   =0D=02=
=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D                                       =
          | 13.0%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D       =
                                        / 15.6%   =0D=02=01/dev/sda2: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D                                              - =
18.1%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          =
                                  \ 20.7%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                           | =
23.3%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
                                        / 25.9%   =0D=02=01/dev/sda2: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                              =
          - 28.5%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D                                       \ 31.1%   =0D=02=
=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                                  | 33.7%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                        =
            / 36.3%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                  - 38.=
9%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D                                 \ 41.5%   =0D=02=01/d=
ev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D                               | 44.1%   =0D=02=01/dev/sda2: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                              / 46.7%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                            - 49.3%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                        \ 51.9%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                       | 54.4%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                        / 57.0%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D                       - 59.6%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D                     \ 62.2%   =0D=02=01/dev/sda2: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D                    | 64.8%   =0D=02=01/dev/sda2=
: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                  / 67.4%   =0D=
=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
  - 70.0%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                 \ 70.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D                | 70.9%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                / 71.2%   =0D=02=01/dev=
/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                - 71.=
6%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3Data3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =
    \ 72.1%   =02=01/dev/sda2: |=3D=3Data3.00: (BMDMA stat 0x4)=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               | 72.6%   ata3.00:=
 cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        a=
ta3: soft resetting port=0D
       / 73.0%   =02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D               - 73.6%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               \ 73.9%   =0D=02=01/dev/sda2: =
|=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              | 74.4%=
   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
              / 74.9%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D              - 75.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D              \ 75.6%   =0D=02=01=
/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            =
  | 75.8%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D             / 76.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             - 76.6%   =0D=02=01/dev/sd=
a2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             \ =
76.9%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D             | 77.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D             / 77.6%   =0D=02=01/dev/sda2:=
 |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            - 7=
8.0%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D            \ 78.4%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            | 78.8%   =0D=02=01/dev/=
sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
   / 79.0%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D            - 79.3%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D            \ 79.4%   =0D=02=
=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
         | 79.5%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D           / 80.2%   =0D=02=01/dev/sda2: |=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D           - 81.0%   =
=0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D          \ 81.7%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          | 82.0%   =0D=02=01/dev/sd=
a2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
    / 82.4%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D          - 82.6%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D          \ 82.9%   =
=0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D         | 83.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         / 83.5%   =0D=02=01/d=
ev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D         - 83.8%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3Data3.00: configured for UDMA/33=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D    ata3: EH complete
     \ 84.1%   =02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D         | 84.4%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D ata3.00: excep=
tion Emask 0x0 SAct 0x0 SErr 0x0 action 0x2=0D
       / 84.9%   =02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Data3.00: (BMDMA st=
at 0x4)=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        - 85.5% ata3.00: cm=
d ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
  =02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Data3: soft=
 resetting port=0D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D        \ 85.8%   =02=01/dev/sda2: |=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D        | 86.0%   =0D=
=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D        / 86.5%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       - 86.8%   =0D=02=01/=
dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D       \ 87.1%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       | 87.4%   =0D=02=01/dev=
/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D       / 87.5%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D       - 87.8%   =0D=02=01/dev/sd=
a2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D       \ 88.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      | 88.8%   =0D=02=01/dev/sda=
2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D      / 89.3%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      - 89.4%   =0D=02=01/dev/=
sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D      \ 89.7%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      | 89.9%   =0D=02=01/d=
ev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D     / 91.8%   =0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   - 95.1%   =
=0D=02=01/dev/sda2: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  \ 97.2%   =0D=02=01/dev/sda2: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D| 100.0%   =0D=02=01                                              =
                                 =0D=02/dev/sda2: ***** REBOOT LINUX *****=
=0D
/dev/sda2: 25223/427680 files (0.1% non-contiguous), 117968/854784 blocks
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/33
ata3: EH complete
ata3.00: limiting speed to UDMA/25:PIO4
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:08:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 53/84:00:0f:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
sd 2:0:0:0: SCSI error: return code =3D 0x08000002
sda: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00=20
        00 04 80 0f=20
end_request: I/O error, dev sda, sector 294920
Buffer I/O error on device sda2, logical block 1
lost page write due to I/O error on sda2
ata3: EH complete
SCSI device sda: 33022080 512-byte hdwr sectors (16907 MB)
sda: Write Protect is off
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
ata3: EH complete
ata3.00: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2
ata3.00: (BMDMA stat 0x4)
ata3.00: cmd ca/00:08:00:80:04/00:00:00:00:00/e0 tag 0 cdb 0x0 data 4096 out
         res 51/84:00:07:80:04/00:00:00:00:00/e0 Emask 0x10 (ATA bus error)
ata3: soft resetting port
ata3.00: configured for UDMA/25
sd 2:0:0:0: SCSI error: return code =3D 0x08000002
sda: Current [descriptor]: sense key: Aborted Command
    Additional sense: Scsi parity error
Descriptor sense data with sense descriptors (in hex):
        72 0b 47 00 00 00 00 0c 00 0a 80 00 00 00 00 00=20
        00 04 80 07=20
end_request: I/O error, dev sda, sector 294912
Buffer I/O error on device sda2, logical block 0
lost page write due to I/O error on sda2
ata3: EH complete
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
SCSI device sda: 33022080 512-byte hdwr sectors (16907 MB)
sda: Write Protect is off
SCSI device sda: write cache: disabled, read cache: enabled, doesn't suppor=
t DPO or FUA
fsck died with exit status 3
=1B[31mfailed (code 3).=1B[39;49m
=1B[31m*=1B[39;49m The file system check corrected errors on the root parti=
tion=20
but requested that the system be restarted.
=1B[33m*=1B[39;49m The system will be restarted in 5 seconds.
md: stopping all md devices.
Restarting system.

--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=8700-good
Content-Transfer-Encoding: quoted-printable

Linux version 2.6.21 (tbm@em64t) (gcc version 4.1.2 20061028 (prerelease) (=
Debian 4.1.1-19)) #33 Sat Apr 28 20:58:55 UTC 2007
CPU: XScale-V3 based processor [69056818] revision 8 (ARMv5TE), cr=3D040039=
7f
Machine: Intel IQ81340MC
Memory policy: ECC disabled, Data cache writeback
CPU0: D VIVT undefined 5 cache
CPU0: I cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
CPU0: D cache: 32768 bytes, associativity 4, 32 byte lines, 256 sets
Built 1 zonelists.  Total pages: 65024
Kernel command line: console=3DttyS1,115200 root=3D/dev/sda2
PID hash table entries: 1024 (order: 10, 4096 bytes)
Console: colour dummy device 80x30
Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
Memory: 256MB =3D 256MB total
Memory: 255744KB available (3628K code, 273K data, 128K init)
Mount-cache hash table entries: 512
CPU: Testing write buffer coherency: ok
NET: Registered protocol family 16
PCI: bus0: Fast back to back transfers disabled
PCI: bus1: Fast back to back transfers enabled
ATUX: Initialized (16M @ resource/virtual: 80000000/51000000)
ATUE: Initialized (0M @ resource/virtual: c0000000/00000000)
SCSI subsystem initialized
NET: Registered protocol family 2
IP route cache hash table entries: 2048 (order: 1, 8192 bytes)
TCP established hash table entries: 8192 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 8192 bind 8192)
TCP reno registered
NetWinder Floating Point Emulator V0.97 (double precision)
Installing knfsd (copyright (C) 1996 okir@monad.swb.de).
JFFS2 version 2.2. (NAND) (C) 2001-2006 Red Hat, Inc.
io scheduler noop registered
io scheduler deadline registered (default)
Serial: 8250/16550 driver $Revision: 1.90 $ 2 ports, IRQ sharing disabled
serial8250.0: ttyS0 at MMIO 0xffd82340 (irq =3D 52) is a XScale
serial8250.1: ttyS1 at MMIO 0xffd82300 (irq =3D 51) is a XScale
RAMDISK driver initialized: 2 RAM disks of 8192K size 1024 blocksize
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.3.20-k2-NAPI
Copyright (c) 1999-2006 Intel Corporation.
e1000: 0000:00:02.0: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:72
e1000: eth0: e1000_probe: Intel(R) PRO/1000 Network Connection
e1000: 0000:00:02.1: e1000_probe: (PCI:33MHz:64-bit) 00:0e:0c:b9:ab:73
e1000: eth1: e1000_probe: Intel(R) PRO/1000 Network Connection
Loading iSCSI transport class v2.0-724.
sata_via 0000:00:01.0: routed to hard irq line 9
ata1: SATA max UDMA/133 cmd 0xfec614a0 ctl 0xfec614aa bmdma 0xfec61480 irq =
25
ata2: SATA max UDMA/133 cmd 0xfec614b0 ctl 0xfec614ba bmdma 0xfec61488 irq =
25
ata3: PATA max UDMA/133 cmd 0xfec614c0 ctl 0xfec614ca bmdma 0xfec61490 irq =
25
scsi0 : sata_via
ata1: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614a7
scsi1 : sata_via
ata2: SATA link down (SStatus 0 SControl 310)
ATA: abnormal status 0x7F on port 0xfec614b7
scsi2 : sata_via
ata3.00: ATA-5: Maxtor 90871U2, FA570480, max UDMA/66
ata3.00: 16992864 sectors, multi 0: LBA=20
ata3.00: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      Maxtor 90871U2   FA57 PQ: 0 ANSI: 5
SCSI device sda: 16992864 512-byte hdwr sectors (8700 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
SCSI device sda: 16992864 512-byte hdwr sectors (8700 MB)
sda: Write Protect is off
SCSI device sda: write cache: enabled, read cache: enabled, doesn't support=
 DPO or FUA
 sda: sda1 sda2 sda3 < sda5 sda6 >
sd 2:0:0:0: Attached scsi disk sda
sd 2:0:0:0: Attached scsi generic sg0 type 0
physmap platform flash device: 02000000 at fa000000
physmap-flash.0: Found 1 x16 devices at 0x0 in 16-bit bank
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
 Intel/Sharp Extended Query Table at 0x010A
Using buffer write method
cfi_cmdset_0001: Erase suspend on write enabled
cmdlinepart partition parsing not available
Searching for RedBoot partition table in physmap-flash.0 at offset 0x1fe0000
No RedBoot partition table detected in physmap-flash.0
mice: PS/2 mouse device common for all mice
md: raid0 personality registered for level 0
md: raid1 personality registered for level 1
md: raid10 personality registered for level 10
raid6: int32x1    105 MB/s
raid6: int32x2    118 MB/s
raid6: int32x4    113 MB/s
raid6: int32x8     91 MB/s
raid6: using algorithm int32x2 (118 MB/s)
md: raid6 personality registered for level 6
md: raid5 personality registered for level 5
md: raid4 personality registered for level 4
raid5: measuring checksumming speed
   arm4regs  :  1254.000 MB/sec
   8regs     :   576.800 MB/sec
   32regs    :   618.400 MB/sec
raid5: using function: arm4regs (1254.000 MB/sec)
device-mapper: ioctl: 4.11.0-ioctl (2006-10-12) initialised: dm-devel@redha=
t.com
TCP cubic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
NET: Registered protocol family 17
NET: Registered protocol family 15
XScale DSP coprocessor detected.
md: Autodetecting RAID arrays.
md: autorun ...
md: ... autorun DONE.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing init memory: 128K
modprobe: FATAL: Could not load INIT: version 2.86 booting=0D=0D
Starting the hotplug events dispatcher: udevd.
Synthesizing the initial hotplug events...done.
Waiting for /dev to be fully populated...done.
Activating swap...Adding 257000k swap on /dev/sda5.  Priority:-1 extents:1 =
across:257000k
done.
Checking root file system...fsck 1.40-WIP (14-Nov-2006)
/dev/sda2: clean, 25824/304608 fEXT3 FS on sda2, iles, 144253/608461 blocks
done.
internal journal
Setting the system clock again..
Cannot access the Hardware Clock via any known method.
Use the --debug option to see the details of our search for an access metho=
d.
Cleaning up ifupdown....
Loading modules...done.
FATAL: Could not load /lib/modules/2.6.21/modules.dep: No such file or dire=
ctory
Loading device-mapper support.
Checking file systems...fsck 1.40-WIP (14-Nov-2006)
/dev/sda1: Superblock last mount time is in the future.  FIXED.
/dev/sda1: Superblock last write time is in the future.  FIXED.
/dev/sda1 has gone 49710 days without being checked, check forced.
=01/dev/sda1: |=3D=3D=3D                                                   =
  |  5.8%   =02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D                        =
                         / 11.7%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D                                           - 23.3%   =
=0D=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                           \ 52.5%   =0D=
=02=01/dev/sda1: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D   | 95.2%   =0D=02=01/dev/sda1: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D| 100.0%   =0D=02=01                                                 =
                              =0D=02/dev/sda1: 19/24096 files (10.5% non-co=
ntiguous), 14775/96356 blocks=0D
/dev/sda6: Superblock last mount time is in the future.  FIXED.
/dev/sda6: Superblock last write time is in the future.  FIXED.
/dev/sda6 has gone 49710 days without being checked, check forced.
=01/dev/sda6: |=3D                                                       | =
 1.6%   =02=01/dev/sda6: |=3D=3D                                           =
           /  3.2%   =0D=02=01/dev/sda6: |=3D=3D=3D                        =
                             -  4.8%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D   =
                                                 \  6.4%   =0D=02=01/dev/sd=
a6: |=3D=3D=3D=3D                                                    |  8.0=
%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D                                   =
                /  9.5%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D          =
                                        - 11.1%   =0D=02=01/dev/sda6: |=3D=
=3D=3D=3D=3D=3D=3D                                                 \ 12.7% =
  =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D                         =
                      | 15.9%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D                                              / 17.5%   =0D=02=01/=
dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                               =
              - 19.1%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D                                            \ 20.7%   =0D=02=01/dev/s=
da6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                 =
           | 22.3%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D                                           / 23.9%   =0D=02=01/dev/sd=
a6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                            =
              - 25.5%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D                                         \ 27.0%   =0D=02=01=
/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
                         | 28.6%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                       / 3=
0.2%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D                                      - 31.8%   =0D=02=01/dev/sda6=
: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
                      \ 33.4%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                    =
| 35.0%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D                                    / 36.6%   =0D=02=01/d=
ev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  =
                                 - 38.2%   =0D=02=01/dev/sda6: |=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                  =
                \ 39.8%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                 =
| 41.4%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                                / 43.0%   =0D=
=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D                               - 44.5%   =0D=02=01/dev/sd=
a6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D                              \ 46.1%   =0D=02=01/dev/sda6: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D                             | 47.7%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D   =
                         / 49.3%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
                     - 50.9%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
                  \ 52.5%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
                 | 54.1%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
             =0D
   / 55.7%   =02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                     =
   - 57.3%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D               =
        \ 58.9%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D         =
             | 60.5%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
                     / 62.0%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D                    - 63.6%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D                   \ 65.2%   =0D=02=01/dev/sda6: |=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                   | 66.8%   =0D=02=01/=
dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D                  / 68.4=
%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D      =
           - 70.0%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D    \ 93.3%   =0D=02=01/dev=
/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D   | 95.1%   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D  / 95.6%=
   =0D=02=01/dev/sda6: |=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D - 97.5%   =0D=02=01/dev/sda6: |=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D| 100.0%   =0D=02=01                                        =
                                       =0D=02/dev/sda6: 16/713856 files (6.=
3% non-contiguous), 58009/1425760 blocks=0D
fsck died with exit status 1
done.
Setting kernel variables...done.
Mounting local filesystems...kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda1, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
kjournald starting.  Commit interval 5 seconds
EXT3 FS on sda6, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
done.
Activating swapfile swap...done.
Setting up networking....
Configuring network interfaces...done.
Starting portmap daemon....
INIT: Entering runlevel: 2=0D=0D
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting portmap daemon...Already running..
Starting MTA: exim4.
Starting printer spooler: lpd.
Starting internet superserver: inetd.
Starting OpenBSD Secure Shell server: sshd.
Starting NFS common utilities: statd.
Starting deferred execution scheduler: atd.
Starting periodic command scheduler: crond.

Debian GNU/Linux 4.0 unassigned-hostname ttyS1

unassigned-hostname login:=20

--+HP7ph2BbKc20aGI--
