From: "Fajun Chen" <fajunchen@gmail.com>
Subject: Sg/libata hotplug kernel error
Date: Wed, 2 Jan 2008 15:17:39 -0700
Message-ID: <8202f4270801021417n2d7fdffbg9eaa33829eeca475@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hs-out-0708.google.com ([64.233.178.247]:63606 "EHLO
	hs-out-2122.google.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752961AbYABWRo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 2 Jan 2008 17:17:44 -0500
Received: by hs-out-2122.google.com with SMTP id 54so3790179hsz.5
        for <linux-ide@vger.kernel.org>; Wed, 02 Jan 2008 14:17:41 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>

Hi All,

Has anyone seen this kernel error before? The controller is Sil3124
and kernel version 2.6.18-rc2.  This seems to happen very rarely since
this is the first time I 've seen this error message. Thanks for your
feedback!

Fajun

~ $ dmesg
0608 394833] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198330608 395174] sda: Write Protect is off
[1198330608 395226] sda: Mode Sense: 00 3a 00 00
[1198330608 395654] SCSI device sda: drive cache: write back
[1198330608 396194] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198330608 398800] sda: Write Protect is off
[1198330608 398862] sda: Mode Sense: 00 3a 00 00
[1198330608 399293] SCSI device sda: drive cache: write back
[1198330608 399391]  sda: unknown partition table
[1198330608 415346] sd 0:0:0:0: Attached scsi disk sda
[1198330608 415668] sd 0:0:0:0: Attached scsi generic sg0 type 0
[1198339284 728601] ata1 port frozen
[1198339284 728681] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000
action 0x2 frozen
[1198339284 728749] ata1: (irq_stat 0x01100010, PHY RDY changed)
[1198339284 728802] ata1 port frozen
[1198339284 728841] ata1: hard resetting port
[1198339285 277716] ata1: SATA link down (SStatus 0 SControl 300)
[1198339285 277779] ata1 port thawed
[1198339285 277818] ata1.00: disabled
[1198339285 787776] ata1: EH complete
[1198339285 787854] ata1.00: detaching (SCSI 0:0:0:0)
[1198339314 961020] ata1 port frozen
[1198339314 961097] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0
action 0x2 frozen
[1198339314 961164] ata1: (irq_stat 0x00b40090, PHY RDY changed)
[1198339314 961219] ata1 port frozen
[1198339314 961258] ata1: hard resetting port
[1198339318 701017] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[1198339318 701090] ata1 port thawed
[1198339318 702326] ata1.00: ATA-7, max UDMA/133, 312581808 sectors:
LBA48 NCQ (depth 31/32)
[1198339318 703916] ata1.00: configured for UDMA/100
[1198339318 703980] ata1: EH complete
[1198339318 704735]   Vendor: ATA       Model: ST9160823AS       Rev: AAZ2
[1198339318 704850]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[1198339318 705847] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198339318 706165] sda: Write Protect is off
[1198339318 706230] sda: Mode Sense: 00 3a 00 00
[1198339318 706657] SCSI device sda: drive cache: write back
[1198339318 707194] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198339318 707480] sda: Write Protect is off
[1198339318 707541] sda: Mode Sense: 00 3a 00 00
[1198339318 707964] SCSI device sda: drive cache: write back
[1198339318 708031]  sda: unknown partition table
[1198339318 727956] sd 0:0:0:0: Attached scsi disk sda
[1198339318 728265] sd 0:0:0:0: Attached scsi generic sg0 type 0
[1198350170 540587] ata1 port frozen
[1198350170 540662] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000
action 0x2 frozen
[1198350170 540730] ata1: (irq_stat 0x01100010, PHY RDY changed)
[1198350170 540780] ata1 port frozen
[1198350170 540819] ata1: hard resetting port
[1198350171 109527] ata1: SATA link down (SStatus 0 SControl 300)
[1198350171 109592] ata1 port thawed
[1198350171 109631] ata1.00: disabled
[1198350171 619603] ata1: EH complete
[1198350171 619683] ata1.00: detaching (SCSI 0:0:0:0)
[1198350200 751481] ata1 port frozen
[1198350200 751563] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0
action 0x2 frozen
[1198350200 751630] ata1: (irq_stat 0x00b40090, PHY RDY changed)
[1198350200 751685] ata1 port frozen
[1198350200 751725] ata1: hard resetting port
[1198350204 482807] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[1198350204 482878] ata1 port thawed
[1198350204 496761] ata1.00: ATA-7, max UDMA/133, 312581808 sectors:
LBA48 NCQ (depth 31/32)
[1198350204 498302] ata1.00: configured for UDMA/100
[1198350204 498370] ata1: EH complete
[1198350204 499202]   Vendor: ATA       Model: ST9160823AS       Rev: AAZ2
[1198350204 499320]   Type:   Direct-Access                      ANSI
SCSI revision: 05
[1198350204 500328] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198350204 500664] sda: Write Protect is off
[1198350204 500716] sda: Mode Sense: 00 3a 00 00
[1198350204 501161] SCSI device sda: drive cache: write back
[1198350204 501697] SCSI device sda: 312581808 512-byte hdwr sectors (160042 MB)
[1198350204 501987] sda: Write Protect is off
[1198350204 502049] sda: Mode Sense: 00 3a 00 00
[1198350204 502472] SCSI device sda: drive cache: write back
[1198350204 502540]  sda: unknown partition table
[1198350204 513485] sd 0:0:0:0: Attached scsi disk sda
[1198350204 513870] sd 0:0:0:0: Attached scsi generic sg0 type 0
[1198358880 722104] ata1 port frozen
[1198358880 722185] ata1: exception Emask 0x10 SAct 0x0 SErr 0x80000
action 0x2 frozen
[1198358880 722254] ata1: (irq_stat 0x01100010, PHY RDY changed)
[1198358880 722304] ata1 port frozen
[1198358880 722343] ata1: hard resetting port
[1198358881 291114] ata1: SATA link down (SStatus 0 SControl 300)
[1198358881 291176] ata1 port thawed
[1198358881 291215] ata1.00: disabled
[1198358881 801178] ata1: EH complete
[1198358881 802241] ata1.00: detaching (SCSI 0:0:0:0)
[1198358881 807367] BUG: unable to handle kernel NULL pointer
dereference at virtual address 0000004f
[1198358881 807458]  printing eip:
[1198358881 807493] c0143f15
[1198358881 807527] *pde = 0236e067
[1198358881 807561] *pte = 00000000
[1198358881 807600] Oops: 0000 [#1]
[1198358881 807635] Modules linked in:
[1198358881 807681] CPU:    0
[1198358881 807684] EIP:    0060:[<c0143f15>]    Not tainted VLI
[1198358881 807689] EFLAGS: 00010246
(2.6.18-rc2-iop1-geminicpc-libata-aau-sg-libata-printk-fix-flex #1)
[1198358881 807839] EIP is at cdev_del+0x3/0x1b
[1198358881 807881] eax: ffffffff   ebx: ffffffff   ecx: c3eff300
edx: 00000001
[1198358881 807950] esi: 00000000   edi: c13ff960   ebp: c02aa260
esp: c3ee7edc
[1198358881 808017] ds: 007b   es: 007b   ss: 0068
[1198358881 808060] Process ata_aux (pid: 687, ti=c3ee6000
task=c1362050 task.ti=c3ee6000)
[1198358881 808108] Stack: 00000000 c01ece0c 00000000 c1b2c000
00000286 00000000 01500000 00000001
[1198358881 808203]        c02acb90 c1b2c1cc c02aa2dc c02aa260
c01c5dfb 00000000 00000246 c1b2c1cc
[1198358881 808297]        c1b2c090 00000246 c109c2ac c01c5ed3
c1b2c000 c01d378d c1b2c000 c109c028
[1198358881 808391] Call Trace:
[1198358881 808447]  [<c01ece0c>] sg_remove+0x1d1/0x214
[1198358881 808513]  [<c01c5dfb>] class_device_del+0x42/0x112
[1198358881 808580]  [<c01c5ed3>] class_device_unregister+0x8/0x10
[1198358881 808630]  [<c01d378d>] __scsi_remove_device+0x23/0x60
[1198358881 808687]  [<c01d37e1>] scsi_remove_device+0x17/0x20
[1198358881 808735]  [<c01e6a9f>] ata_scsi_hotplug+0xd1/0x148
[1198358881 808785]  [<c011c944>] run_workqueue+0x63/0x92
[1198358881 808840]  [<c01e69ce>] ata_scsi_hotplug+0x0/0x148
[1198358881 808887]  [<c011cacd>] worker_thread+0xe8/0x118
[1198358881 808935]  [<c010e95c>] default_wake_function+0x0/0xc
[1198358881 809001]  [<c011c9e5>] worker_thread+0x0/0x118
[1198358881 809047]  [<c011edc6>] kthread+0xac/0xda
[1198358881 809100]  [<c011ed1a>] kthread+0x0/0xda
[1198358881 809145]  [<c0100aad>] kernel_thread_helper+0x5/0xb
[1198358881 809192] Code: d6 5b 5e c3 89 c8 c3 89 50 4c 89 48 50 50 a1
9c 7e 31 c0 68 6b 40 14 c0 68 ee 3e 14 c0 6a 00 e8 ab 2e 08 00 83 c4
10 c3 53 89 c3 <8b> 48 50 8b 50 4c a1 9c 7e 31 c0 e8 6f 2d 08 00 89 d8
5b e9 8d
[1198358881 809468] EIP: [<c0143f15>] cdev_del+0x3/0x1b SS:ESP 0068:c3ee7edc
[1198358881 809727]  <6>ata1 port frozen
[1198358910 954625] ata1: exception Emask 0x10 SAct 0x0 SErr 0x0
action 0x2 frozen
[1198358910 954716] ata1: (irq_stat 0x00b40090, PHY RDY changed)
[1198358910 954790] ata1 port frozen
[1198358910 954851] ata1: hard resetting port
[1198358914 694404] ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[1198358914 694498] ata1 port thawed
[1198358914 696092] ata1.00: ATA-7, max UDMA/133, 312581808 sectors:
LBA48 NCQ (depth 31/32)
[1198358914 697744] ata1.00: configured for UDMA/100
[1198358914 697832] ata1: EH complete

~ $ cat /proc/cpuinfo
processor       : 0
vendor_id       : GenuineIntel
cpu family      : 6
model           : 8
model name      : Celeron (Coppermine)
stepping        : 10
cpu MHz         : 735.010
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 2
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca
cmov pat pse36 mmx fxsr sse
bogomips        : 1470.95

~ $ cat /sys/class/scsi_host/host0/proc_name
sata_sil24
