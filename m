From: Phil Dibowitz <phil@ipom.com>
Subject: IDE kernel traces in 2.6.9 - Bad IRQ ?
Date: Sat, 30 Oct 2004 16:21:13 -0700
Message-ID: <418421E9.6000809@ipom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary=------------enig129F4B557820DBD4FBA880A8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from msg-mx2.usc.edu ([128.125.137.7]:22469 "EHLO msg-mx2.usc.edu")
	by vger.kernel.org with ESMTP id S261420AbUJ3XVQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Oct 2004 19:21:16 -0400
Received: from [10.1.1.2] ([128.125.81.146])
 by msg-mx2.usc.edu (Sun Java System Messaging Server 6.1 HotFix 0.02 (built
 Aug 25 2004)) with ESMTPSA id <0I6F003KW7JESBE0@msg-mx2.usc.edu> for
 linux-ide@vger.kernel.org; Sat, 30 Oct 2004 16:21:15 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig129F4B557820DBD4FBA880A8
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I just upgraded my computer, compiled a new kernel appropriately, and 
I'm getting a ton of kernel issues surrounding the IDE driver. I tried a 
generic debian kernel as well, but same issue. Here are the tracebacks I 
get during boot:

Oct 30 15:56:19 rider kernel: ide0 at 0xefe0-0xefe7,0xefae on irq 5
Oct 30 15:56:19 rider kernel: hda: max request size: 128KiB
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [mwait_idle+48/70] mwait_idle+0x30/0x46
Oct 30 15:56:19 rider kernel:  [cpu_idle+55/80] cpu_idle+0x37/0x50
Oct 30 15:56:19 rider kernel:  [start_kernel+343/368] 
start_kernel+0x157/0x170
Oct 30 15:56:19 rider kernel:  [unknown_bootoption+0/348] 
unknown_bootoption+0x0/0x15c
Oct 30 15:56:19 rider kernel: hda: 30015216 sectors (15367 MB) w/2048KiB 
Cache, CHS=29777/16/63, UDMA(100)
Oct 30 15:56:19 rider kernel:  hda: hda1 hda2 hda3 hda4 < hda5 hda6 >
Oct 30 15:56:19 rider kernel: hdb: max request size: 128KiB
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [mwait_idle+48/70] mwait_idle+0x30/0x46
Oct 30 15:56:19 rider kernel:  [cpu_idle+55/80] cpu_idle+0x37/0x50
Oct 30 15:56:19 rider kernel:  [start_kernel+343/368] 
start_kernel+0x157/0x170
Oct 30 15:56:19 rider kernel:  [unknown_bootoption+0/348] 
unknown_bootoption+0x0/0x15c
Oct 30 15:56:19 rider kernel: hdb: 240121728 sectors (122942 MB) 
w/7936KiB Cache, CHS=65535/16/63, UDMA(100)
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [ide_do_drive_cmd+213/312] 
ide_do_drive_cmd+0xd5/0x138
Oct 30 15:56:19 rider kernel:  [ide_diag_taskfile+161/228] 
ide_diag_taskfile+0xa1/0xe4
Oct 30 15:56:19 rider kernel:  [ide_raw_taskfile+39/43] 
ide_raw_taskfile+0x27/0x2b
Oct 30 15:56:19 rider kernel:  [write_cache+113/146] write_cache+0x71/0x92
Oct 30 15:56:19 rider kernel:  [task_no_data_intr+0/149] 
task_no_data_intr+0x0/0x95
Oct 30 15:56:19 rider kernel:  [idedisk_setup+907/1270] 
idedisk_setup+0x38b/0x4f6
Oct 30 15:56:19 rider kernel:  [idedisk_attach+152/342] 
idedisk_attach+0x98/0x156
Oct 30 15:56:19 rider kernel:  [ata_attach+219/418] ata_attach+0xdb/0x1a2
Oct 30 15:56:19 rider kernel:  [ide_register_driver+261/280] 
ide_register_driver+0x105/0x118
Oct 30 15:56:19 rider kernel:  [idedisk_init+15/22] idedisk_init+0xf/0x16
Oct 30 15:56:19 rider kernel:  [do_initcalls+39/179] do_initcalls+0x27/0xb3
Oct 30 15:56:19 rider kernel:  [sock_init+63/72] sock_init+0x3f/0x48
Oct 30 15:56:19 rider kernel:  [init+0/341] init+0x0/0x155
Oct 30 15:56:19 rider kernel:  [init+61/341] init+0x3d/0x155
Oct 30 15:56:19 rider kernel:  [kernel_thread_helper+0/11] 
kernel_thread_helper+0x0/0xb
Oct 30 15:56:19 rider kernel:  [kernel_thread_helper+5/11] 
kernel_thread_helper+0x5/0xb
Oct 30 15:56:19 rider kernel:  hdb: hdb1
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [mwait_idle+48/70] mwait_idle+0x30/0x46
Oct 30 15:56:19 rider kernel:  [cpu_idle+55/80] cpu_idle+0x37/0x50
Oct 30 15:56:19 rider kernel:  [start_kernel+343/368] 
start_kernel+0x157/0x170
Oct 30 15:56:19 rider kernel:  [unknown_bootoption+0/348] 
unknown_bootoption+0x0/0x15c

