From: Clemens Koller <clemens.koller@anagramm.de>
Subject: linux-2.6.18 reiserfs on raid1 blocks io until rebooted - why?
Date: Mon, 01 Oct 2007 15:46:07 +0200
Message-ID: <4700FA1F.9010408@anagramm.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.126.188]:53211 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752116AbXJANqT (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 09:46:19 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: LKML List <linux-kernel@vger.kernel.org>
Cc: linux-ide@vger.kernel.org

Hi, there!

Can someone please put some light on what happened here:

Short story:
linux kernel 2.6.18 block i/o on file access on reiserfs on raid1.

Long story:
Sorry, for the long mail... I just try to give all details.
On one of our old simple samba file servers, I ran into a
strange problem that programs like slocate, rsync, cp
start to block somewhere in the kernel io when they access files on
reiserfs on /dev/md0.

History:
1. Machine was up for about 200+ days without any problems.

2. On Sept. 05th we had a power outage because a electrician got stuck
somewhere in the cables. :-(

3. Machine rebooted, checked everything, nothing seems to be broken
(not even the electrician).
Kernel log said:
[...]
Sep  5 14:51:54 rio kernel: PDC20269: chipset revision 2
Sep  5 14:51:54 rio kernel: PDC20269: ROM enabled at 0x20000000
Sep  5 14:51:54 rio kernel: PDC20269: 100%% native mode on irq 11
Sep  5 14:51:54 rio kernel:     ide2: BM-DMA at 0x9800-0x9807, BIOS set=
tings: hde:pio, hdf:pio
Sep  5 14:51:55 rio kernel:     ide3: BM-DMA at 0x9808-0x980f, BIOS set=
tings: hdg:pio, hdh:pio
Sep  5 14:51:55 rio kernel: hde: Maxtor 7L300R0, ATA DISK drive
Sep  5 14:51:55 rio kernel: ide2 at 0xb000-0xb007,0xa802 on irq 11
Sep  5 14:51:56 rio kernel: hdg: Maxtor 7L300R0, ATA DISK drive
Sep  5 14:51:56 rio kernel: ide3 at 0xa400-0xa407,0xa002 on irq 11
Sep  5 14:51:56 rio kernel: hda: max request size: 128KiB
Sep  5 14:51:56 rio kernel: hda: 4124736 sectors (2111 MB) w/128KiB Cac=
he, CHS=3D4092/16/63, UDMA(33)
Sep  5 14:51:56 rio kernel: hda: cache flushes not supported
Sep  5 14:51:56 rio kernel:  hda: hda1 hda2
Sep  5 14:51:56 rio kernel: hdb: max request size: 128KiB
Sep  5 14:51:56 rio kernel: hdb: 8446032 sectors (4324 MB) w/496KiB Cac=
he, CHS=3D14896/9/63, UDMA(33)
Sep  5 14:51:56 rio kernel:  hdb: hdb1 hdb2
Sep  5 14:51:56 rio kernel: hde: max request size: 512KiB
Sep  5 14:51:56 rio kernel: hde: 586114704 sectors (300090 MB) w/16384K=
iB Cache, CHS=3D36483/255/63, UDMA(133)
Sep  5 14:51:56 rio kernel: hde: cache flushes supported
Sep  5 14:51:56 rio kernel:  hde: hde1
Sep  5 14:51:56 rio kernel: hdg: max request size: 512KiB
Sep  5 14:51:56 rio kernel: hdg: 586114704 sectors (300090 MB) w/16384K=
iB Cache, CHS=3D36483/255/63, UDMA(133)
Sep  5 14:51:56 rio kernel: hdg: cache flushes supported
Sep  5 14:51:57 rio kernel:  hdg: hdg1
[...]
Sep  5 14:51:59 rio kernel: md: linear personality registered for level=
 -1
Sep  5 14:51:59 rio kernel: md: raid0 personality registered for level =
0
Sep  5 14:51:59 rio kernel: md: raid1 personality registered for level =
1
Sep  5 14:51:59 rio kernel: md: md driver 0.90.3 MAX_MD_DEVS=3D256, MD_=
SB_DISKS=3D27
Sep  5 14:51:59 rio kernel: md: bitmap version 4.39
Sep  5 14:51:59 rio kernel: TCP bic registered
Sep  5 14:51:59 rio kernel: Initializing IPsec netlink socket
Sep  5 14:51:59 rio kernel: NET: Registered protocol family 1
Sep  5 14:51:59 rio kernel: NET: Registered protocol family 10
Sep  5 14:51:59 rio kernel: IPv6 over IPv4 tunneling driver
Sep  5 14:51:59 rio kernel: NET: Registered protocol family 17
Sep  5 14:51:59 rio kernel: Using IPI Shortcut mode
Sep  5 14:51:59 rio kernel: Time: tsc clocksource has been installed.
Sep  5 14:52:00 rio kernel: md: Autodetecting RAID arrays.
Sep  5 14:52:00 rio kernel: md: autorun ...
Sep  5 14:52:00 rio kernel: md: considering hdg1 ...
Sep  5 14:52:00 rio kernel: md:  adding hdg1 ...
Sep  5 14:52:00 rio kernel: md:  adding hde1 ...
Sep  5 14:52:00 rio kernel: md: created md0
Sep  5 14:52:00 rio kernel: md: bind<hde1>
Sep  5 14:52:00 rio kernel: md: bind<hdg1>
Sep  5 14:52:00 rio kernel: md: running: <hdg1><hde1>
Sep  5 14:52:00 rio kernel: raid1: raid set md0 active with 2 out of 2 =
mirrors
Sep  5 14:52:00 rio kernel: md: ... autorun DONE.
Sep  5 14:52:00 rio kernel: ReiserFS: hda1: found reiserfs format "3.6"=
 with standard journal
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: using ordered data mode
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: journal params: device hda1=
, size 8192, journal first block 18, max trans len 1024, max batch 900,=
 max commit age 30, max trans age 30
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: checking transaction log (h=
da1)
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: replayed 9 transactions in =
2 seconds
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Using r5 hash to sort names
Sep  5 14:52:01 rio kernel: VFS: Mounted root (reiserfs filesystem) rea=
donly.
Sep  5 14:52:01 rio kernel: Freeing unused kernel memory: 168k freed
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Removing [585 34512 0x0 SD]=
=2E.done
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Removing [41180 15603 0x0 S=
D]..done
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Removing [199 10243 0x0 SD]=
=2E.done
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Removing [4 10175 0x0 SD]..=
done
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: Removing [585 10164 0x0 SD]=
=2E.done
Sep  5 14:52:01 rio kernel: ReiserFS: hda1: There were 5 uncompleted un=
links/truncates. Completed
Sep  5 14:52:01 rio kernel: ReiserFS: md0: found reiserfs format "3.6" =
with standard journal
Sep  5 14:52:01 rio kernel: ReiserFS: md0: using ordered data mode
Sep  5 14:52:01 rio kernel: ReiserFS: md0: journal params: device md0, =
size 8192, journal first block 18, max trans len 1024, max batch 900, m=
ax commit age 30, max trans age 30
Sep  5 14:52:01 rio kernel: ReiserFS: md0: checking transaction log (md=
0)
Sep  5 14:52:01 rio kernel: ReiserFS: md0: replayed 1 transactions in 0=
 seconds
Sep  5 14:52:01 rio kernel: ReiserFS: md0: Using r5 hash to sort names
Sep  5 14:52:01 rio kernel: Adding 206632k swap on /dev/hda2.  Priority=
:-1 extents:1 across:206632k
Sep  5 14:52:02 rio kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x=
45E1

Comments:
- hda1 is the system /, md0 is the raid1 mounted to /share.
- Harddisks are physically ok, checked with smartctl.

4. starting around Sept. 14th, nightly called slocate started to freeze=
 in
state D. Frozen processes start to cumulate. Nobody realized problems.
Samba access to the machine was possible without problems.

5. Sept. 28th, I got called because the backup process
(rsync from parts of /dev/md0 to external usb hdd) failed...
rsync was also blocked in state D, along with all the dead 14 slocate
processes. Unable to kill these processes.

6. manual rsync to some /tmp/test blocked while it was indexing the
files on /dev/md0 at some unknown location.

7. strace rsync -verbose -... from /dev/md0 to /tmp/test2 hangs also af=
ter:

mkdir("/tmp/test2/simulation", 0700)     =3D 0
lstat64("/tmp/test2/simulation", {st_mode=3DS_IFDIR|0700, st_size=3D40,=
 ...}) =3D 0
open("simulation", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 3
fstat64(3, {st_mode=3DS_IFDIR|0755, st_size=3D384, ...}) =3D 0
mmap2(NULL, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1=
 0) =3D 0xbe7e8e000
getdents64(3,

The cursor just blinks after the (3, _
No reaction to user input.

8. A similar cp froze in the same folder, too.
I got no entries in the kernel log!

9. mounted /dev/md0 readonly (device was busy, of course)

10. reiserfsck /dev/md0 didn't tell any errors

11. shutdown -r now machine to 2.6.18. Log says:
Sep 28 20:42:52 rio kernel: md: Autodetecting RAID arrays.
Sep 28 20:42:52 rio kernel: Time: tsc clocksource has been installed.
Sep 28 20:42:53 rio kernel: md: autorun ...
Sep 28 20:42:53 rio kernel: md: considering hdg1 ...
Sep 28 20:42:53 rio kernel: md:  adding hdg1 ...
Sep 28 20:42:53 rio kernel: md:  adding hde1 ...
Sep 28 20:42:53 rio kernel: md: created md0
Sep 28 20:42:53 rio kernel: md: bind<hde1>
Sep 28 20:42:53 rio kernel: md: bind<hdg1>
Sep 28 20:42:53 rio kernel: md: running: <hdg1><hde1>
Sep 28 20:42:53 rio kernel: raid1: raid set md0 active with 2 out of 2 =
mirrors
Sep 28 20:42:53 rio kernel: md: ... autorun DONE.
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: found reiserfs format "3.6"=
 with standard journal
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: using ordered data mode
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: journal params: device hda1=
, size 8192, journal first block 18, max trans len 1024, max batch 900,=
 max commit age 30, max trans age 30
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: checking transaction log (h=
da1)
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: replayed 25 transactions in=
 4 seconds
Sep 28 20:42:54 rio kernel: ReiserFS: hda1: Using r5 hash to sort names
Sep 28 20:42:54 rio kernel: VFS: Mounted root (reiserfs filesystem) rea=
donly.
Sep 28 20:42:54 rio kernel: Freeing unused kernel memory: 168k freed
Sep 28 20:42:55 rio kernel: Adding 206632k swap on /dev/hda2.  Priority=
:-1 extents:1 across:206632k
Sep 28 20:42:55 rio kernel: eth0: link up, 100Mbps, full-duplex, lpa 0x=
45E1
Sep 28 20:42:55 rio kernel: hdc: drive_cmd: status=3D0x58 { DriveReady =
SeekComplete DataRequest }
Sep 28 20:42:55 rio kernel: ide: failed opcode was: 0xa1
Sep 28 20:44:42 rio kernel: ReiserFS: md0: found reiserfs format "3.6" =
with standard journal
Sep 28 20:44:52 rio kernel: ReiserFS: md0: using ordered data mode
Sep 28 20:44:52 rio kernel: ReiserFS: md0: journal params: device md0, =
size 8192, journal first block 18, max trans len 1024, max batch 900, m=
ax commit age 30, max trans age 30
Sep 28 20:44:52 rio kernel: ReiserFS: md0: checking transaction log (md=
0)
Sep 28 20:44:52 rio kernel: ReiserFS: md0: Using r5 hash to sort names

/dev/hda1 had some replayed transactions again!

12. everything works fine again - no chance to reproduce that case.
reiserfsck'ed again without problems.

13. rsync backup from /dev/md0 to external usb hdd went fine.


Some Questions:
- Is that a known bug?
- How can I debug that problem if unknown.
(I can take that machine down for some hours if needed)
- I can change the kernel to i.e. the latest 2.6.22 if there is
no way to debug that thingy and see if it works better.

Some more details:
$ uname -a
Linux rio 2.6.18 #3 Mon Oct 9 18:17:38 CEST 2006 i686 pentium3 i386 GNU=
/Linux

$ lspci
00:00.0 Host bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX Host=
 bridge (rev 03)
00:01.0 PCI bridge: Intel Corporation 440BX/ZX/DX - 82443BX/ZX/DX AGP b=
ridge (rev 03)
00:04.0 ISA bridge: Intel Corporation 82371AB/EB/MB PIIX4 ISA (rev 02)
00:04.1 IDE interface: Intel Corporation 82371AB/EB/MB PIIX4 IDE (rev 0=
1)
00:04.2 USB Controller: Intel Corporation 82371AB/EB/MB PIIX4 USB (rev =
01)
00:04.3 Bridge: Intel Corporation 82371AB/EB/MB PIIX4 ACPI (rev 02)
00:0a.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8139/8=
139C/8139C+ (rev 10)
00:0b.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 50)
00:0b.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 C=
ontroller (rev 50)
00:0b.2 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 51)
00:0c.0 Mass storage controller: Promise Technology, Inc. 20269 (rev 02=
)
01:00.0 VGA compatible controller: Matrox Graphics, Inc. MGA G100 [Prod=
uctiva] AGP (rev 01)

$ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 7
model name      : Pentium III (Katmai)
stepping        : 2
cpu MHz         : 451.024
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca c=
mov pat pse36 mmx fxsr sse
bogomips        : 902.79

$ mdadm --detail /dev/md0
/dev/md0:
         Version : 00.90.03
   Creation Time : Sat Oct 29 20:51:41 2005
      Raid Level : raid1
      Array Size : 293049600 (279.47 GiB 300.08 GB)
   Used Dev Size : 293049600 (279.47 GiB 300.08 GB)
    Raid Devices : 2
   Total Devices : 2
Preferred Minor : 0
     Persistence : Superblock is persistent

     Update Time : Mon Oct  1 14:59:30 2007
           State : clean
  Active Devices : 2
Working Devices : 2
  Failed Devices : 0
   Spare Devices : 0

            UUID : b2d7f60d:008fa0df:136207f1:ae0e7a9e
          Events : 0.432306

     Number   Major   Minor   RaidDevice State
        0      33        1        0      active sync   /dev/hde1
        1      34        1        1      active sync   /dev/hdg1

Thank you in advance,
--=20
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Stra=DFe 45/1
Linhof Werksgel=E4nde
D-81379 M=FCnchen
Tel.089-741518-50
=46ax 089-741518-19
http://www.anagramm-technology.com
