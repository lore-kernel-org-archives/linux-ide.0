From: "Jon Chelton" <jchelton@ffpglobal.com>
Subject: RE: sata_sil24 with port multiplier
Date: Thu, 27 Sep 2007 17:01:33 -0400
Message-ID: <FD6311B7ED175B4480F31633F6098B4D911D02@ffpglobal_mail.corp.ffplus.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from 66-189-16-56.static.oxfr.ma.charter.com ([66.189.16.56]:12724
	"EHLO mail.ffpglobal.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753221AbXI0VAg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Sep 2007 17:00:36 -0400
content-class: urn:content-classes:message
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <htejun@gmail.com>
Cc: linux-ide@vger.kernel.org

After applying the patches you sent, I had not received any additional
errors until today.  Below is an output from dmesg.

Thanks for your help,
Jon

ata1.15: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: irq_stat 0x00020002, PMP DMA CS errata
ata1.00: exception Emask 0x100 SAct 0x18084200 SErr 0x0 action 0x6
frozen
ata1.00: cmd 60/00:48:3f:8f:fa/01:00:0a:00:00/40 tag 9 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.00: cmd 60/00:70:3f:90:fa/01:00:0a:00:00/40 tag 14 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.00: cmd 60/98:98:3f:91:fa/00:00:0a:00:00/40 tag 19 cdb 0x0 data
77824 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.00: cmd 60/a8:d8:97:8e:fa/00:00:0a:00:00/40 tag 27 cdb 0x0 data
86016 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.00: cmd 60/68:e0:d7:91:fa/00:00:0a:00:00/40 tag 28 cdb 0x0 data
53248 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: exception Emask 0x100 SAct 0x26108402 SErr 0x0 action 0x6
frozen
ata1.01: cmd 60/a0:08:9f:8e:fa/00:00:0a:00:00/40 tag 1 cdb 0x0 data
81920 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/00:50:3f:8f:fa/01:00:0a:00:00/40 tag 10 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/00:78:3f:90:fa/01:00:0a:00:00/40 tag 15 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/68:a0:d7:8d:fa/00:00:0a:00:00/40 tag 20 cdb 0x0 data
53248 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/18:c8:87:8e:fa/00:00:0a:00:00/40 tag 25 cdb 0x0 data
12288 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/48:d0:3f:8e:fa/00:00:0a:00:00/40 tag 26 cdb 0x0 data
36864 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.01: cmd 60/00:e8:3f:91:fa/01:00:0a:00:00/40 tag 29 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x100 (unknown
error)
ata1.02: exception Emask 0x10 SAct 0x40600989 SErr 0x0 action 0x6 frozen
ata1.02: irq_stat 0x00020002, failed to transmit command FIS
ata1.02: cmd 60/10:00:8f:8e:fa/00:00:0a:00:00/40 tag 0 cdb 0x0 data 8192
in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/f8:18:3f:91:fa/00:00:0a:00:00/40 tag 3 cdb 0x0 data
126976 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/a0:38:9f:8e:fa/00:00:0a:00:00/40 tag 7 cdb 0x0 data
81920 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/08:40:37:92:fa/00:00:0a:00:00/40 tag 8 cdb 0x0 data 4096
in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/00:58:3f:8f:fa/01:00:0a:00:00/40 tag 11 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/68:a8:d7:8d:fa/00:00:0a:00:00/40 tag 21 cdb 0x0 data
53248 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/00:b0:3f:90:fa/01:00:0a:00:00/40 tag 22 cdb 0x0 data
131072 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.02: cmd 60/50:f0:3f:8e:fa/00:00:0a:00:00/40 tag 30 cdb 0x0 data
40960 in
         res 50/00:3c:3f:ff:67/00:00:00:00:00/40 Emask 0x10 (ATA bus
error)
ata1.03: exception Emask 0x0 SAct 0x3064 SErr 0x0 action 0x2 frozen
ata1.04: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.05: exception Emask 0x100 SAct 0x0 SErr 0x0 action 0x6 frozen
ata1.15: hard resetting link
ata1: controller in dubious state, performing PORT_RST
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.00: hard resetting link
ata1.00: softreset failed (SRST command error)
ata1.00: reset failed (errno=-5), retrying in 10 secs
ata1.00: hard resetting link
ata1.00: hardreset failed (port not ready)
ata1.00: reset failed (errno=-5), retrying in 10 secs
ata1.00: hard resetting link
ata1.00: hardreset failed (port not ready)
ata1.00: reset failed (errno=-5), retrying in 35 secs
ata1.00: limiting SATA link speed to 1.5 Gbps
ata1.00: hard resetting link
ata1.00: hardreset failed (port not ready)
ata1.00: reset failed, giving up
ata1.15: hard resetting link
ata1: controller in dubious state, performing PORT_RST
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.00: hard resetting link
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.01: hard resetting link
ata1.01: SATA link up 3.0 Gbps (SStatus 123 SControl 0)
ata1.02: hard resetting link
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: hard resetting link
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.04: hard resetting link
ata1.04: SATA link down (SStatus 0 SControl 300)
ata1.05: hard resetting link
ata1.05: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: configured for UDMA/100
ata1.01: configured for UDMA/100
ata1.02: configured for UDMA/100
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
ata1.03: exception Emask 0x0 SAct 0x3e0001f SErr 0x400000 action 0x2
ata1.03: irq_stat 0x00020002, device error via SDB FIS
ata1.03: cmd 61/d8:a8:3f:8c:fa/00:00:0a:00:00/40 tag 21 cdb 0x0 data
110592 out
         res 41/84:78:9f:8c:fa/60:00:0a:00:00/40 Emask 0x410 (ATA bus
error) <F>
ata1.03: hard resetting link
ata1.03: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
ata1.03: configured for UDMA/100
ata1: EH complete
sd 0:0:0:0: [sda] 976773168 512-byte hardware sectors (500108 MB)
sd 0:0:0:0: [sda] Write Protect is off
sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:1:0:0: [sdb] 976773168 512-byte hardware sectors (500108 MB)
sd 0:1:0:0: [sdb] Write Protect is off
sd 0:1:0:0: [sdb] Mode Sense: 00 3a 00 00
sd 0:1:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:2:0:0: [sdc] 976773168 512-byte hardware sectors (500108 MB)
sd 0:2:0:0: [sdc] Write Protect is off
sd 0:2:0:0: [sdc] Mode Sense: 00 3a 00 00
sd 0:2:0:0: [sdc] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 0:3:0:0: [sdd] 976773168 512-byte hardware sectors (500108 MB)
sd 0:3:0:0: [sdd] Write Protect is off
sd 0:3:0:0: [sdd] Mode Sense: 00 3a 00 00
sd 0:3:0:0: [sdd] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

-----Original Message-----
From: Tejun Heo [mailto:htejun@gmail.com] 
Sent: Saturday, September 22, 2007 8:36 PM
To: Jon Chelton
Cc: linux-ide@vger.kernel.org
Subject: Re: sata_sil24 with port multiplier

Please apply without the previous patch.  Also, this is the correct
version.

-- 
tejun

