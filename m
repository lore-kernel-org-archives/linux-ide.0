From: "Bernhard R. Link" <brlink@debian.org>
Subject: sata_mv freezing on qnap TS-419p
Date: Thu, 25 Mar 2010 13:27:42 +0100
Message-ID: <20100325122742.GA12986@pcpool00.mathematik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:35634
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753774Ab0CYMxe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 25 Mar 2010 08:53:34 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Mark Lord <mlord@pobox.com>, Saeed Bishara <saeed@marvell.com>, Martin Michlmayr <tbm@cyrius.com>


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

My qnap TS-419p (and I heared about similar reports from other
people) regulary freezes. It looks similar to the problem discussed
in http://markmail.org/thread/ne3bt6xi3plpvjmx

The problem always happens a short time after a cold boot. When
the system is restarted, it yet never happened to me. The system
boots up fully, one can do some stuff. When after some time
somethings needs disc-access, there will no longer be any reaction.
The message one usually only sees is "Unable to stop eDMA".

The message appears to be happen when the driver tries to
reset the hardware after an timeout. (So I guess the actual
problem might be something else which also causes the timeout).

Attached is a log with
dev.scsi.logging_level=0xFF
in /proc/sysctl.conf
and
echo -n '0xFFFFFFFFF' > /proc/sys/dev/scsi/logging_level
once the system is booted up.
The kernel is based on Debian's 2.6.32-9 with additional
output and some WARN_ON(1) added to places reached before
the "Unable to stop eDMA" message appears.

If you have any other ideas what to check, or want me to
try some other kernel, please let me know.

lspci says about the devce:
00:01.0 SCSI storage controller [0100]: Marvell Technology Group Ltd.  88SX7042 PCI-e 4-port SATA-II [11ab:7042] (rev 02)

and /proc/cpuinfo says:
Processor       : Feroceon 88FR131 rev 1 (v5l)
BogoMIPS        : 1199.30
Features        : swp half thumb fastmult edsp
CPU implementer : 0x56
CPU architecture: 5TE
CPU variant     : 0x2
CPU part        : 0x131
CPU revision    : 1

Hardware        : QNAP TS-41x
Revision        : 0000
Serial          : 0000000000000000

Thanks in advance,
	Bernhard R. Link

--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=verbfail

