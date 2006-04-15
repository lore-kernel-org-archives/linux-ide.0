From: Patrick Nagelschmidt <dto@gmx.net>
Subject: VIA vt8237: hotplugging Sata-150/Sata-300 disks
Date: Sun, 16 Apr 2006 00:28:34 +0200
Message-ID: <7.0.0.16.2.20060415232920.04e61008@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.de ([213.165.64.20]:7872 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932509AbWDOW2v (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 15 Apr 2006 18:28:51 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Hi,

I've got a problem with my KT600 chipset (Asus A7V600-X, VIA vt8237) 
and hotplugging of sata-disks (tried it with kernel 2.6.15 and 
2.6.16.5, result is the same).

Up to now I had one sata-dock connected to the first sata-port and 
two Seagate sata discs (ST3250823AS), each in a carrier so that I 
could hotswap them. That worked so great that I decided to buy a 
second sata-dock and another pair of carriers.

I've now put a Samsung sata-300 disk (HD160JJ) in sata-150 
compatibility mode to the second sata-port, but once I unplug it and 
plugin a Seagate into the same dock I'm not able to access that disk. 
All I get is


Apr 15 19:32:44 DL kernel: ata2: command 0x25 timeout, stat 0xd0 host_stat 0x1
Apr 15 19:32:44 DL kernel: ata2: translated ATA stat/err 0xd0/00 to 
SCSI SK/ASC/
ASCQ 0xb/47/00
Apr 15 19:32:44 DL kernel: ata2: status=0xd0 { Busy }
Apr 15 19:32:44 DL kernel: sd 2:0:0:0: SCSI error: return code = 0x8000002
Apr 15 19:32:44 DL kernel: sdc: Current: sense key: Aborted Command
Apr 15 19:32:44 DL kernel:     Additional sense: Scsi parity error
Apr 15 19:32:44 DL kernel: end_request: I/O error, dev sdc, sector 0
Apr 15 19:32:44 DL kernel: Buffer I/O error on device sdc, logical block 0
Apr 15 19:32:44 DL kernel: ATA: abnormal status 0xD0 on port 0xB007
Apr 15 19:32:44 DL last message repeated 2 times


This goes on up to "sector 56", "logical block 7". After that it 
stops and /dev/sdc is gone. Reloading the module sata_via works but 
it only finds the disk on the first port from then on, the second 
disk is gone till the next reboot. Swapping of Seagate vs. Seagate 
works though.

Below you can find some snippets of dmesg that are disk-related, 
maybe it's helpful. If more info about my setup is needed I'll gladly 
supply it.

Would be great if someone could enlighten me and tell me if it's a 
chipset/disk/driver problem and what I could try to get rid of it.


BR,
  Patrick


<-------dmesg--------->
[...]
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:0f.1
ACPI: PCI Interrupt Link [LNKE] enabled at IRQ 3
PCI: setting IRQ 3 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.1[A] -> Link [LNKE] -> GSI 3 (level, 
low) -> IRQ 3
PCI: Via IRQ fixup for 0000:00:0f.1, from 14 to 3
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8237 (rev 00) IDE UDMA133 controller on pci0000:00:0f.1
     ide0: BM-DMA at 0x9800-0x9807, BIOS settings: hda:DMA, hdb:pio
     ide1: BM-DMA at 0x9808-0x980f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: SAMSUNG SP1604N, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 1024KiB
hda: 312581808 sectors (160041 MB) w/2048KiB Cache, CHS=19457/255/63, UDMA(100)
hda: cache flushes supported
  hda: hda1 < hda5 >
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:0e.0[A] -> Link [LNKB] -> GSI 10 (level, 
low) -> IRQ 10
scsi0 : Adaptec AIC7XXX EISA/VLB/PCI SCSI HBA DRIVER, Rev 7.0
         <Adaptec 2940 Pro Ultra SCSI adapter>
         aic7880: Ultra Wide Channel A, SCSI Id=7, 16/253 SCBs

   Vendor: IBM       Model: DDYS-T09170N      Rev: SA2A
   Type:   Direct-Access                      ANSI SCSI revision: 03
scsi0:A:0:0: Tagged Queuing enabled.  Depth 4
  target0:0:0: Beginning Domain Validation
  target0:0:0: wide asynchronous.
  target0:0:0: FAST-20 WIDE SCSI 40.0 MB/s ST (50 ns, offset 8)
  target0:0:0: Domain Validation skipping write tests
  target0:0:0: Ending Domain Validation
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
SCSI device sda: 17916240 512-byte hdwr sectors (9173 MB)
SCSI device sda: drive cache: write back
  sda: sda1 sda2 sda3
sd 0:0:0:0: Attached scsi disk sda

[...]

libata version 1.20 loaded.
sata_via 0000:00:0f.0: version 1.1
ACPI: PCI Interrupt Link [LNKF] BIOS reported IRQ 0, using IRQ 5
ACPI: PCI Interrupt Link [LNKF] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:0f.0[B] -> Link [LNKF] -> GSI 5 (level, 
low) -> IRQ 5
PCI: Via IRQ fixup for 0000:00:0f.0, from 3 to 5
sata_via 0000:00:0f.0: routed to hard irq line 5
ata1: SATA max UDMA/133 cmd 0xB800 ctl 0xB402 bmdma 0xA400 irq 5
ata2: SATA max UDMA/133 cmd 0xB000 ctl 0xA802 bmdma 0xA408 irq 5
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4023 85:3469 86:3c01 87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 488397168 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi1 : sata_via
sd 0:0:0:0: Attached scsi generic sg0 type 0
USB Universal Host Controller Interface driver v2.3
ata2: dev 0 cfg 49:2f00 82:746b 83:7f01 84:4023 85:7469 86:3c01 87:4023 88:80ff
ata2: dev 0 ATA-7, max UDMA7, 312581808 sectors: LBA48
ata2: dev 0 configured for UDMA/133
scsi2 : sata_via
   Vendor: ATA       Model: ST3250823AS       Rev: 3.03
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
SCSI device sdb: 488397168 512-byte hdwr sectors (250059 MB)
SCSI device sdb: drive cache: write back
  sdb: sdb1 < sdb5 >
sd 1:0:0:0: Attached scsi disk sdb
sd 1:0:0:0: Attached scsi generic sg1 type 0
   Vendor: ATA       Model: SAMSUNG HD160JJ   Rev: ZM10
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
  sdc: sdc1 < sdc5 >
sd 2:0:0:0: Attached scsi disk sdc
sd 2:0:0:0: Attached scsi generic sg2 type 0

