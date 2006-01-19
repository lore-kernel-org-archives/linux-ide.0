From: Pasha <opa@nsib.ru>
Subject: sata_mv @ asus PSCH-SR/SATA doesnt work
Date: Thu, 19 Jan 2006 18:23:01 +0600
Message-ID: <200601191823.01254.opa@nsib.ru>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw2.tstinc.ru ([80.66.95.148]:58372 "EHLO fw2.tstinc.ru")
	by vger.kernel.org with ESMTP id S1161146AbWASMX2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 19 Jan 2006 07:23:28 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: jgarzik@pobox.com

I has asus PSCH-SR/SATA with aic-8110 RAID chip, detected as 11ab:5041 
(Marvell 5041) and covered by sata_mv
Linux: slackware 9.1
kernel is 2.6.15 SMP with 2.6.15-libata1.patch.bz2

lspci -vn:
02:08.0 Class 0100: 11ab:5041 (rev 03)
        Subsystem: 1043:8124
        Flags: 66Mhz, medium devsel, IRQ 225
        Memory at f3000000 (64-bit, non-prefetchable) [size=512K]
        Capabilities: [40] Power Management version 2
        Capabilities: [50] Message Signalled Interrupts: 64bit+ Queue=0/0 
Enable+
        Capabilities: [60] PCI-X non-bridge device.

but at driver load system wait till 30 sec and doesnt create /dev/sda on 
modprobe sd_mod. dmesg is:

sata_mv 0000:02:08.0: version 0.5
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 209
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xE0AA2120 bmdma 0x0 irq 209
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xE0AA4120 bmdma 0x0 irq 209
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0AA6120 bmdma 0x0 irq 209
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0AA8120 bmdma 0x0 irq 209
ata1: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 
88:40ff
ata1: dev 0 ATA-7, max UDMA7, 390721968 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
^^^^^^^^^^^^^^^^^
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv

at unload:

ACPI: PCI interrupt for device 0000:02:08.0 disabled



PS.

FC5 kernel (2.6.15-1.1826.2.10_FC5smp) also wait for a long.

sata_mv 0000:02:08.0: version 0.5
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 209
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via MSI
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xE0CA2120 bmdma 0x0 irq 209
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xE0CA4120 bmdma 0x0 irq 209
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xE0CA6120 bmdma 0x0 irq 209
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xE0CA8120 bmdma 0x0 irq 209
ata3: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 
88:40ff
ata3: dev 0 ATA-7, max UDMA7, 390721968 sectors: LBA48
ata3: slow completion (cmd ef)
ata3: dev 0 configured for UDMA/133
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
ata5: no device found (phy stat 00000000)
scsi4 : sata_mv
ata6: no device found (phy stat 00000000)
scsi5 : sata_mv
  Vendor: ATA       Model: SAMSUNG SP2004C   Rev: VM10
  Type:   Direct-Access                      ANSI SCSI revision: 05


sd_mod also slow and says

SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
SCSI device sdb: drive cache: write back
 sdb:<3>ata3: Entering mv_eng_timeout
mmio_base e0c80000 ap def75314 qc def757f0 scsi_cmnd df335770 &cmnd df3357b4
ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sdb: Current: sense key: No Sense
    Additional sense: No additional sense information
ata3: Entering mv_eng_timeout
mmio_base e0c80000 ap def75314 qc def757f0 scsi_cmnd df335770 &cmnd df3357b4
ata3: status=0x50 { DriveReady SeekComplete }
ata3: error=0x01 { AddrMarkNotFound }
sdb: Current: sense key: No Sense
    Additional sense: No additional sense information
 unknown partition table
sd 2:0:0:0: Attached scsi disk sdb

now you can do some operations like fdisk but with error=0x01 
{ AddrMarkNotFound } and 30 sec per request. :(




kernel 1.6.14.4-ck1 (sata_mv v0.12) loads fast but says

sata_mv version 0.12
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 209
sata_mvPCI master won't flush
ACPI: PCI interrupt for device 0000:02:08.0 disabled

PPS. I can give ssh for debug/improve driver.