[    0.000000] Linux version 2.6.32-3-kirkwood (Debian 2.6.32-9) (maks@debian.org) (gcc version 4.3.4 (Debian 4.3.4-6) ) #5 Wed Mar 3 15:21:08 UTC 2010
[    0.000000] CPU: Feroceon 88FR131 [56251311] revision 1 (ARMv5TE), cr=00053977
[    0.000000] CPU: VIVT data cache, VIVT instruction cache
[    0.000000] Machine: QNAP TS-41x
[    0.000000] Ignoring unrecognised tag 0x41000403
[    0.000000] Memory policy: ECC disabled, Data cache writeback
[    0.000000] On node 0 totalpages: 131072
[    0.000000] free_area_init_node: node 0, pgdat c03292f4, node_mem_map c0399000
[    0.000000]   Normal zone: 1024 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 130048 pages, LIFO batch:31
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 130048
[    0.000000] Kernel command line: root=/dev/ram initrd=0xa00000,0x900000 ramdisk=32768
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 256MB 256MB = 512MB total
[    0.000000] Memory: 506624KB available (2868K code, 579K data, 112K init, 0K highmem)
[    0.000000] SLUB: Genslabs=11, HWalign=32, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:114
[    0.000000] Console: colour dummy device 80x30
[    0.000000] console [tty0] enabled
[   21.475114] Calibrating delay loop... 1199.30 BogoMIPS (lpj=5996544)
[   21.704946] Mount-cache hash table entries: 512
[   21.705238] CPU: Testing write buffer coherency: ok
[   21.705861] devtmpfs: initialized
[   21.707501] regulator: core version 0.5
[   21.707711] NET: Registered protocol family 16
[   21.708278] Kirkwood: MV88F6281-A0, TCLK=200000000.
[   21.708311] Feroceon L2: Enabling L2
[   21.708357] Feroceon L2: Cache support initialised.
[   21.708806] initial MPP regs: 11112222 43303311 33330004 33003333 00000033 00000000 00000000
[   21.708831]   final MPP regs: 11112222 43303311 33330004 33003333 00000033 00000000 00000000
[   21.709448] pci 0000:00:00.0: reg 10 64bit mmio pref: [0xf1000000-0xf10fffff]
[   21.709463] pci 0000:00:00.0: reg 18 32bit mmio: [0x000000-0x1fffffff]
[   21.709489] pci 0000:00:00.0: supports D1 D2
[   21.709541] pci 0000:00:01.0: reg 10 64bit mmio: [0x40000000-0x400fffff]
[   21.709556] pci 0000:00:01.0: reg 18 io port: [0xf0000000-0xf00000ff]
[   21.709637] PCI: bus0: Fast back to back transfers disabled
[   21.711060] bio: create slab <bio-0> at 0
[   21.711335] vgaarb: loaded
[   21.711767] Switching to clocksource orion_clocksource
[   21.715467] NET: Registered protocol family 2
[   21.715721] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[   21.716412] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[   21.716782] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[   21.716971] TCP: Hash tables configured (established 16384 bind 16384)
[   21.716990] TCP reno registered
[   21.717123] NET: Registered protocol family 1
[   21.717305] Unpacking initramfs...
[   22.103730] Freeing initrd memory: 9216K
[   22.103870] NetWinder Floating Point Emulator V0.97 (double precision)
[   22.104129] audit: initializing netlink socket (disabled)
[   22.104176] type=2000 audit(0.620:1): initialized
[   22.110206] VFS: Disk quotas dquot_6.5.2
[   22.110475] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[   22.110652] msgmni has been set to 1008
[   22.112324] alg: No test for stdrng (krng)
[   22.112606] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[   22.112636] io scheduler noop registered
[   22.112651] io scheduler anticipatory registered
[   22.112667] io scheduler deadline registered
[   22.112861] io scheduler cfq registered (default)
[   22.118633] Serial: 8250/16550 driver, 2 ports, IRQ sharing disabled
[   22.119100] serial8250.0: ttyS0 at MMIO 0xf1012000 (irq = 33) is a 16550A
[   22.119351] serial8250.1: ttyS1 at MMIO 0xf1012100 (irq = 34) is a 16550A
[   22.120191] mice: PS/2 mouse device common for all mice
[   23.121816] rtc-mv rtc-mv: internal RTC not ticking
[   23.121936] i2c /dev entries driver
[   23.123855] rtc-s35390a 0-0030: rtc core: registered rtc-s35390a as rtc0
[   23.124121] cpuidle: using governor ladder
[   23.124269] cpuidle: using governor menu
[   23.124314] mv_xor_shared mv_xor_shared.0: Marvell shared XOR driver
[   23.124352] mv_xor_shared mv_xor_shared.1: Marvell shared XOR driver
[   23.161840] mv_xor mv_xor.0: Marvell XOR: ( xor cpy )
[   23.201838] mv_xor mv_xor.1: Marvell XOR: ( xor fill cpy )
[   23.241837] mv_xor mv_xor.2: Marvell XOR: ( xor cpy )
[   23.281837] mv_xor mv_xor.3: Marvell XOR: ( xor fill cpy )
[   23.282725] TCP cubic registered
[   23.282745] NET: Registered protocol family 17
[   23.282775] Gating clock of unused units
[   23.282782] before: 0x00cfc1dd
[   23.282788]  after: 0x00cfc1cd
[   23.283823] rtc-s35390a 0-0030: setting system clock to 2010-03-25 12:01:49 UTC (1269518509)
[   23.283893] Freeing init memory: 112K
[   24.428032] SCSI subsystem initialized
[   24.508869] MV-643xx 10/100/1000 ethernet driver version 1.4
[   24.509585] mv643xx_eth smi: probed
[   24.516874] net eth0: port 0 with MAC address 00:08:9b:8d:9b:6e
[   24.520309] net eth1: port 0 with MAC address 00:08:9b:8d:9b:6f
[   24.536853] libata version 3.00 loaded.
[   24.558085] sata_mv 0000:00:01.0: version 1.28
[   24.558342] sata_mv 0000:00:01.0: Gen-IIE 32 slots 4 ports SCSI mode IRQ via INTx
[   24.558679] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.559023] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.559438] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.559827] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.561534] scsi0 : sata_mv
[   24.562841] scsi1 : sata_mv
[   24.563868] scsi2 : sata_mv
[   24.564910] scsi3 : sata_mv
[   24.565100] ata1: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0022000 irq 9
[   24.565131] ata2: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0024000 irq 9
[   24.565158] ata3: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0026000 irq 9
[   24.565184] ata4: SATA max UDMA/133 mmio m1048576@0xe0000000 port 0xe0028000 irq 9
[   24.565315] sata_mv sata_mv.0: version 1.28
[   24.565392] in mv_reset_channel
[   24.565408] mv_stop_edma_engine: from 10000 down to 10000
[   24.565451] in mv_reset_channel
[   24.565464] mv_stop_edma_engine: from 10000 down to 10000
[   24.565511] sata_mv sata_mv.0: slots 32 ports 2
[   24.565910] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.566309] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.569736] ------------[ cut here ]------------
[   24.569815] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   24.569850] Modules linked in: sata_mv(+) libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   24.569914] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   24.569979] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   24.570072] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   24.570170] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   24.570242] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   24.570284] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   24.570323] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   24.570351] ---[ end trace c36ff784078cdec7 ]---
[   24.570400] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.570421] in mv_reset_channel
[   24.570439] mv_stop_edma_engine: from 10000 down to 10000
[   24.570929] scsi4 : sata_mv
[   24.572143] scsi5 : sata_mv
[   24.572353] ata5: SATA max UDMA/133 irq 21
[   24.572374] ata6: SATA max UDMA/133 irq 21
[   24.575903] ------------[ cut here ]------------
[   24.575980] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   24.576015] Modules linked in: sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   24.576077] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   24.576143] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   24.576235] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   24.576335] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   24.576407] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   24.576449] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   24.576487] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   24.576514] ---[ end trace c36ff784078cdec8 ]---
[   24.576562] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   24.576583] in mv_reset_channel
[   24.576597] mv_stop_edma_engine: from 10000 down to 10000
[   24.921818] ata5: SATA link down (SStatus 0 SControl F300)
[   25.071843] ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   25.071882] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.092109] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.131866] ata1.00: ATA-8: ST3250310NS, SN06, max UDMA/133
[   25.131890] ata1.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   25.131966] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.151853] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.172099] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.211906] ata1.00: configured for UDMA/133
[   25.212208] scsi 0:0:0:0: Direct-Access     ATA      ST3250310NS      SN06 PQ: 0 ANSI: 5
[   25.214332] ------------[ cut here ]------------
[   25.214408] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   25.214444] Modules linked in: sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   25.214504] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   25.214570] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   25.214664] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   25.214764] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   25.214835] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   25.214877] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   25.214915] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   25.214942] ---[ end trace c36ff784078cdec9 ]---
[   25.215007] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.215029] in mv_reset_channel
[   25.215045] mv_stop_edma_engine: from 10000 down to 10000
[   25.721843] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
[   25.721883] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.742105] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.781866] ata2.00: ATA-8: ST3250310NS, SN06, max UDMA/133
[   25.781889] ata2.00: 488397168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[   25.781965] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.801854] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.822098] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.861906] ata2.00: configured for UDMA/133
[   25.862179] scsi 1:0:0:0: Direct-Access     ATA      ST3250310NS      SN06 PQ: 0 ANSI: 5
[   25.862638] ------------[ cut here ]------------
[   25.862706] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   25.862742] Modules linked in: sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   25.862801] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   25.862867] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   25.862959] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   25.863059] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   25.863130] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   25.863172] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   25.863210] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   25.863237] ---[ end trace c36ff784078cdeca ]---
[   25.863281] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   25.863302] in mv_reset_channel
[   25.863317] mv_stop_edma_engine: from 10000 down to 10000
[   26.211836] ata3: SATA link down (SStatus 0 SControl 300)
[   26.211909] ------------[ cut here ]------------
[   26.211975] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   26.212010] Modules linked in: sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   26.212069] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   26.212134] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   26.212226] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   26.212325] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   26.212395] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   26.212437] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   26.212475] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   26.212502] ---[ end trace c36ff784078cdecb ]---
[   26.212544] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   26.212563] in mv_reset_channel
[   26.212579] mv_stop_edma_engine: from 10000 down to 10000
[   26.561834] ata4: SATA link down (SStatus 0 SControl 300)
[   26.561920] ------------[ cut here ]------------
[   26.561983] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[   26.562018] Modules linked in: sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache
[   26.562074] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[   26.562137] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[   26.562228] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod])
[   26.562325] [<bf068af4>] (scsi_schedule_eh+0x50/0x5c [scsi_mod]) from [<bf0a3aec>] (async_port_probe+0xac/0xec [libata])
[   26.562395] [<bf0a3aec>] (async_port_probe+0xac/0xec [libata]) from [<c005e574>] (async_thread+0x108/0x2ac)
[   26.562435] [<c005e574>] (async_thread+0x108/0x2ac) from [<c0058194>] (kthread+0x78/0x80)
[   26.562473] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[   26.562499] ---[ end trace c36ff784078cdecc ]---
[   26.562546] mv_stop_edma: MV_PP_FLAG_EDMA_EN not set
[   26.562566] in mv_reset_channel
[   26.562580] mv_stop_edma_engine: from 10000 down to 10000
[   26.911814] ata6: SATA link down (SStatus 0 SControl F300)
[   27.006017] sd 0:0:0:0: [sda] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[   27.006240] sd 0:0:0:0: [sda] Write Protect is off
[   27.006262] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[   27.006362] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   27.006897]  sda:
[   27.007777] sd 1:0:0:0: [sdb] 488397168 512-byte logical blocks: (250 GB/232 GiB)
[   27.007990] sd 1:0:0:0: [sdb] Write Protect is off
[   27.008013] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[   27.008112] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[   27.008644]  sdb: sdb1
[   27.037640]  sda1 sda2 sda3 sda4 <
[   27.039625] sd 1:0:0:0: [sdb] Attached SCSI disk
[   27.046928]  sda5 sda6 sda7 >
[   27.075732] sd 0:0:0:0: [sda] Attached SCSI disk
[   27.589842] md: linear personality registered for level -1
[   27.610458] md: multipath personality registered for level -4
[   27.631442] md: raid0 personality registered for level 0
[   27.658930] md: raid1 personality registered for level 1
[   27.678364] async_tx: api initialized (async)
[   27.687250] xor: measuring software checksum speed
[   27.731805]    arm4regs  :  1091.200 MB/sec
[   27.781802]    8regs     :   808.800 MB/sec
[   27.831804]    32regs    :   896.400 MB/sec
[   27.831823] xor: using function: arm4regs (1091.200 MB/sec)
[   28.012124] raid6: int32x1     78 MB/s
[   28.182384] raid6: int32x2    104 MB/s
[   28.351969] raid6: int32x4    125 MB/s
[   28.521975] raid6: int32x8    110 MB/s
[   28.521995] raid6: using algorithm int32x4 (125 MB/s)
[   28.555799] md: raid6 personality registered for level 6
[   28.555831] md: raid5 personality registered for level 5
[   28.555847] md: raid4 personality registered for level 4
[   28.636382] md: raid10 personality registered for level 10
[   28.793415] device-mapper: uevent: version 1.0.3
[   28.800248] device-mapper: ioctl: 4.15.0-ioctl (2009-04-01) initialised: dm-devel@redhat.com
[   28.961147] kjournald starting.  Commit interval 5 seconds
[   28.961201] EXT3-fs: mounted filesystem with ordered data mode.
[   30.084451] udevd version 125 started
[   31.292967] input: gpio-keys as /devices/platform/gpio-keys/input/input0
[   34.064235] EXT3 FS on sda1, internal journal
[   35.064287] loop: module loaded
[   36.057137] scsi_block_when_processing_errors: rtn: 1
[   36.059345] kjournald starting.  Commit interval 5 seconds
[   36.059907] EXT3 FS on sda2, internal journal
[   36.059934] EXT3-fs: mounted filesystem with ordered data mode.
[   36.060705] scsi_block_when_processing_errors: rtn: 1
[   36.087701] kjournald starting.  Commit interval 5 seconds
[   36.094715] EXT3 FS on sda3, internal journal
[   36.094742] EXT3-fs: mounted filesystem with ordered data mode.
[   38.476448] eth0: link up, 100 Mb/s, full duplex, flow control disabled
[   79.381843] sd 0:0:0:0: [sda] sd_init_command: block=13703445, count=16
[   79.381880] sd 0:0:0:0: [sda] block=13703445
[   79.381898] sd 0:0:0:0: [sda] writing 16/16 512 byte blocks.
[   79.381922] sd 0:0:0:0: [sda] Send: 0xdefa9960 
[   79.381942] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 19 15 00 00 10 00
[   79.381982] buffer = 0xdf919100, bufflen = 8192, queuecommand 0xbf0a5fdc
[   79.382019] leaving scsi_dispatch_cmnd()
[   79.382045] sd 0:0:0:0: [sda] sd_init_command: block=13704413, count=24
[   79.382066] sd 0:0:0:0: [sda] block=13704413
[   79.382083] sd 0:0:0:0: [sda] writing 24/24 512 byte blocks.
[   79.382103] sd 0:0:0:0: [sda] Send: 0xdefa9500 
[   79.382121] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 1c dd 00 00 18 00
[   79.382159] buffer = 0xdf919900, bufflen = 12288, queuecommand 0xbf0a5fdc
[   79.382189] leaving scsi_dispatch_cmnd()
[   79.382212] sd 0:0:0:0: [sda] sd_init_command: block=13708517, count=8
[   79.382233] sd 0:0:0:0: [sda] block=13708517
[   79.382249] sd 0:0:0:0: [sda] writing 8/8 512 byte blocks.
[   79.382268] sd 0:0:0:0: [sda] Send: 0xdefa9e60 
[   79.382287] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 2c e5 00 00 08 00
[   79.382326] buffer = 0xdf919980, bufflen = 4096, queuecommand 0xbf0a5fdc
[   79.382351] leaving scsi_dispatch_cmnd()
[   84.521935] sd 0:0:0:0: [sda] sd_init_command: block=10324433, count=8
[   84.521972] sd 0:0:0:0: [sda] block=10324433
[   84.521990] sd 0:0:0:0: [sda] writing 8/8 512 byte blocks.
[   84.522014] sd 0:0:0:0: [sda] Send: 0xdefa9dc0 
[   84.522035] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9d 89 d1 00 00 08 00
[   84.522075] buffer = 0xc0cf7780, bufflen = 4096, queuecommand 0xbf0a5fdc
[   84.522111] leaving scsi_dispatch_cmnd()
[   84.522138] sd 0:0:0:0: [sda] sd_init_command: block=10422673, count=16
[   84.522159] sd 0:0:0:0: [sda] block=10422673
[   84.522175] sd 0:0:0:0: [sda] writing 16/16 512 byte blocks.
[   84.522195] sd 0:0:0:0: [sda] Send: 0xdefa9d20 
[   84.522214] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9f 09 91 00 00 10 00
[   84.522252] buffer = 0xc0cf7800, bufflen = 8192, queuecommand 0xbf0a5fdc
[   84.522279] leaving scsi_dispatch_cmnd()
[   84.522303] sd 0:0:0:0: [sda] sd_init_command: block=10422801, count=8
[   84.522323] sd 0:0:0:0: [sda] block=10422801
[   84.522339] sd 0:0:0:0: [sda] writing 8/8 512 byte blocks.
[   84.522358] sd 0:0:0:0: [sda] Send: 0xdefa9c80 
[   84.522376] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9f 0a 11 00 00 08 00
[   84.522414] buffer = 0xc0cf7a00, bufflen = 4096, queuecommand 0xbf0a5fdc
[   84.522439] leaving scsi_dispatch_cmnd()
[  109.521812] blk_rq_timed_out_timer: df9ea0c8 timed out after 3000 = 30 Hz
[  109.521849] sd 0:0:0:0: [sda] Done: 0xdefa9960 TIMEOUT
[  109.521871] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  109.521894] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 19 15 00 00 10 00
[  109.521934] sd 0:0:0:0: [sda] scsi host busy 6 failed 0
[  109.521954] blk_rq_timed_out_timer: df9ea000 timed out after 3000 = 30 Hz
[  109.521974] sd 0:0:0:0: [sda] Done: 0xdefa9500 TIMEOUT
[  109.521992] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  109.522014] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 1c dd 00 00 18 00
[  109.522051] sd 0:0:0:0: [sda] scsi host busy 6 failed 1
[  109.522070] blk_rq_timed_out_timer: df9ea190 timed out after 3000 = 30 Hz
[  109.522089] sd 0:0:0:0: [sda] Done: 0xdefa9e60 TIMEOUT
[  109.522108] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  109.522129] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 d1 2c e5 00 00 08 00
[  109.522167] sd 0:0:0:0: [sda] scsi host busy 6 failed 2
[  115.521812] blk_rq_timed_out_timer: df9ea258 timed out after 3000 = 30 Hz
[  115.521849] sd 0:0:0:0: [sda] Done: 0xdefa9dc0 TIMEOUT
[  115.521871] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  115.521893] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9d 89 d1 00 00 08 00
[  115.521933] sd 0:0:0:0: [sda] scsi host busy 6 failed 3
[  115.521953] blk_rq_timed_out_timer: df9ea320 timed out after 3000 = 30 Hz
[  115.521973] sd 0:0:0:0: [sda] Done: 0xdefa9d20 TIMEOUT
[  115.521991] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  115.522012] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9f 09 91 00 00 10 00
[  115.522050] sd 0:0:0:0: [sda] scsi host busy 6 failed 4
[  115.522068] blk_rq_timed_out_timer: df9ea3e8 timed out after 3000 = 30 Hz
[  115.522088] sd 0:0:0:0: [sda] Done: 0xdefa9c80 TIMEOUT
[  115.522106] sd 0:0:0:0: [sda] Result: hostbyte=DID_OK driverbyte=DRIVER_OK
[  115.522127] sd 0:0:0:0: [sda] CDB: Write(10): 2a 00 00 9f 0a 11 00 00 08 00
[  115.522165] sd 0:0:0:0: [sda] scsi host busy 6 failed 5
[  115.522180] ------------[ cut here ]------------
[  115.522250] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/scsi/scsi_error.c:54 scsi_eh_wakeup+0x24/0x5c [scsi_mod]()
[  115.522285] Modules linked in: loop evdev orion_spi mv_cesa aes_generic gpio_keys dm_mirror dm_region_hash dm_log dm_snapshot dm_mod raid10 raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx raid1 raid0 multipath linear md_mod sd_mod crc_t10dif sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache [last unloaded: scsi_wait_scan]
[  115.522445] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[  115.522514] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod])
[  115.522613] [<bf068944>] (scsi_eh_wakeup+0x24/0x5c [scsi_mod]) from [<bf068a14>] (scsi_eh_scmd_add+0x98/0xa8 [scsi_mod])
[  115.522710] [<bf068a14>] (scsi_eh_scmd_add+0x98/0xa8 [scsi_mod]) from [<bf068a7c>] (scsi_times_out+0x58/0x80 [scsi_mod])
[  115.522781] [<bf068a7c>] (scsi_times_out+0x58/0x80 [scsi_mod]) from [<c0137894>] (blk_rq_timed_out+0x14/0x78)
[  115.522819] [<c0137894>] (blk_rq_timed_out+0x14/0x78) from [<c0137aac>] (blk_rq_timed_out_timer+0xb0/0x118)
[  115.522858] [<c0137aac>] (blk_rq_timed_out_timer+0xb0/0x118) from [<c004cfb0>] (run_timer_softirq+0x210/0x2f8)
[  115.522900] [<c004cfb0>] (run_timer_softirq+0x210/0x2f8) from [<c0046888>] (__do_softirq+0xc0/0x1a4)
[  115.522937] [<c0046888>] (__do_softirq+0xc0/0x1a4) from [<c00469ac>] (irq_exit+0x40/0x94)
[  115.522973] [<c00469ac>] (irq_exit+0x40/0x94) from [<c0024070>] (asm_do_IRQ+0x70/0x8c)
[  115.523007] [<c0024070>] (asm_do_IRQ+0x70/0x8c) from [<c0024ad4>] (__irq_svc+0x34/0x80)
[  115.523032] Exception stack(0xc0305f48 to 0xc0305f90)
[  115.523055] 5f40:                   000df223 000df223 4bab5109 0007d7bd c030aea8 c030af18
[  115.523086] 5f60: c030aea8 c0392290 0001fa0c 56251311 0001f9a4 00000000 3679d9d3 c0305f90
[  115.523113] 5f80: c0060cc4 c002ef5c 20000013 ffffffff
[  115.523142] [<c0024ad4>] (__irq_svc+0x34/0x80) from [<c002ef5c>] (kirkwood_enter_idle+0x64/0x88)
[  115.523178] [<c002ef5c>] (kirkwood_enter_idle+0x64/0x88) from [<c01c6dd8>] (cpuidle_idle_call+0xb0/0x150)
[  115.523216] [<c01c6dd8>] (cpuidle_idle_call+0xb0/0x150) from [<c002644c>] (cpu_idle+0x5c/0xa4)
[  115.523251] [<c002644c>] (cpu_idle+0x5c/0xa4) from [<c0008ae0>] (start_kernel+0x258/0x2bc)
[  115.523286] [<c0008ae0>] (start_kernel+0x258/0x2bc) from [<00008034>] (0x8034)
[  115.523310] ---[ end trace c36ff784078cdecd ]---
[  115.523328] Waking error handler thread
[  115.523361] Error handler scsi_eh_0 waking up
[  115.523384] ------------[ cut here ]------------
[  115.523427] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/ata/sata_mv.c:1217 mv_stop_edma+0x50/0x15c [sata_mv]()
[  115.523460] Modules linked in: loop evdev orion_spi mv_cesa aes_generic gpio_keys dm_mirror dm_region_hash dm_log dm_snapshot dm_mod raid10 raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx raid1 raid0 multipath linear md_mod sd_mod crc_t10dif sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache [last unloaded: scsi_wait_scan]
[  115.523609] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[  115.523657] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf0d3220>] (mv_stop_edma+0x50/0x15c [sata_mv])
[  115.523716] [<bf0d3220>] (mv_stop_edma+0x50/0x15c [sata_mv]) from [<bf0d3338>] (mv_eh_freeze+0xc/0x1c [sata_mv])
[  115.523804] [<bf0d3338>] (mv_eh_freeze+0xc/0x1c [sata_mv]) from [<bf0a80fc>] (__ata_port_freeze+0x3c/0x54 [libata])
[  115.523911] [<bf0a80fc>] (__ata_port_freeze+0x3c/0x54 [libata]) from [<bf0ac3c8>] (ata_scsi_error+0x114/0x680 [libata])
[  115.524023] [<bf0ac3c8>] (ata_scsi_error+0x114/0x680 [libata]) from [<bf068348>] (scsi_error_handler+0xd4/0x5ac [scsi_mod])
[  115.524100] [<bf068348>] (scsi_error_handler+0xd4/0x5ac [scsi_mod]) from [<c0058194>] (kthread+0x78/0x80)
[  115.524142] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[  115.524168] ---[ end trace c36ff784078cdece ]---
[  115.524186] ata1: mv_wait_for_edma_empty_idle: 0+ usecs
[  115.630767] mv_stop_edma_engine: failed
[  115.630780] ata1: Unable to stop eDMA
[  115.630849] ata1.00: exception Emask 0x52 SAct 0x3f SErr 0xffffffff action 0xe frozen
[  115.630884] ata1: SError: { RecovData RecovComm UnrecovData Persist Proto HostInt PHYRdyChg PHYInt CommWake 10B8B Dispar BadCRC Handshk LinkSeq TrStaTrns UnrecFIS DevExch }
[  115.630928] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.630960] ata1.00: cmd 61/10:00:15:19:d1/00:00:00:00:00/40 tag 0 ncq 8192 out
[  115.630967]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631006] ata1.00: status: { DRDY }
[  115.631022] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.631052] ata1.00: cmd 61/18:08:dd:1c:d1/00:00:00:00:00/40 tag 1 ncq 12288 out
[  115.631059]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631097] ata1.00: status: { DRDY }
[  115.631113] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.631143] ata1.00: cmd 61/08:10:e5:2c:d1/00:00:00:00:00/40 tag 2 ncq 4096 out
[  115.631150]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631188] ata1.00: status: { DRDY }
[  115.631204] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.631234] ata1.00: cmd 61/08:18:d1:89:9d/00:00:00:00:00/40 tag 3 ncq 4096 out
[  115.631241]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631278] ata1.00: status: { DRDY }
[  115.631294] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.631324] ata1.00: cmd 61/10:20:91:09:9f/00:00:00:00:00/40 tag 4 ncq 8192 out
[  115.631331]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631369] ata1.00: status: { DRDY }
[  115.631385] ata1.00: failed command: WRITE FPDMA QUEUED
[  115.631415] ata1.00: cmd 61/08:28:11:0a:9f/00:00:00:00:00/40 tag 5 ncq 4096 out
[  115.631421]          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x56 (ATA bus error)
[  115.631459] ata1.00: status: { DRDY }
[  115.631484] ------------[ cut here ]------------
[  115.631524] WARNING: at /home/test/linux-2.6-2.6.32/debian/build/source_armel_none/drivers/ata/sata_mv.c:1217 mv_stop_edma+0x50/0x15c [sata_mv]()
[  115.631557] Modules linked in: loop evdev orion_spi mv_cesa aes_generic gpio_keys dm_mirror dm_region_hash dm_log dm_snapshot dm_mod raid10 raid456 async_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx raid1 raid0 multipath linear md_mod sd_mod crc_t10dif sata_mv libata mv643xx_eth scsi_mod libphy ext3 jbd ext2 mbcache [last unloaded: scsi_wait_scan]
[  115.631707] [<c002aecc>] (unwind_backtrace+0x0/0xdc) from [<c0040c9c>] (warn_slowpath_common+0x4c/0x80)
[  115.631754] [<c0040c9c>] (warn_slowpath_common+0x4c/0x80) from [<bf0d3220>] (mv_stop_edma+0x50/0x15c [sata_mv])
[  115.631813] [<bf0d3220>] (mv_stop_edma+0x50/0x15c [sata_mv]) from [<bf0d3338>] (mv_eh_freeze+0xc/0x1c [sata_mv])
[  115.631896] [<bf0d3338>] (mv_eh_freeze+0xc/0x1c [sata_mv]) from [<bf0a80fc>] (__ata_port_freeze+0x3c/0x54 [libata])
[  115.631998] [<bf0a80fc>] (__ata_port_freeze+0x3c/0x54 [libata]) from [<bf0a8138>] (ata_eh_freeze_port+0x24/0x3c [libata])
[  115.632102] [<bf0a8138>] (ata_eh_freeze_port+0x24/0x3c [libata]) from [<bf0a8b6c>] (ata_eh_reset+0x434/0xd88 [libata])
[  115.632206] [<bf0a8b6c>] (ata_eh_reset+0x434/0xd88 [libata]) from [<bf0ab0ac>] (ata_eh_recover+0x324/0xce4 [libata])
[  115.632317] [<bf0ab0ac>] (ata_eh_recover+0x324/0xce4 [libata]) from [<bf0b0264>] (sata_pmp_error_handler+0xb8/0xa54 [libata])
[  115.632431] [<bf0b0264>] (sata_pmp_error_handler+0xb8/0xa54 [libata]) from [<bf0ac5f4>] (ata_scsi_error+0x340/0x680 [libata])
[  115.632541] [<bf0ac5f4>] (ata_scsi_error+0x340/0x680 [libata]) from [<bf068348>] (scsi_error_handler+0xd4/0x5ac [scsi_mod])
[  115.632617] [<bf068348>] (scsi_error_handler+0xd4/0x5ac [scsi_mod]) from [<c0058194>] (kthread+0x78/0x80)
[  115.632657] [<c0058194>] (kthread+0x78/0x80) from [<c0025e7c>] (kernel_thread_exit+0x0/0x8)
[  115.632683] ---[ end trace c36ff784078cdecf ]---
[  115.632701] ata1: mv_wait_for_edma_empty_idle: 0+ usecs
[  115.739282] mv_stop_edma_engine: failed
[  115.739296] ata1: Unable to stop eDMA
[  115.739333] ata1: hard resetting link
[  115.739349] in mv_reset_channel
[  115.846009] mv_stop_edma_engine: failed
[  116.911820] ata1: failed to resume link (SControl FFFFFFFF)
[  117.981818] ata1: failed to resume link (SControl FFFFFFFF)
[  119.051854] ata1: failed to resume link (SControl FFFFFFFF)
[  120.121819] ata1: failed to resume link (SControl FFFFFFFF)
[  121.191819] ata1: failed to resume link (SControl FFFFFFFF)


--wac7ysb48OaltWcw--
