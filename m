From: Wolfgang Denk <wd@denx.de>
Subject: Support for Promise SATA300 TX2plus ?
Date: Sun, 03 Dec 2006 01:03:45 +0100
Message-ID: <20061203000345.C9D30352621@atlas.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.9]:28051 "EHLO
	mail-out.m-online.net") by vger.kernel.org with ESMTP
	id S1424844AbWLCADs (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 2 Dec 2006 19:03:48 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Dear Jeff,

I'm trying to get a Promise SATA300 TX2plus  working  on  a  PPC  box
running a more or less vanilla 2.6.19 kernel. 

bash-3.00# lspci -vx
00:0c.0 Class 0180: 105a:3d73 (rev 02)
        Subsystem: 105a:3d73
        Flags: bus master, 66Mhz, medium devsel, latency 128, IRQ 25
        I/O ports at ff80 [size=128]
        I/O ports at fe00 [size=256]
        Memory at 00000000affff000 (32-bit, non-prefetchable) [size=4K]
        Memory at 00000000affc0000 (32-bit, non-prefetchable) [size=128K]
        Expansion ROM at 0000000000080000 [disabled] [size=32K]
        Capabilities: [60] Power Management version 2
00: 5a 10 73 3d 07 00 30 02 02 00 80 01 00 80 00 00
10: 81 ff 00 00 00 00 00 00 01 fe 00 00 00 f0 ff af
20: 00 00 fc af 00 00 00 00 00 00 00 00 5a 10 73 3d
30: 00 00 08 00 60 00 00 00 00 00 00 00 19 01 04 12

The SATA ports are working fine:

...
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
ata1: SATA max UDMA/133 cmd 0xD1062200 ctl 0xD1062238 bmdma 0x0 irq 25
ata2: SATA max UDMA/133 cmd 0xD1062280 ctl 0xD10622B8 bmdma 0x0 irq 25
scsi0 : sata_promise
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 490234752 sectors: LBA48 
ata1.00: ata1: dev 0 multi count 0
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link down (SStatus 0 SControl 300)
scsi 0:0:0:0: Direct-Access     ATA      Maxtor 7Y250M0   YAR5 PQ: 0 ANSI: 5
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
SCSI device sda: 490234752 512-byte hdwr sectors (251000 MB)
sda: Write Protect is off
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
...

but I cannot get access to a drive on the PATA port. 

What could/should I try?   Thanks in advance...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
And now remains  That we find out the cause of this effect, Or rather
say, the cause of this defect...           -- Hamlet, Act II, Scene 2
