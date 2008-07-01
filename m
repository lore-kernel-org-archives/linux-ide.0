From: "Maximo Pech" <makzpj@gmail.com>
Subject: sata-via second IDE hard drive not detected until reboot
Date: Wed, 2 Jul 2008 00:02:25 +0200
Message-ID: <e70424ee0807011502t13c226e9i4b0483657da75bca@mail.gmail.com>
References: <e70424ee0807011500j155a45adl1639eea9d884de4d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:50266 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751988AbYGAWCZ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 1 Jul 2008 18:02:25 -0400
Received: by rv-out-0506.google.com with SMTP id k40so99880rvb.1
        for <linux-ide@vger.kernel.org>; Tue, 01 Jul 2008 15:02:25 -0700 (PDT)
In-Reply-To: <e70424ee0807011500j155a45adl1639eea9d884de4d@mail.gmail.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi, I've been using the sata-via module with linux 2.6.24.2 it works
ok, but there's something strange.

I'm using this sata controller (as showed by lspci):

04:01.0 RAID bus controller: VIA Technologies, Inc. VT6421 IDE RAID
Controller (rev 50)

I'm not using it's sata ports, just the ide one. There are 2 hard
drives attached to it. However one of them it's detected only after a
reboot. Turning off and on the computer doesn't work, it has to be a
reboot.

This is what dmesg says on first boot (excuse me if it's too long):

sata_via 0000:04:01.0: version 2.3
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 22 (level, low) -> IRQ 21
sata_via 0000:04:01.0: routed to hard irq line 5
scsi0 : sata_via
scsi1 : sata_via
scsi2 : sata_via
ata1: SATA max UDMA/133 port i16@0xec00 bmdma 0xe000 irq 21
ata2: SATA max UDMA/133 port i16@0xe480 bmdma 0xe008 irq 21
ata3: PATA max UDMA/133 port i16@0xe400 bmdma 0xe010 irq 21
ata1: SATA link down (SStatus 0 SControl 310)
ata2: SATA link down (SStatus 0 SControl 310)
ata3.00: ATA-5: IC35L060AVVA07-0, VA3OA52A, max UDMA/100
ata3.00: 120103200 sectors, multi 0: LBA
ata3.00: limited to UDMA/33 due to 40-wire cable
ata3.00: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      IC35L060AVVA07-0 VA3O PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 120103200 512-byte hardware sectors (61493 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:0:0: [sda] 120103200 512-byte hardware sectors (61493 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 11:0:0:0: [sda] Attached SCSI disk
sd 11:0:0:0: Attached scsi generic sg0 type 0
ata12.00: disabled
sd 11:0:0:0: [sda] Synchronizing SCSI cache
sd 11:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
sd 11:0:0:0: [sda] Stopping disk
sd 11:0:0:0: [sda] START_STOP FAILED
sd 11:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00

After reboot dmesg says this:

sata_via 0000:04:01.0: version 2.3
ACPI: PCI Interrupt 0000:04:01.0[A] -> GSI 22 (level, low) -> IRQ 21
sata_via 0000:04:01.0: routed to hard irq line 5
scsi0 : sata_via
scsi1 : sata_via
scsi2 : sata_via
ata1: SATA max UDMA/133 port i16@0xec00 bmdma 0xe000 irq 21
ata2: SATA max UDMA/133 port i16@0xe480 bmdma 0xe008 irq 21
ata3: PATA max UDMA/133 port i16@0xe400 bmdma 0xe010 irq 21
ata1: SATA link down (SStatus 0 SControl 310)
ata2: SATA link down (SStatus 0 SControl 310)
ata3.00: ATA-5: IC35L060AVVA07-0, VA3OA52A, max UDMA/100
ata3.00: 120103200 sectors, multi 0: LBA
ata3.01: ATA-6: ST320410A, 3.32, max UDMA/100
ata3.01: 39102336 sectors, multi 0: LBA
ata3.00: limited to UDMA/33 due to 40-wire cable
ata3.01: limited to UDMA/33 due to 40-wire cable
ata3.00: configured for UDMA/33
ata3.01: configured for UDMA/33
scsi 2:0:0:0: Direct-Access     ATA      IC35L060AVVA07-0 VA3O PQ: 0 ANSI: 5
sd 2:0:0:0: [sda] 120103200 512-byte hardware sectors (61493 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:0:0: [sda] 120103200 512-byte hardware sectors (61493 MB)
sd 2:0:0:0: [sda] Write Protect is off
sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sda: sda1
sd 2:0:0:0: [sda] Attached SCSI disk
sd 2:0:0:0: Attached scsi generic sg0 type 0
scsi 2:0:1:0: Direct-Access     ATA      ST320410A        3.32 PQ: 0 ANSI: 5
sd 2:0:1:0: [sdb] 39102336 512-byte hardware sectors (20020 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
sd 2:0:1:0: [sdb] 39102336 512-byte hardware sectors (20020 MB)
sd 2:0:1:0: [sdb] Write Protect is off
sd 2:0:1:0: [sdb] Mode Sense: 00 3a 00 00
sd 2:0:1:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA
 sdb: sdb1 sdb2 sdb3 sdb4
sd 2:0:1:0: [sdb] Attached SCSI disk
sd 2:0:1:0: Attached scsi generic sg1 type 0
ata3.00: disabled
ata3.01: disabled
sd 2:0:0:0: [sda] Synchronizing SCSI cache
sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:0:0: [sda] Stopping disk
sd 2:0:0:0: [sda] START_STOP FAILED
sd 2:0:0:0: [sda] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:1:0: [sdb] Synchronizing SCSI cache
sd 2:0:1:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00
sd 2:0:1:0: [sdb] Stopping disk
sd 2:0:1:0: [sdb] START_STOP FAILED
sd 2:0:1:0: [sdb] Result: hostbyte=0x04 driverbyte=0x00

What do you think about this?
