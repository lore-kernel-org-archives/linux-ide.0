From: "Zivago Lee" <z@ziff.net>
Subject: sata_nv or port issue?
Date: Wed, 25 Jul 2007 12:39:20 -0700 (PDT)
Message-ID: <27003.209.104.55.7.1185392360.squirrel@mail.ziff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ziff.net ([66.240.186.42]:53456 "EHLO mail.ziff.net"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750794AbXGYUOb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 25 Jul 2007 16:14:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I just got a MSI P6N SLI board with the MCP51 chipset.  It uses the
sata_nv driver for the SATA drives.

I've been running into a couple of issues and I was wondering where I
might start to debug this.  I'm running 4 SATA drives on raid10.  For some
reason, the last 2 SATA ports just "die" and then I'm left with 2 drives
in the raid10 config.  To get the ports back to working state, I have to
reboot.

I've run badblocks on the drives and even replaced them with new drives as
well.  I've run into this issue twice and it's not like it happens all the
time.  Most of my components are pretty new as I just built this system
about 3 weeks ago.

Since both drives passed the badblocks test, I've just re-added them to
the raid10 pool and let mdraid get them in sync.  So far, no issues for
the past 3 days but I'm curious to see what the issue might be.

Here is the snippet of dmesg when the drives died:

--

Jul 22 17:59:33 miyagip -- MARK --
Jul 22 18:19:33 miyagip -- MARK --
Jul 22 18:35:56 miyagip kernel: [ 3424.673318] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1
Jul 22 18:37:49 miyagip kernel: [ 3424.677271] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2
Jul 22 18:37:49 miyagip kernel: [ 3424.729908] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 3
Jul 22 18:37:49 miyagip kernel: [ 3424.730802] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 4
Jul 22 18:37:49 miyagip kernel: [ 3424.742037] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 5
Jul 22 18:37:49 miyagip kernel: [ 3424.743906] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 6
Jul 22 18:37:49 miyagip kernel: [ 3424.746417] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 7
Jul 22 18:37:49 miyagip kernel: [ 3424.746435] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 8
Jul 22 18:37:49 miyagip kernel: [ 3424.746452] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 9
Jul 22 18:37:49 miyagip kernel: [ 3424.750468] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 10
Jul 22 18:37:49 miyagip kernel: [ 3429.714695] printk: 317 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3429.714701] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 328
Jul 22 18:37:49 miyagip kernel: [ 3434.687418] printk: 233 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3434.687423] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 562
Jul 22 18:37:49 miyagip kernel: [ 3435.076810]          res
40/00:00:06:4f:c2/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 22 18:37:49 miyagip kernel: [ 3435.076822]          res
40/00:00:0b:03:b7/00:00:00:00:00/00 Emask 0x4 (timeout)
Jul 22 18:37:49 miyagip kernel: [ 3435.392212] ata4: soft resetting port
Jul 22 18:37:49 miyagip kernel: [ 3435.392215] ata3: soft resetting port
Jul 22 18:37:49 miyagip kernel: [ 3435.545907] ata3: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3435.545911] ata4: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3439.699135] printk: 221 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3439.699140] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 784
Jul 22 18:37:49 miyagip kernel: [ 3444.690756] printk: 187 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3444.690761] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 972
Jul 22 18:37:49 miyagip kernel: [ 3449.697001] printk: 178 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3449.697006] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1151
Jul 22 18:37:49 miyagip kernel: [ 3454.727243] printk: 165 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3454.727248] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1317
Jul 22 18:37:49 miyagip kernel: [ 3459.679191] printk: 136 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3459.679196] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1454
Jul 22 18:37:49 miyagip kernel: [ 3464.694419] printk: 119 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3464.694423] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1574
Jul 22 18:37:49 miyagip kernel: [ 3465.555119] ata3.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3465.555145] ata4.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3465.555150] ata3.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3465.555154] ata4.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3465.555170] ata4: failed to recover
some devices, retrying in 5 secs
Jul 22 18:37:49 miyagip kernel: [ 3465.555174] ata3: failed to recover
some devices, retrying in 5 secs
Jul 22 18:37:49 miyagip kernel: [ 3469.672637] printk: 140 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3469.672642] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1715
Jul 22 18:37:49 miyagip kernel: [ 3470.556076] ata3: hard resetting port
Jul 22 18:37:49 miyagip kernel: [ 3470.556080] ata4: hard resetting port
Jul 22 18:37:49 miyagip kernel: [ 3471.190764] ata3: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3471.190769] ata4: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3474.786658] printk: 135 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3474.786663] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1851
Jul 22 18:37:49 miyagip kernel: [ 3479.719042] printk: 84 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3479.719047] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 1936
Jul 22 18:37:49 miyagip kernel: [ 3484.677147] printk: 86 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3484.677152] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2023
Jul 22 18:37:49 miyagip kernel: [ 3489.771018] printk: 68 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3489.771023] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2092
Jul 22 18:37:49 miyagip kernel: [ 3494.674632] printk: 77 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3494.674637] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2170
Jul 22 18:37:49 miyagip kernel: [ 3499.741894] printk: 58 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3499.741908] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2229
Jul 22 18:37:49 miyagip kernel: [ 3501.197026] ata3.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3501.197052] ata4.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3501.197056] ata3.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3501.197059] ata4.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3501.197076] ata3.00: limiting speed to
UDMA/133:PIO3
Jul 22 18:37:49 miyagip kernel: [ 3501.197079] ata4.00: limiting speed to
UDMA/133:PIO3
Jul 22 18:37:49 miyagip kernel: [ 3501.197082] ata4: failed to recover
some devices, retrying in 5 secs
Jul 22 18:37:49 miyagip kernel: [ 3501.197085] ata3: failed to recover
some devices, retrying in 5 secs
Jul 22 18:37:49 miyagip kernel: [ 3504.697953] printk: 56 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3504.697959] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2286
Jul 22 18:37:49 miyagip kernel: [ 3506.201357] ata3: hard resetting port
Jul 22 18:37:49 miyagip kernel: [ 3506.201361] ata4: hard resetting port
Jul 22 18:37:49 miyagip kernel: [ 3506.832012] ata3: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3506.832016] ata4: SATA link up 3.0 Gbps
(SStatus 123 SControl 300)
Jul 22 18:37:49 miyagip kernel: [ 3509.846085] printk: 52 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3509.846089] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2339
Jul 22 18:37:49 miyagip kernel: [ 3514.822879] printk: 52 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3514.822884] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2392
Jul 22 18:37:49 miyagip kernel: [ 3519.691755] printk: 73 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3519.691760] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2466
Jul 22 18:37:49 miyagip kernel: [ 3524.736197] printk: 47 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3524.736202] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2514
Jul 22 18:37:49 miyagip kernel: [ 3529.857067] printk: 46 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3529.857071] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2561
Jul 22 18:37:49 miyagip kernel: [ 3534.735891] printk: 55 messages
suppressed.
Jul 22 18:37:49 miyagip kernel: [ 3534.735896] nf_queue: full at 1024
entries, dropping packets(s). Dropped: 2617
Jul 22 18:37:49 miyagip kernel: [ 3536.839579] ata3.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3536.839605] ata4.00: qc timeout (cmd 0x27)
Jul 22 18:37:49 miyagip kernel: [ 3536.839609] ata3.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3536.839614] ata4.00: ata_hpa_resize 1:
sectors = 976773168, hpa_sectors = 0
Jul 22 18:37:49 miyagip kernel: [ 3536.839629] ata3.00: disabled
Jul 22 18:37:49 miyagip kernel: [ 3536.839632] ata4.00: disabled
Jul 22 18:37:49 miyagip kernel: [ 3537.345018] ata4: EH complete
Jul 22 18:37:49 miyagip kernel: [ 3537.345022] ata3: EH complete
Jul 22 18:37:49 miyagip kernel: [ 3537.345038] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345042] end_request: I/O error, dev
sdc, sector 632440388
Jul 22 18:37:49 miyagip kernel: [ 3537.345050] ^IOperation continuing on 3
devices
Jul 22 18:37:49 miyagip kernel: [ 3537.345084] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345086] end_request: I/O error, dev
sdc, sector 32965132
Jul 22 18:37:49 miyagip kernel: [ 3537.345664] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345666] end_request: I/O error, dev
sdd, sector 33056572
Jul 22 18:37:49 miyagip kernel: [ 3537.345670] ^IOperation continuing on 2
devices
Jul 22 18:37:49 miyagip kernel: [ 3537.345689] md: super_written gets
error=-5, uptodate=0
Jul 22 18:37:49 miyagip kernel: [ 3537.345692] ^IOperation continuing on 3
devices
Jul 22 18:37:49 miyagip kernel: [ 3537.345709] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345710] end_request: I/O error, dev
sdd, sector 32965132
Jul 22 18:37:49 miyagip kernel: [ 3537.345716] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345718] end_request: I/O error, dev
sdc, sector 635528964
Jul 22 18:37:49 miyagip kernel: [ 3537.345725] md: super_written gets
error=-5, uptodate=0
Jul 22 18:37:49 miyagip kernel: [ 3537.345728] ^IOperation continuing on 2
devices
Jul 22 18:37:49 miyagip kernel: [ 3537.345742] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345744] end_request: I/O error, dev
sdc, sector 635790340
Jul 22 18:37:49 miyagip kernel: [ 3537.345844] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345846] end_request: I/O error, dev
sdd, sector 493661172
Jul 22 18:37:49 miyagip kernel: [ 3537.345858] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345860] end_request: I/O error, dev
sdc, sector 822363692
Jul 22 18:37:49 miyagip kernel: [ 3537.345878] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345880] end_request: I/O error, dev
sdd, sector 632927900
Jul 22 18:37:49 miyagip kernel: [ 3537.345886] sd 2:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345888] end_request: I/O error, dev
sdc, sector 18952060
Jul 22 18:37:49 miyagip kernel: [ 3537.345896] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345898] end_request: I/O error, dev
sdd, sector 635790324
Jul 22 18:37:49 miyagip kernel: [ 3537.345989] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:37:49 miyagip kernel: [ 3537.345991] end_request: I/O error, dev
sdd, sector 976767876
Jul 22 18:37:49 miyagip kernel: [ 3537.345995] md: super_written gets
error=-5, uptodate=0
Jul 22 18:37:49 miyagip kernel: [ 3537.348177] sdc : READ CAPACITY failed.
Jul 22 18:37:49 miyagip kernel: [ 3537.348178] sdc : status=0, message=00,
host=4, driver=00
Jul 22 18:37:49 miyagip kernel: [ 3537.348179] sdc : sense not available.
Jul 22 18:37:49 miyagip kernel: [ 3537.348472] sdc: Write Protect is off
Jul 22 18:37:49 miyagip kernel: [ 3537.389913] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.389917]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.389919]  disk 0, wo:1, o:0, dev:sdc3
Jul 22 18:37:49 miyagip kernel: [ 3537.389921]  disk 1, wo:0, o:1, dev:sda3
Jul 22 18:37:49 miyagip kernel: [ 3537.389923]  disk 2, wo:0, o:1, dev:sdb3
Jul 22 18:37:49 miyagip kernel: [ 3537.389924]  disk 3, wo:1, o:0, dev:sdd3
Jul 22 18:37:49 miyagip kernel: [ 3537.405691] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.405695]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.405698]  disk 1, wo:0, o:1, dev:sda3
Jul 22 18:37:49 miyagip kernel: [ 3537.405700]  disk 2, wo:0, o:1, dev:sdb3
Jul 22 18:37:49 miyagip kernel: [ 3537.405703]  disk 3, wo:1, o:0, dev:sdd3
Jul 22 18:37:49 miyagip kernel: [ 3537.405710] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.405712]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.405714]  disk 1, wo:0, o:1, dev:sda3
Jul 22 18:37:49 miyagip kernel: [ 3537.405717]  disk 2, wo:0, o:1, dev:sdb3
Jul 22 18:37:49 miyagip kernel: [ 3537.405721]  disk 3, wo:1, o:0, dev:sdd3
Jul 22 18:37:49 miyagip kernel: [ 3537.410355] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.410357]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.410359]  disk 0, wo:1, o:0, dev:sdc4
Jul 22 18:37:49 miyagip kernel: [ 3537.410361]  disk 1, wo:0, o:1, dev:sda4
Jul 22 18:37:49 miyagip kernel: [ 3537.410364]  disk 2, wo:0, o:1, dev:sdb4
Jul 22 18:37:49 miyagip kernel: [ 3537.410366]  disk 3, wo:1, o:0, dev:sdd4
Jul 22 18:37:49 miyagip kernel: [ 3537.421893] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.421897]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.421899]  disk 1, wo:0, o:1, dev:sda3
Jul 22 18:37:49 miyagip kernel: [ 3537.421901]  disk 2, wo:0, o:1, dev:sdb3
Jul 22 18:37:49 miyagip kernel: [ 3537.429904] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.429909]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.429911]  disk 1, wo:0, o:1, dev:sda4
Jul 22 18:37:49 miyagip kernel: [ 3537.429913]  disk 2, wo:0, o:1, dev:sdb4
Jul 22 18:37:49 miyagip kernel: [ 3537.429914]  disk 3, wo:1, o:0, dev:sdd4
Jul 22 18:37:49 miyagip kernel: [ 3537.429919] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.429920]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.429921]  disk 1, wo:0, o:1, dev:sda4
Jul 22 18:37:49 miyagip kernel: [ 3537.429923]  disk 2, wo:0, o:1, dev:sdb4
Jul 22 18:37:49 miyagip kernel: [ 3537.429924]  disk 3, wo:1, o:0, dev:sdd4
Jul 22 18:37:49 miyagip kernel: [ 3537.462096] RAID10 conf printout:
Jul 22 18:37:49 miyagip kernel: [ 3537.462101]  --- wd:2 rd:4
Jul 22 18:37:49 miyagip kernel: [ 3537.462104]  disk 1, wo:0, o:1, dev:sda4
Jul 22 18:37:49 miyagip kernel: [ 3537.462107]  disk 2, wo:0, o:1, dev:sdb4
Jul 22 18:59:21 miyagip kernel: [ 4829.663929] md: super_written gets
error=-5, uptodate=0
Jul 22 18:59:21 miyagip kernel: [ 4829.663938] ^IOperation continuing on 3
devices
Jul 22 18:59:21 miyagip kernel: [ 4829.664108] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 18:59:21 miyagip kernel: [ 4829.664110] end_request: I/O error, dev
sdd, sector 2248909
Jul 22 18:59:21 miyagip kernel: [ 4829.664115] md: super_written gets
error=-5, uptodate=0
Jul 22 18:59:21 miyagip kernel: [ 4829.664118] ^IOperation continuing on 2
devices
Jul 22 18:59:21 miyagip kernel: [ 4829.687811] RAID10 conf printout:
Jul 22 18:59:21 miyagip kernel: [ 4829.687814]  --- wd:2 rd:4
Jul 22 18:59:21 miyagip kernel: [ 4829.687817]  disk 0, wo:1, o:0, dev:sdc2
Jul 22 18:59:21 miyagip kernel: [ 4829.687818]  disk 1, wo:0, o:1, dev:sda2
Jul 22 18:59:21 miyagip kernel: [ 4829.687820]  disk 2, wo:0, o:1, dev:sdb2
Jul 22 18:59:21 miyagip kernel: [ 4829.687821]  disk 3, wo:1, o:0, dev:sdd2
Jul 22 18:59:21 miyagip kernel: [ 4829.704594] RAID10 conf printout:
Jul 22 18:59:21 miyagip kernel: [ 4829.704599]  --- wd:2 rd:4
Jul 22 18:59:21 miyagip kernel: [ 4829.704602]  disk 1, wo:0, o:1, dev:sda2
Jul 22 18:59:21 miyagip kernel: [ 4829.704605]  disk 2, wo:0, o:1, dev:sdb2
Jul 22 18:59:21 miyagip kernel: [ 4829.704607]  disk 3, wo:1, o:0, dev:sdd2
Jul 22 18:59:21 miyagip kernel: [ 4829.704611] RAID10 conf printout:
Jul 22 18:59:21 miyagip kernel: [ 4829.704613]  --- wd:2 rd:4
Jul 22 18:59:21 miyagip kernel: [ 4829.704615]  disk 1, wo:0, o:1, dev:sda2
Jul 22 18:59:21 miyagip kernel: [ 4829.704617]  disk 2, wo:0, o:1, dev:sdb2
Jul 22 18:59:21 miyagip kernel: [ 4829.704619]  disk 3, wo:1, o:0, dev:sdd2
Jul 22 18:59:21 miyagip kernel: [ 4829.728881] RAID10 conf printout:
Jul 22 18:59:21 miyagip kernel: [ 4829.728885]  --- wd:2 rd:4
Jul 22 18:59:21 miyagip kernel: [ 4829.728888]  disk 1, wo:0, o:1, dev:sda2
Jul 22 18:59:21 miyagip kernel: [ 4829.728890]  disk 2, wo:0, o:1, dev:sdb2
Jul 22 19:21:20 miyagip -- MARK --
Jul 22 19:41:20 miyagip -- MARK --
Jul 22 19:50:48 miyagip kernel: [ 7916.296618] printk: 28 messages
suppressed.
Jul 22 19:50:53 miyagip kernel: [ 7921.295956] printk: 1204216 messages
suppressed.
Jul 22 19:50:58 miyagip kernel: [ 7926.295050] printk: 1152746 messages
suppressed.
Jul 22 19:51:03 miyagip kernel: [ 7931.295050] printk: 1022482 messages
suppressed.
Jul 22 19:51:08 miyagip kernel: [ 7936.294957] printk: 858271 messages
suppressed.
Jul 22 19:51:13 miyagip kernel: [ 7941.294941] printk: 917223 messages
suppressed.
Jul 22 19:51:18 miyagip kernel: [ 7946.294883] printk: 896815 messages
suppressed.
Jul 22 19:51:23 miyagip kernel: [ 7951.294818] printk: 948414 messages
suppressed.
Jul 22 19:53:48 miyagip kernel: [ 8096.303285] md: unbind<sdc2>
Jul 22 19:53:48 miyagip kernel: [ 8096.303294] md: export_rdev(sdc2)
Jul 22 19:53:52 miyagip kernel: [ 8100.186485] md: unbind<sdd2>
Jul 22 19:53:52 miyagip kernel: [ 8100.186494] md: export_rdev(sdd2)
Jul 22 19:54:07 miyagip kernel: [ 8115.237339] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:07 miyagip kernel: [ 8115.237343] end_request: I/O error, dev
sdd, sector 2248909
Jul 22 19:54:07 miyagip kernel: [ 8115.237346] printk: 496136 messages
suppressed.
Jul 22 19:54:07 miyagip kernel: [ 8115.237386] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:07 miyagip kernel: [ 8115.237388] end_request: I/O error, dev
sdd, sector 2248909
Jul 22 19:54:07 miyagip kernel: [ 8115.237397] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:07 miyagip kernel: [ 8115.237400] end_request: I/O error, dev
sdd, sector 2248910
Jul 22 19:54:07 miyagip kernel: [ 8115.289161] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:07 miyagip kernel: [ 8115.289167] end_request: I/O error, dev
sdd, sector 2248909
Jul 22 19:54:07 miyagip kernel: [ 8115.289208] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:07 miyagip kernel: [ 8115.289211] end_request: I/O error, dev
sdd, sector 2248909
Jul 22 19:54:07 miyagip kernel: [ 8115.289218] md: disabled device sdd2,
could not read superblock.
Jul 22 19:54:07 miyagip kernel: [ 8115.289220] md: sdd2 has invalid sb,
not importing!
Jul 22 19:54:07 miyagip kernel: [ 8115.289224] md: md_import_device
returned -22
Jul 22 19:54:53 miyagip kernel: [ 8160.901205] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:53 miyagip kernel: [ 8160.901217] end_request: I/O error, dev
sdd, sector 0
Jul 22 19:54:53 miyagip kernel: [ 8160.901219] printk: 14 messages
suppressed.
Jul 22 19:54:53 miyagip kernel: [ 8160.901282] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:53 miyagip kernel: [ 8160.901285] end_request: I/O error, dev
sdd, sector 0
Jul 22 19:54:54 miyagip kernel: [ 8162.232018] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:54 miyagip kernel: [ 8162.232022] end_request: I/O error, dev
sdd, sector 0
Jul 22 19:54:54 miyagip kernel: [ 8162.232051] sd 3:0:0:0: SCSI error:
return code = 0x00040000
Jul 22 19:54:54 miyagip kernel: [ 8162.232053] end_request: I/O error, dev
sdd, sector 0

