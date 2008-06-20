From: wessels <wessels147@gmail.com>
Subject: SB600 AHCI causes a disk powercycle
Date: Fri, 20 Jun 2008 12:09:55 +0200
Message-ID: <a58c5fe70806200309w4ec4e27ak541c4500d37a17f5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:25806 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752074AbYFTKKO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 20 Jun 2008 06:10:14 -0400
Received: by yw-out-2324.google.com with SMTP id 9so709362ywe.1
        for <linux-ide@vger.kernel.org>; Fri, 20 Jun 2008 03:09:56 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got a nasty problem with the configuration specified below.
Every couple of hours an IO errors rears its ugly head. When the error occurs
the disk powercycles, one can verify that by looking at Start_Stop_Count smart
attribute. The hardware is ok, I've got three exactly the same systems and all
show the same behaviour. I even run windows a while on one of them but never saw
an increase in the Start_Stop_Count nor any error in the event log, everything
was working ok. The error occurs on both disks, not just /dev/sdb but also
/dev/sda.

Ahci.c looks pretty up to date, it includes everything up to the "sb600 can't do
msi patch"

I'm running a minimal text only server, with CPUFREQ=no and elevator=deadline as
boot options.

If more info is needed please let me know else I hope that someone might find a
cure for this, I'm fighting this since 2.6.22!

Thank you for your interrest,

Frederik

Configuration:
ASUS M2A-VM bios 1803
an onboard AMD/ATI SB600 in AHCI!!!
4*1GB pc6400 ecc
opensuse 11.0 (final) 2.6.25.5-1.1 x86_64
2* WDC SATA WD3201ABYS-01B9A0 in a mirror no lvm

The error:
kernel: ata4.00: exception Emask 0x10 SAct 0x0 SErr 0x90202 action 0xe frozen
kernel: ata4.00: irq_stat 0x00400000, PHY RDY changed
kernel: ata4: SError: { RecovComm Persist PHYRdyChg 10B8B }
kernel: ata4.00: cmd ea/00:00:00:00:00/00:00:00:00:00/a0 tag 0
kernel:          res 40/00:3c:0d:bd:c9/00:00:0b:00:00/40 Emask 0x10 (ATA bus
error)
kernel: ata4.00: status: { DRDY }
kernel: ata4: hard resetting link
kernel: ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
kernel: ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
kernel: ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
kernel: ata4.00: configured for UDMA/133
kernel: ata4: EH complete
kernel: sd 3:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
kernel: sd 3:0:0:0: [sdb] Write Protect is off
kernel: sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
kernel: sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't
support DPO or FUA

boot.msg snippet
<7>ahci 0000:00:12.0: version 3.0
<6>ACPI: PCI Interrupt 0000:00:12.0[A] -> GSI 22 (level, low) -> IRQ 22
<6>ahci 0000:00:12.0: controller can't do 64bit DMA, forcing 32bit
<6>ahci 0000:00:12.0: controller can't do PMP, turning off CAP_PMP
<6>ahci 0000:00:12.0: AHCI 0001.0100 32 slots 4 ports 3 Gbps 0xf impl SATA mode
<6>ahci 0000:00:12.0: flags: ncq sntf ilck pm led clo pio slum part
<6>scsi2 : ahci
<6>scsi3 : ahci
<6>scsi4 : ahci
<6>scsi5 : ahci
<6>ata3: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f100 irq 22
<6>ata4: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f180 irq 22
<6>ata5: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f200 irq 22
<6>ata6: SATA max UDMA/133 abar m1024@0xfe02f000 port 0xfe02f280 irq 22
<6>ata3: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata3.00: ATA-8: WDC WD3201ABYS-01B9A0, 13.01C02, max UDMA/133
<6>ata3.00: 625142448 sectors, multi 1: LBA48 NCQ (depth 31/32)
<6>ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
<6>ata3.00: SB600 AHCI: limiting to 255 sectors per cmd
<6>ata3.00: configured for UDMA/133
<6>ata4: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
<6>ata4.00: ATA-8: WDC WD3201ABYS-01B9A0, 13.01C02, max UDMA/133
<6>ata4.00: 625142448 sectors, multi 1: LBA48 NCQ (depth 31/32)
<6>ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
<6>ata4.00: SB600 AHCI: limiting to 255 sectors per cmd
<6>ata4.00: configured for UDMA/133
<6>ata5: SATA link down (SStatus 0 SControl 300)
<6>ata6: SATA link down (SStatus 0 SControl 300)
<5>scsi 2:0:0:0: Direct-Access     ATA      WDC WD3201ABYS-0 13.0 PQ: 0 ANSI: 5
<5>scsi 3:0:0:0: Direct-Access     ATA      WDC WD3201ABYS-0 13.0 PQ: 0 ANSI: 5
<6>ACPI: PNP0C0B:00 is registered as cooling_device2
<6>ACPI: Fan [FAN] (on)
<6>md: raid1 personality registered for level 1
<6>BIOS EDD facility v0.16 2004-Jun-25, 6 devices found
<4>Driver 'sd' needs updating - please use bus_type methods
<5>sd 2:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
<5>sd 2:0:0:0: [sda] Write Protect is off
<7>sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
<5>sd 2:0:0:0: [sda] 625142448 512-byte hardware sectors (320073 MB)
<5>sd 2:0:0:0: [sda] Write Protect is off
<7>sd 2:0:0:0: [sda] Mode Sense: 00 3a 00 00
<5>sd 2:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
<6> sda: sda1 sda2 sda3 sda4
<5>sd 2:0:0:0: [sda] Attached SCSI disk
<5>sd 3:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
<5>sd 3:0:0:0: [sdb] Write Protect is off
<7>sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
<5>sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
<5>sd 3:0:0:0: [sdb] 625142448 512-byte hardware sectors (320073 MB)
<5>sd 3:0:0:0: [sdb] Write Protect is off
<7>sd 3:0:0:0: [sdb] Mode Sense: 00 3a 00 00
<5>sd 3:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support
DPO or FUA
