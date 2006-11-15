From: Pavel Roskin <proski@gnu.org>
Subject: ata_piix on Thinkpad T30 - qc timeout on boot
Date: Tue, 14 Nov 2006 23:04:13 -0500
Message-ID: <1163563453.3100.24.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:41441 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S965919AbWKOHkB
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 15 Nov 2006 02:40:01 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GkC0n-0003yZ-RO
	for linux-ide@vger.kernel.org; Tue, 14 Nov 2006 23:04:33 -0500
Received: from proski by gnu.org with local (Exim 4.63)
	(envelope-from <proski@gnu.org>)
	id 1GkC0T-0000zt-9I
	for linux-ide@vger.kernel.org; Tue, 14 Nov 2006 23:04:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hello!

I'm trying out PATA support on IBM Thinkpad T30.  It's an unmodified
Linux 2.6.18-rc5 configured with CONFIG_ATA but without CONFIG_IDE.  I'm
getting log delays on boot - at least one minute.  Here's an excerpt
from the kernel log:

PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
...
libata version 2.00 loaded.
ata_piix 0000:00:1f.1: version 2.00ac6
PCI: Enabling device 0000:00:1f.1 (0005 -> 0007)
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 11
ACPI: PCI Interrupt 0000:00:1f.1[A] -> Link [LNKC] -> GSI 11 (level, low) -> IRQ 11
PCI: Setting latency timer of device 0000:00:1f.1 to 64
ata1: PATA max UDMA/100 cmd 0x1F0 ctl 0x3F6 bmdma 0x1860 irq 14
ata2: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0x1868 irq 15
scsi0 : ata_piix
ata1.00: ATA-5, max UDMA/100, 78140160 sectors: LBA 
ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/100
scsi1 : ata_piix
ata2.00: ATAPI, max UDMA/33
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.01: qc timeout (cmd 0xa1)
ata2.01: failed to IDENTIFY (I/O error, err_mask=0x4)
ata2: failed to recover some devices, retrying in 5 secs
ata2.00: configured for UDMA/33
scsi 0:0:0:0: Direct-Access     ATA      IC25N040ATCS05-0 CS4O PQ: 0 ANSI: 5
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 78140160 512-byte hdwr sectors (40008 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 sda3 sda4
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
scsi 1:0:0:0: CD-ROM            MATSHITA UJDA720 DVD/CDRW 1.03 PQ: 0 ANSI: 5
sr0: scsi3-mmc drive: 24x/24x writer cd/rw xa/form2 cdda tray
Uniform CD-ROM driver Revision: 3.20
sr 1:0:0:0: Attached scsi CD-ROM sr0
sr 1:0:0:0: Attached scsi generic sg1 type 5


I understand that the driver is looking for some additional interface
but fails to probe it.

Note that with CONFIG_IDE, the hard drive is /dev/hda and DVD
is /dev/hdc, so it's not the secondary interface - it's something else.

The kernel with CONFIG_IDE won't wait for anything.  Here's what it
reports:

PCI: Probing PCI hardware (bus 00)
PCI quirk: region 1000-107f claimed by ICH4 ACPI/GPIO/TCO
PCI quirk: region 1180-11bf claimed by ICH4 GPIO
PCI: Ignoring BAR0-3 of IDE controller 0000:00:1f.1
...
ICH3M: chipset revision 2
ICH3M: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0x1860-0x1867, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x1868-0x186f, BIOS settings: hdc:DMA, hdd:pio
Probing IDE interface ide0...
hda: IC25N040ATCS05-0, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
hdc: UJDA720 DVD/CDRW, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: 78140160 sectors (40007 MB) w/7898KiB Cache, CHS=65535/16/63, UDMA(100)
hda: cache flushes not supported
 hda: hda1 hda2 hda3 hda4


I tried adding "ata_piix.force_pcs=1" to the command line, but it made
no difference.

lspci shows only one IDE controller (numeric ID 8086:248a):
00:1f.1 IDE interface: Intel Corporation 82801CAM IDE U100 (rev 02)

I put more information on http://red-bean.com/proski/t30-libata/ (that
includes full PCI space of the IDE controller)

The system is Fedora Core 6 with all updates and the custom kernel.  The
architecture is i386, the CPU is Pentium 4-M.

-- 
Regards,
Pavel Roskin