--

Dmesg output on boot:

[    3.906630] scsi1 : sata_nv
[    4.372841] ata2: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.399711] ata2.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    4.399716] ata2.00: ATA-7: WDC WD5000ABYS-01TNA0, 12.01C01, max UDMA/133
[    4.399719] ata2.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.410230] ata2.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    4.410234] ata2.00: configured for UDMA/133
[    4.410240] scsi2 : sata_nv
[    4.875921] ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    4.898161] ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    4.898164] ata3.00: ATA-7: WDC WD5000ABYS-01TNA0, 12.01C01, max UDMA/133
[    4.898166] ata3.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    4.909371] ata3.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    4.909375] ata3.00: configured for UDMA/133
[    4.910851] scsi3 : sata_nv
[    5.379182] ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.407141] ata4.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    5.407146] ata4.00: ATA-7: WDC WD5000ABYS-01TNA0, 12.01C01, max UDMA/133
[    5.407149] ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.415972] ata4.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    5.415976] ata4.00: configured for UDMA/133
[    5.415983] scsi4 : sata_nv
[    5.882341] ata5: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
[    5.899009] ata5.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    5.899013] ata5.00: ATA-7: WDC WD5000ABYS-01TNA0, 12.01C01, max UDMA/133
[    5.899016] ata5.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    5.907918] ata5.00: ata_hpa_resize 1: sectors = 976773168, hpa_sectors
= 976773168
[    5.907921] ata5.00: configured for UDMA/133
[    5.907987] scsi 3:0:0:0: Direct-Access     ATA      WDC WD5000ABYS-0
12.0 PQ: 0 ANSI: 5
[    5.908514] scsi 4:0:0:0: Direct-Access     ATA      WDC WD5000ABYS-0
12.0 PQ: 0 ANSI: 5

--

As you can see from the dmesg output, the drives are Western Digital 500GB
RE's.

I'm running Ubuntu Feisty on the 2.6.20 kernel (Linux miyagip
2.6.20-16-generic #2 SMP Thu Jun 7 20:19:32 UTC 2007 i686 GNU/Linux).

If anyone needs any more data, I'll try to provide them...

Thanks!
Zivago

-- 
Zivago Lee
z@ziff.net