....(other non-related boot messages, then)....

Oct 30 15:56:19 rider kernel: Freeing unused kernel memory: 116k freed
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [mwait_idle+48/70] mwait_idle+0x30/0x46
Oct 30 15:56:19 rider kernel:  [cpu_idle+55/80] cpu_idle+0x37/0x50
Oct 30 15:56:19 rider kernel:  [start_kernel+343/368] 
start_kernel+0x157/0x170
Oct 30 15:56:19 rider kernel:  [unknown_bootoption+0/348] 
unknown_bootoption+0x0/0x15
c
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [enable_irq+64/197] enable_irq+0x40/0xc5
Oct 30 15:56:19 rider kernel:  [SELECT_DRIVE+47/69] SELECT_DRIVE+0x2f/0x45
Oct 30 15:56:19 rider kernel:  [ide_config_drive_speed+331/857] 
ide_config_drive_spee
d+0x14b/0x359
Oct 30 15:56:19 rider kernel:  [piix_tune_chipset+559/961] 
piix_tune_chipset+0x22f/0x
3c1
Oct 30 15:56:19 rider kernel:  [piix_config_drive_for_dma+120/159] 
piix_config_drive_
for_dma+0x78/0x9f
Oct 30 15:56:19 rider kernel:  [piix_config_drive_xfer_rate+157/172] 
piix_config_driv
e_xfer_rate+0x9d/0xac
Oct 30 15:56:19 rider kernel:  [set_using_dma+54/113] 
set_using_dma+0x36/0x71
Oct 30 15:56:19 rider kernel:  [ide_write_setting+110/241] 
ide_write_setting+0x6e/0xf
1
Oct 30 15:56:19 rider kernel:  [generic_ide_ioctl+194/1734] 
generic_ide_ioctl+0xc2/0x
6c6
Oct 30 15:56:19 rider kernel:  [do_page_fault+923/1437] 
do_page_fault+0x39b/0x59d
Oct 30 15:56:19 rider kernel:  [dentry_open+265/546] dentry_open+0x109/0x222
Oct 30 15:56:19 rider kernel:  [filp_open+98/100] filp_open+0x62/0x64
Oct 30 15:56:19 rider kernel:  [idedisk_ioctl+0/27] idedisk_ioctl+0x0/0x1b
Oct 30 15:56:19 rider kernel:  [blkdev_ioctl+134/1051] 
blkdev_ioctl+0x86/0x41b
Oct 30 15:56:19 rider kernel:  [block_ioctl+0/21] block_ioctl+0x0/0x15
Oct 30 15:56:19 rider kernel:  [sys_ioctl+247/588] sys_ioctl+0xf7/0x24c
Oct 30 15:56:19 rider kernel:  [syscall_call+7/11] syscall_call+0x7/0xb
Oct 30 15:56:19 rider kernel:  [__report_bad_irq+42/139] 
__report_bad_irq+0x2a/0x8b
Oct 30 15:56:19 rider kernel:  [note_interrupt+111/159] 
note_interrupt+0x6f/0x9f
Oct 30 15:56:19 rider kernel:  [do_IRQ+295/310] do_IRQ+0x127/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [__do_softirq+47/135] __do_softirq+0x2f/0x87
Oct 30 15:56:19 rider kernel:  [do_softirq+38/40] do_softirq+0x26/0x28
Oct 30 15:56:19 rider kernel:  [do_IRQ+259/310] do_IRQ+0x103/0x136
Oct 30 15:56:19 rider kernel:  [common_interrupt+24/32] 
common_interrupt+0x18/0x20
Oct 30 15:56:19 rider kernel:  [mwait_idle+48/70] mwait_idle+0x30/0x46
Oct 30 15:56:19 rider kernel:  [cpu_idle+55/80] cpu_idle+0x37/0x50
Oct 30 15:56:19 rider kernel:  [start_kernel+343/368] 
start_kernel+0x157/0x170
Oct 30 15:56:19 rider kernel:  [unknown_bootoption+0/348] 
unknown_bootoption+0x0/0x15c



