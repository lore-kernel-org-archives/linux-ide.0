From: Marc MERLIN <marc@merlins.org>
Subject: sil24 PMP works with ST3500641AS but not HDS721010KLA330
Date: Tue, 2 Oct 2007 10:04:45 -0700
Message-ID: <20071002170445.GB2902@merlins.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from magic.merlins.org ([209.81.13.136]:49456 "EHLO
	mail1.merlins.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754957AbXJBRjN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Oct 2007 13:39:13 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: htejun@gmail.com, linux-ide@vger.kernel.org

Howdy,

I've had a system with 2.6.22.1 for a while, running 10 drives
behind a PMP on a sil24 card with no problems.

Recently, I swapped 5 250GB drives with 5 TB drives.
The 5 TB drives eventually get detected, but do not work reliably.

Details are below.

This is all on 2.6.22.1-libata-tj-20070803. 
I noticed that 20070808 is out, but it says it fixed NCQ over PMP,
and NCQ was working fine with my 500GB drives, so I'm not sure it's that.

I'll try upgrading, but I'm pasting my current info below in case there
are other things I should try

Thanks
Marc


At boot time, the good (500GB) drives give:
> ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata4.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
> ata4.00: hard resetting link
> ata4.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.01: hard resetting link
> ata4.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.02: hard resetting link
> ata4.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.03: hard resetting link
> ata4.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.04: hard resetting link
> ata4.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata4.05: hard resetting link
> ata4.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata4.00: ATA-7: ST3500641AS, 3.AAE, max UDMA/133
> ata4.00: 976773168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata4.00: configured for UDMA/100
> ata4.01: ATA-7: ST3500641AS, 3.AAE, max UDMA/133
> ata4.01: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.01: configured for UDMA/100
> ata4.02: ATA-7: ST3500641AS, 3.AAE, max UDMA/133
> ata4.02: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.02: configured for UDMA/100
> ata4.03: ATA-7: ST3500641AS, 3.AAD, max UDMA/133
> ata4.03: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.03: configured for UDMA/100
> ata4.04: ATA-7: ST3500641AS, 3.AAD, max UDMA/133
> ata4.04: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata4.04: configured for UDMA/100
> ata4: EH complete
> (...)
> PM: Adding info for No Bus:target4:0:0
> scsi 4:0:0:0: Direct-Access     ATA      ST3500641AS      3.AA PQ: 0 ANSI: 5
> PM: Adding info for scsi:4:0:0:0
> sd 4:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
> sd 4:0:0:0: [sdh] Write Protect is off
> sd 4:0:0:0: [sdh] Mode Sense: 00 3a 00 00
> sd 4:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 4:0:0:0: [sdh] 976773168 512-byte hardware sectors (500108 MB)
> sd 4:0:0:0: [sdh] Write Protect is off
> sd 4:0:0:0: [sdh] Mode Sense: 00 3a 00 00
> sd 4:0:0:0: [sdh] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdh: sdh1
> sd 4:0:0:0: [sdh] Attached SCSI disk

The new drives give:
> ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: softreset failed (timeout)
> ata3.01: hard resetting link
> ata3.01: COMRESET failed (errno=-5)
> ata3.01: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: softreset failed (timeout)
> ata3.02: hard resetting link
> ata3.02: COMRESET failed (errno=-5)
> ata3.02: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: softreset failed (timeout)
> ata3.03: hard resetting link
> ata3.03: COMRESET failed (errno=-5)
> ata3.03: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.04: hard resetting link
> ata3.04: softreset failed (timeout)
> ata3.04: hard resetting link
> ata3.04: COMRESET failed (errno=-5)
> ata3.04: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.04: hard resetting link
> ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.05: hard resetting link
> ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata3.00: 1953525168 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata3.00: configured for UDMA/100
> ata3.01: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata3.01: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata3.01: configured for UDMA/100
> ata3.02: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata3.02: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata3.02: configured for UDMA/100
> ata3.03: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata3.03: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata3.03: configured for UDMA/100
> ata3.04: ATA-7: Hitachi HDS721010KLA330, GKAOA70F, max UDMA/133
> ata3.04: 1953525168 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata3.04: configured for UDMA/100
> ata3: EH complete
> (...)
> PM: Adding info for No Bus:target3:0:0
> scsi 3:0:0:0: Direct-Access     ATA      Hitachi HDS72101 GKAO PQ: 0 ANSI: 5
> PM: Adding info for scsi:3:0:0:0
> sd 3:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 3:0:0:0: [sdc] Write Protect is off
> sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> sd 3:0:0:0: [sdc] 1953525168 512-byte hardware sectors (1000205 MB)
> sd 3:0:0:0: [sdc] Write Protect is off
> sd 3:0:0:0: [sdc] Mode Sense: 00 3a 00 00
> sd 3:0:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
>  sdc: sdc1
> sd 3:0:0:0: [sdc] Attached SCSI dis


While building the RAID array, I got a couple of these, although the array
did sync overnight.
> ata3.00: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata3.01: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata3.02: exception Emask 0x100 SAct 0x400 SErr 0x0 action 0x6 frozen
> ata3.02: cmd 60/28:50:3f:91:85/00:00:0a:00:00/40 tag 10 cdb 0x0 data 20480 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: exception Emask 0x100 SAct 0x58228004 SErr 0x0 action 0x6 frozen
> ata3.03: cmd 60/08:10:57:8f:85/00:00:0a:00:00/40 tag 2 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/28:78:3f:91:85/00:00:0a:00:00/40 tag 15 cdb 0x0 data 20480 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/a8:88:3f:8e:85/00:00:0a:00:00/40 tag 17 cdb 0x0 data 86016 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/58:a8:e7:8e:85/00:00:0a:00:00/40 tag 21 cdb 0x0 data 45056 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/18:d8:3f:8f:85/00:00:0a:00:00/40 tag 27 cdb 0x0 data 12288 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/00:e0:3f:90:85/01:00:0a:00:00/40 tag 28 cdb 0x0 data 131072 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/e0:f0:5f:8f:85/00:00:0a:00:00/40 tag 30 cdb 0x0 data 114688 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: exception Emask 0x100 SAct 0x139 SErr 0x0 action 0x6 frozen
> ata3.04: cmd 61/00:00:3f:8d:85/01:00:0a:00:00/40 tag 0 cdb 0x0 data 131072 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: cmd 61/98:18:3f:8c:85/00:00:0a:00:00/40 tag 3 cdb 0x0 data 77824 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: cmd 61/68:20:d7:8c:85/00:00:0a:00:00/40 tag 4 cdb 0x0 data 53248 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: cmd 61/d0:28:3f:8b:85/00:00:0a:00:00/40 tag 5 cdb 0x0 data 106496 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: cmd 61/30:40:0f:8c:85/00:00:0a:00:00/40 tag 8 cdb 0x0 data 24576 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.04: hard resetting link
> ata3.04: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.05: hard resetting link
> ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: configured for UDMA/100
> ata3.01: configured for UDMA/100
> ata3.02: configured for UDMA/100
> ata3.03: configured for UDMA/100
> ata3.04: configured for UDMA/100
> ata3: EH complete
(...)

Eventually, the array went down when I mkfsed it:
> ata3.00: exception Emask 0x100 SAct 0xfdf57e SErr 0x0 action 0x6 frozen
> ata3.00: cmd 61/08:08:e7:02:c6/00:00:03:00:00/40 tag 1 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:10:bf:02:c6/00:00:03:00:00/40 tag 2 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:18:c7:02:c6/00:00:03:00:00/40 tag 3 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:20:3f:03:c6/00:00:03:00:00/40 tag 4 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:28:df:02:c6/00:00:03:00:00/40 tag 5 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:30:47:03:c6/00:00:03:00:00/40 tag 6 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/90:40:d7:01:c6/00:00:03:00:00/40 tag 8 cdb 0x0 data 73728 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/30:50:67:02:c6/00:00:03:00:00/40 tag 10 cdb 0x0 data 24576 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/18:60:97:02:c6/00:00:03:00:00/40 tag 12 cdb 0x0 data 12288 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:68:af:02:c6/00:00:03:00:00/40 tag 13 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:70:b7:02:c6/00:00:03:00:00/40 tag 14 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/10:78:cf:02:c6/00:00:03:00:00/40 tag 15 cdb 0x0 data 8192 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/50:80:ef:02:c6/00:00:03:00:00/40 tag 16 cdb 0x0 data 40960 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:90:4f:03:c6/00:00:03:00:00/40 tag 18 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:98:57:03:c6/00:00:03:00:00/40 tag 19 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:a0:5f:03:c6/00:00:03:00:00/40 tag 20 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:a8:67:03:c6/00:00:03:00:00/40 tag 21 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:b0:6f:03:c6/00:00:03:00:00/40 tag 22 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.00: cmd 61/08:b8:77:03:c6/00:00:03:00:00/40 tag 23 cdb 0x0 data 4096 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.01: exception Emask 0x100 SAct 0x800 SErr 0x0 action 0x6 frozen
> ata3.01: cmd 60/08:58:4f:00:c6/00:00:03:00:00/40 tag 11 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.02: exception Emask 0x100 SAct 0x1 SErr 0x0 action 0x6 frozen
> ata3.02: cmd 60/08:00:4f:00:c6/00:00:03:00:00/40 tag 0 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: exception Emask 0x100 SAct 0x1020200 SErr 0x0 action 0x6 frozen
> ata3.03: cmd 60/10:48:3f:08:c5/00:00:03:00:00/40 tag 9 cdb 0x0 data 8192 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 61/30:88:f7:02:c5/00:00:03:00:00/40 tag 17 cdb 0x0 data 24576 out
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.03: cmd 60/08:c0:4f:00:c6/00:00:03:00:00/40 tag 24 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.04: exception Emask 0x100 SAct 0x80 SErr 0x0 action 0x6 frozen
> ata3.04: cmd 60/08:38:4f:00:c6/00:00:03:00:00/40 tag 7 cdb 0x0 data 4096 in
>          res 40/00:00:00:00:00/00:00:00:00:00/00 Emask 0x4 (timeout)
> ata3.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: softreset failed (timeout)
> ata3.01: hard resetting link
> ata3.01: COMRESET failed (errno=-5)
> ata3.01: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: softreset failed (timeout)
> ata3.01: hard resetting link
> ata3.01: COMRESET failed (errno=-5)
> ata3.01: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.01: hard resetting link
> ata3.01: softreset failed (timeout)
> ata3.01: hard resetting link
> ata3.01: COMRESET failed (errno=-5)
> ata3.01: reset failed, giving up
> ata3.01: failed to recover link after 3 tries, disabling
> ata3.01: disabled
> ata3: failed to recover PMP, retrying in 5 secs
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: softreset failed (timeout)
> ata3.02: hard resetting link
> ata3.02: COMRESET failed (errno=-5)
> ata3.02: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: softreset failed (timeout)
> ata3.02: hard resetting link
> ata3.02: COMRESET failed (errno=-5)
> ata3.02: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.02: hard resetting link
> ata3.02: softreset failed (timeout)
> ata3.02: hard resetting link
> ata3.02: COMRESET failed (errno=-5)
> ata3.02: reset failed, giving up
> ata3.02: failed to recover link after 3 tries, disabling
> ata3.02: disabled
> ata3: failed to recover PMP, retrying in 5 secs
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: softreset failed (timeout)
> ata3.03: hard resetting link
> ata3.03: COMRESET failed (errno=-5)
> ata3.03: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: softreset failed (timeout)
> ata3.03: hard resetting link
> ata3.03: COMRESET failed (errno=-5)
> ata3.03: reset failed, giving up
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.03: hard resetting link
> ata3.03: softreset failed (timeout)
> ata3.03: hard resetting link
> ata3.03: COMRESET failed (errno=-5)
> ata3.03: reset failed, giving up
> ata3.03: failed to recover link after 3 tries, disabling
> ata3.03: disabled
> ata3: failed to recover PMP, retrying in 5 secs
> 
> ata3.15: hard resetting link
> ata3.15: softreset failed (timeout)
> ata3.15: hard resetting link
> ata3.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
> ata3.00: hard resetting link
> ata3.00: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata3.05: hard resetting link
> ata3.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata3.00: configured for UDMA/100
> ata3: EH pending after completion, repeating EH (cnt=4)
> sd 3:2:0:0: [sde] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
> sd 3:2:0:0: [sde] Sense Key : Aborted Command [current] [descriptor]
> Descriptor sense data with sense descriptors (in hex):
>         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
>         00 00 00 00 
> sd 3:2:0:0: [sde] Add. Sense: No additional sense information
> end_request: I/O error, dev sde, sector 63307855
> sd 3:2:0:0: rejecting I/O to offline device
> raid5: Disk failure on sde1, disabling device. Operation continuing on 4 devices
> sd 3:2:0:0: rejecting I/O to offline device
> sd 3:4:0:0: rejecting I/O to offline device
> raid5: Disk failure on sdg1, disabling device. Operation continuing on 3 devices
> sd 3:4:0:0: rejecting I/O to offline device
> sage repeated 29 times
> sd 3:3:0:0: rejecting I/O to offline device
> raid5: Disk failure on sdf1, disabling device. Operation continuing on 2 devices
> sd 3:3:0:0: rejecting I/O to offline device
> sage repeated 26 times
> sd 3:1:0:0: rejecting I/O to offline device
> raid5: Disk failure on sdd1, disabling device. Operation continuing on 1 devices
> sd 3:1:0:0: rejecting I/O to offline device
> sage repeated 12 times
> sd 3:2:0:0: rejecting I/O to offline device
> sage repeated 11 times
> sd 3:4:0:0: [sdg] Result: hostbyte=DID_OK driverbyte=DRIVER_SENSE,SUGGEST_OK
> sd 3:4:0:0: [sdg] Sense Key : Aborted Command [current] [descriptor]
> Descriptor sense data with sense descriptors (in hex):
>         72 0b 00 00 00 00 00 0c 00 0a 80 00 00 00 00 00 
>         00 00 00 00 
> sd 3:4:0:0: [sdg] Add. Sense: No additional sense information
> end_request: I/O error, dev sdg, sector 63307855
> raid5:md5: read error not correctable (sector 63307792 on sdg1).
> sd 3:4:0:0: rejecting I/O to offline device
-- 
"A mouse is a device used to point at the xterm you want to type in" - A.S.R.
Microsoft is to operating systems & security ....
                                      .... what McDonalds is to gourmet cooking
Home page: http://marc.merlins.org/  
