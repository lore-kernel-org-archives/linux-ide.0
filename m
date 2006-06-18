From: kadowaki@bunkai.com
Subject: PM works with SiI3124 + SiI3726
Date: Mon, 19 Jun 2006 03:48:47 +0900
Message-ID: <JY200606190348478.347899513@bunkai.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mbox-o00.iijmio.jp ([210.138.144.205]:28380 "EHLO
	mbox-o00.iijmio.jp") by vger.kernel.org with ESMTP id S932281AbWFRSs4
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 18 Jun 2006 14:48:56 -0400
Received: from [192.168.10.10] (fntchba011014.chba.fnt.ftth.ppp.infoweb.ne.jp [222.158.222.222])
	by mbox.iijmio-mail.jp (MMS-MR/mms-r00) id k5IImrRt018726
	for <linux-ide@vger.kernel.org>; Mon, 19 Jun 2006 03:48:53 +0900 (JST)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I tried to use PM function with the RAIDON ST6600-5S-S2 drives cage, 
which has SiI3726 PM chip.

I did never succeed with 2.6.16.16 + libata-tj-2.6.16.16-20060512 patch.
At that point, dmesg output is something like this.

$ dmesg | grep -A 100 libata
libata version 1.30 loaded.
sata_sil24 0000:03:03.0: version 0.24
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 56 (level, low) -> IRQ 177
sata_sil24 0000:03:03.0: Applying completion IRQ loss on PCI-X errata 
fix
ata1: SATA max UDMA/100 cmd 0xF8D90000 ctl 0x0 bmdma 0x0 irq 177
ata2: SATA max UDMA/100 cmd 0xF8D92000 ctl 0x0 bmdma 0x0 irq 177
ata3: SATA max UDMA/100 cmd 0xF8D94000 ctl 0x0 bmdma 0x0 irq 177
ata4: SATA max UDMA/100 cmd 0xF8D96000 ctl 0x0 bmdma 0x0 irq 177
scsi0 : sata_sil24
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: SATA link down (SStatus 4 SControl 300)
ata1.02: SATA link down (SStatus 4 SControl 300)
ata1.03: SATA link down (SStatus 4 SControl 300)
ata1.04: SATA link down (SStatus 4 SControl 300)
ata1.05: softreset failed (SRST command error)
ata1.05: softreset failed, retrying in 5 secs
ata1.05: softreset failed (SRST command error)
ata1.05: reset failed, giving up
ata1.05: failed to recover link, resetting PM
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.05: softreset failed (SRST command error)
ata1.05: softreset failed, retrying in 5 secs
ata1.05: softreset failed (SRST command error)
ata1.05: reset failed, giving up
ata1.05: failed to recover link after 2 tries, giving up
ata1: failed to recover PM, retrying in 5 secs
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: SATA link down (SStatus 4 SControl 300)
ata1.02: SATA link down (SStatus 4 SControl 300)
ata1.03: SATA link down (SStatus 4 SControl 300)
ata1.04: SATA link down (SStatus 4 SControl 300)
ata1.00: cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:
007f
ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
scsi1 : sata_sil24
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_sil24
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 34.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda

Acutually, the 4 out of 5 drive trays are ocuppied by harddrives.
So, I read docs & patches carefully, added following 2 lines into the 
libata-pm.c .

        if (vendor == 0x1095 && devid == 0x3726) {
                *link_flags |= ATA_LFLAG_HRST_TO_RESUME;
        }

After doing this (& re-compile of course), I got it works.
summary of dmesg is ...

$ dmesg | grep -A 108 libata
libata version 1.30 loaded.
sata_sil24 0000:03:03.0: version 0.24
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 56 (level, low) -> IRQ 177
sata_sil24 0000:03:03.0: Applying completion IRQ loss on PCI-X errata 
fix
ata1: SATA max UDMA/100 cmd 0xF8D90000 ctl 0x0 bmdma 0x0 irq 177
ata2: SATA max UDMA/100 cmd 0xF8D92000 ctl 0x0 bmdma 0x0 irq 177
ata3: SATA max UDMA/100 cmd 0xF8D94000 ctl 0x0 bmdma 0x0 irq 177
ata4: SATA max UDMA/100 cmd 0xF8D96000 ctl 0x0 bmdma 0x0 irq 177
scsi0 : sata_sil24
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.15: Port Multiplier 1.1, 0x1095:0x3726 r23, 6 ports, feat 0x9/0x9
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: SATA link down (SStatus 0 SControl 300)
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.05: softreset failed (SRST command error)
ata1.05: follow-up softreset failed, retrying in 5 secs
ata1.05: softreset failed (SRST command error)
ata1.05: reset failed, giving up
ata1.05: failed to recover link, resetting PM
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.05: softreset failed (SRST command error)
ata1.05: follow-up softreset failed, retrying in 5 secs
ata1.05: softreset failed (SRST command error)
ata1.05: reset failed, giving up
ata1.05: failed to recover link after 2 tries, giving up
ata1: failed to recover PM, retrying in 5 secs
ata1.15: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.01: SATA link down (SStatus 0 SControl 300)
ata1.02: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.03: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.04: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: cfg 49:2f00 82:346b 83:7f21 84:4003 85:3469 86:3c01 87:4003 88:
007f
ata1.00: ATA-6, max UDMA/133, 72303840 sectors: LBA48
ata1.00: applying bridge limits
ata1.00: configured for UDMA/100
ata1.02: cfg 49:2f00 82:346b 83:7d01 84:5823 85:3469 86:3c01 87:4023 88:
207f
ata1.02: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata1.02: configured for UDMA/100
ata1.03: cfg 49:2f00 82:346b 83:7d01 84:5823 85:3469 86:3c01 87:4023 88:
207f
ata1.03: ATA-7, max UDMA/133, 488397168 sectors: LBA48 NCQ (depth 31/32)
ata1.03: configured for UDMA/100
ata1.04: cfg 49:2f00 82:7c6b 83:7f09 84:4063 85:7c69 86:3e01 87:4063 88:
007f
ata1.04: ATA-7, max UDMA/133, 490234752 sectors: LBA48 NCQ (depth 31/32)
ata1.04: configured for UDMA/100
scsi1 : sata_sil24
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : sata_sil24
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : sata_sil24
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: WDC WD360GD-00FN  Rev: 34.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 72303840 512-byte hdwr sectors (37020 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 >
sd 0:0:0:0: Attached scsi disk sda
  Vendor: ATA       Model: ST3250824NS       Rev: 3.AE
  Type:   Direct-Access                      ANSI SCSI revision: 05
sd 0:0:0:0: Attached scsi generic sg0 type 0
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 0:0:2:0: Attached scsi disk sdb
sd 0:0:2:0: Attached scsi generic sg1 type 0
  Vendor: ATA       Model: ST3250824NS       Rev: 3.AE
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 488397168 512-byte hdwr sectors (250059 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
sd 0:0:3:0: Attached scsi disk sdc
sd 0:0:3:0: Attached scsi generic sg2 type 0
  Vendor: ATA       Model: Maxtor 7L250S0    Rev: BANC
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
SCSI device sdd: 490234752 512-byte hdwr sectors (251000 MB)
sdd: Write Protect is off
sdd: Mode Sense: 00 3a 00 00
SCSI device sdd: drive cache: write back
 sdd: sdd1
sd 0:0:4:0: Attached scsi disk sdd
sd 0:0:4:0: Attached scsi generic sg3 type 0


Thank you.