Here's an lspci -v:
[phil@rider ~]$ sudo lspci -v
0000:00:00.0 Host bridge: Intel Corp. 82865G/PE/P DRAM 
Controller/Host-Hub Interface (rev 02)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, fast devsel, latency 0
         Memory at e0000000 (32-bit, prefetchable) [size=256M]
         Capabilities: [e4] #09 [2106]
         Capabilities: [a0] AGP version 3.0

0000:00:01.0 PCI bridge: Intel Corp. 82865G/PE/P PCI to AGP Controller 
(rev 02) (prog-if 00 [Normal decode])
         Flags: bus master, 66MHz, fast devsel, latency 64
         Bus: primary=00, secondary=01, subordinate=01, sec-latency=64
         Memory behind bridge: fc900000-fe9fffff
         Prefetchable memory behind bridge: bff00000-dfefffff

0000:00:1d.0 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #1 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 10
         I/O ports at ef00 [size=32]

0000:00:1d.1 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #2 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 5
         I/O ports at ef20 [size=32]

0000:00:1d.2 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #3 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 5
         I/O ports at ef40 [size=32]

0000:00:1d.3 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB 
UHCI #4 (rev 02) (prog-if 00 [UHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 10
         I/O ports at ef80 [size=32]

0000:00:1d.7 USB Controller: Intel Corp. 82801EB/ER (ICH5/ICH5R) USB2 
EHCI Controller (rev 02) (prog-if 20 [EHCI])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 11
         Memory at febffc00 (32-bit, non-prefetchable) [size=1K]
         Capabilities: [50] Power Management version 2
         Capabilities: [58] #0a [20a0]

0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev c2) (prog-if 
00 [Normal decode])
         Flags: bus master, fast devsel, latency 0
         Bus: primary=00, secondary=02, subordinate=02, sec-latency=64
         I/O behind bridge: 0000d000-0000dfff
         Memory behind bridge: fea00000-feafffff

0000:00:1f.0 ISA bridge: Intel Corp. 82801EB/ER (ICH5/ICH5R) LPC Bridge 
(rev 02)
         Flags: bus master, medium devsel, latency 0

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra 
ATA 100 Storage Controller (rev 02) (prog-if 8f [Master SecP SecO PriP 
PriO])
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: bus master, medium devsel, latency 0, IRQ 5
         I/O ports at efe0 [size=8]
         I/O ports at efac [size=4]
         I/O ports at efa0 [size=8]
         I/O ports at efa8 [size=4]
         I/O ports at ef60 [size=16]
         Memory at 40000000 (32-bit, non-prefetchable) [size=1K]

