From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: ICH10R and Samsung HDS724040KLSA80
Date: Sun, 21 Dec 2008 18:08:36 -0600
Message-ID: <494EDA84.9000603@shaw.ca>
References: <b1dab3a10812211242q29515f80n54cd3b9d8b3edc34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:55489 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751437AbYLVAIu (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 21 Dec 2008 19:08:50 -0500
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LEYLk-0002t4-4G
	for linux-ide@vger.kernel.org; Mon, 22 Dec 2008 00:08:44 +0000
Received: from s0106000c41bb86e1.ss.shawcable.net ([70.76.47.20])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2008 00:08:44 +0000
Received: from hancockr by s0106000c41bb86e1.ss.shawcable.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Mon, 22 Dec 2008 00:08:44 +0000
In-Reply-To: <b1dab3a10812211242q29515f80n54cd3b9d8b3edc34@mail.gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

n37 wrote:
> I have a P5Q Deluxe motherboard which comes with ICH10R. One of my
> hard disks is a Samsung Deskstar 7K400 HDS724040KLSA80
> (http://www.hitachigst.com/hdd/support/7k400/7k400.htm). I have set
> ICH10R in AHCI mode in BIOS. It is almost impossible to get the hard
> disk to initialize properly. Here is the relevant portion of the
> kernel log:
> 
> ...
> ahci 0000:00:1f.2: version 3.0
> ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems
> ahci 0000:00:1f.2: setting latency timer to 64
> scsi0 : ahci
> scsi1 : ahci
> scsi2 : ahci
> scsi3 : ahci
> scsi4 : ahci
> scsi5 : ahci
> ata1: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffe900 irq 219
> ata2: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffe980 irq 219
> ata3: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffea00 irq 219
> ata4: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffea80 irq 219
> ata5: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffeb00 irq 219
> ata6: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffeb80 irq 219
> Switched to high resolution mode on CPU 1
> Switched to high resolution mode on CPU 0
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7: SAMSUNG HD400LJ, ZZ100-15, max UDMA7
> ata1.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: qc timeout (cmd 0x27)
> ata2.00: failed to read native max address (err_mask=0x4)
> ata2.00: HPA support seems broken, skipping HPA handling
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: qc timeout (cmd 0xef)
> ata2.00: failed to set xfermode (err_mask=0x4)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2.00: limiting speed to UDMA/100:PIO3
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: qc timeout (cmd 0xef)
> ata2.00: failed to set xfermode (err_mask=0x4)
> ata2.00: disabled
> ata2: hard resetting link
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2: EH complete
> ata3: SATA link down (SStatus 0 SControl 300)
> ata4: SATA link down (SStatus 0 SControl 300)
> ata5: SATA link down (SStatus 0 SControl 300)
> ata6: SATA link down (SStatus 0 SControl 300)
> scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD400LJ  ZZ10 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
>  sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> ...
> 
> Consequently there is no device node created. On some extremely rare
> occasions these errors will not show up and the disk will be usable
> but these are few and far between.
> Here is a log when this happens:
> 
> ...
> ahci 0000:00:1f.2: version 3.0
> ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
> ahci 0000:00:1f.2: AHCI 0001.0200 32 slots 6 ports 3 Gbps 0x3f impl SATA mode
> ahci 0000:00:1f.2: flags: 64bit ncq sntf stag pm led clo pmp pio slum part ems
> ahci 0000:00:1f.2: setting latency timer to 64
> scsi0 : ahci
> scsi1 : ahci
> scsi2 : ahci
> scsi3 : ahci
> scsi4 : ahci
> scsi5 : ahci
> ata1: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffe900 irq 219
> ata2: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffe980 irq 219
> ata3: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffea00 irq 219
> ata4: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffea80 irq 219
> ata5: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffeb00 irq 219
> ata6: SATA max UDMA/133 abar m2048@0xfbffe800 port 0xfbffeb80 irq 219
> ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
> ata1.00: ATA-7: SAMSUNG HD400LJ, ZZ100-15, max UDMA7
> ata1.00: 781422768 sectors, multi 16: LBA48 NCQ (depth 31/32)
> ata1.00: configured for UDMA/133
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: qc timeout (cmd 0x27)
> ata2.00: failed to read native max address (err_mask=0x4)
> ata2.00: HPA support seems broken, skipping HPA handling
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
> ata2.00: qc timeout (cmd 0xef)
> ata2.00: failed to set xfermode (err_mask=0x4)
> ata2: limiting SATA link speed to 1.5 Gbps
> ata2.00: limiting speed to UDMA/100:PIO3
> ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
> ata2.00: configured for UDMA/100
> ata3: SATA link down (SStatus 0 SControl 300)
> ata4: SATA link down (SStatus 0 SControl 300)
> ata5: SATA link down (SStatus 0 SControl 300)
> ata6: SATA link down (SStatus 0 SControl 300)
> scsi 0:0:0:0: Direct-Access     ATA      SAMSUNG HD400LJ  ZZ10 PQ: 0 ANSI: 5
> sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 0:0:0:0: [sda] 781422768 512-byte hardware sectors (400088 MB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
> sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sda: sda1 sda2 sda3 sda4 < sda5 sda6 sda7 sda8 >
> sd 0:0:0:0: [sda] Attached SCSI disk
> scsi 1:0:0:0: Direct-Access     ATA      HDS724040KLSA80  KFAO PQ: 0 ANSI: 5
> sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sd 1:0:0:0: [sdb] 781422768 512-byte hardware sectors (400088 MB)
> sd 1:0:0:0: [sdb] Write Protect is off
> t-rex sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
> support DPO or FUA
> sdb: sdb1 sdb2 sdb4 < sdb5 sdb6 >
> sd 1:0:0:0: [sdb] Attached SCSI disk
> ...
> 
> After some googling I found something that might be relevant:
> http://www.mail-archive.com/linux-ide@vger.kernel.org/msg09294.html.
> However I am running 2.6.27.10 and afaict this patch is included.

Obviously HPA processing is not being skipped in your case. The existing 
blacklist entry only covers HDS724040KLSA80 with firmware KFAOA20N. Your 
drive might be a different firmware version (it's not possible to tell 
from this log as the SCSI message only shows the first 4 characters of 
the firmware). Can you can tell what the firmware version is (hdparm -I 
on the drive, I believe, if you can get it to be recognized)?