0000:00:1f.3 SMBus: Intel Corp. 82801EB/ER (ICH5/ICH5R) SMBus Controller 
(rev 02)
         Subsystem: Asustek Computer, Inc. P4P800 Mainboard
         Flags: medium devsel, IRQ 5
         I/O ports at 0400 [size=32]

0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER 
(ICH5/ICH5R) AC'97 Audio Controller (rev 02)
         Subsystem: Asustek Computer, Inc.: Unknown device 812a
         Flags: bus master, medium devsel, latency 0, IRQ 5
         I/O ports at e800 [size=256]
         I/O ports at ee80 [size=64]
         Memory at febff800 (32-bit, non-prefetchable) [size=512]
         Memory at febff400 (32-bit, non-prefetchable) [size=256]
         Capabilities: [50] Power Management version 2

0000:01:00.0 VGA compatible controller: nVidia Corporation NV 36 
[GeForce 5700] (rev a1) (prog-if 00 [VGA])
         Subsystem: Asustek Computer, Inc.: Unknown device 814f
         Flags: bus master, 66MHz, medium devsel, latency 248, IRQ 10
         Memory at fd000000 (32-bit, non-prefetchable) [size=16M]
         Memory at c0000000 (32-bit, prefetchable) [size=256M]
         Expansion ROM at fe9e0000 [disabled] [size=128K]
         Capabilities: [60] Power Management version 2
         Capabilities: [44] AGP version 3.0

0000:02:03.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80) (prog-if 10 [OHCI])
         Subsystem: Asustek Computer, Inc.: Unknown device 808a
         Flags: bus master, medium devsel, latency 64, IRQ 11
         Memory at feaff800 (32-bit, non-prefetchable) [size=2K]
         I/O ports at dc00 [size=128]
         Capabilities: [50] Power Management version 2

0000:02:05.0 Ethernet controller: Marvell Technology Group Ltd. Yukon 
Gigabit Ethernet 10/100/1000Base-T Adapter (rev 13)
         Subsystem: Asustek Computer, Inc.: Unknown device 811a
         Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
         Memory at feaf8000 (32-bit, non-prefetchable) [size=16K]
         I/O ports at d800 [size=256]
         Expansion ROM at feaa0000 [disabled] [size=128K]
         Capabilities: [48] Power Management version 2
         Capabilities: [50] Vital Product Data

[phil@rider ~]$

uname:
[phil@rider ~]$ uname -a
Linux rider 2.6.9rider #1 Sun Oct 31 04:10:25 PST 2004 i686 GNU/Linux
[phil@rider ~]$


I have an Asus P4P800-E Delux motherboard, with a Pentium 4 3.0G E, I 
have two PATA hard drives connected to hda and hdb -- if I connect my 
CDROMs on hdc and hdd I get so many of the above errors I can't even 
boot -- but with just the two harddrives I get the errors exactly as above.

If there's any additional information I can provide, please let me know. 
Also, I'm not on the linux-ide list, so please CC me on replies.

Thanks.
-- 
Phil Dibowitz                             phil@ipom.com
Freeware and Technical Pages              Insanity Palace of Metallica
http://www.phildev.net/                   http://www.ipom.com/

"They that can give up essential liberty to obtain a little temporary
safety deserve neither liberty nor safety."
  - Benjamin Franklin, 1759


--------------enig129F4B557820DBD4FBA880A8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhCHpN5XoxaHnMrsRAuqzAJ9V1m0kiBnmDJjwMYQ0nAJ389FB3wCeIfzE
9c98iVvSzeTXK2jBaD+YtNU=
=Cgh2
-----END PGP SIGNATURE-----

--------------enig129F4B557820DBD4FBA880A8--
