From: Soeren Sonnenburg <kernel@nn7.de>
Subject: recommendations for a *stable* sata card
Date: Sun, 22 Oct 2006 09:44:05 +0200
Message-ID: <1161503045.29634.74.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.first.fraunhofer.de ([194.95.169.2]:8389 "EHLO
	mail.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932149AbWJVHoL (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 22 Oct 2006 03:44:11 -0400
Received: from webmail.hansenet.de (e178185039.adsl.alicedsl.de [85.178.185.39])
	(authenticated bits=0)
	by mail.first.fraunhofer.de (8.13.8/8.13.8) with ESMTP id k9M7i72p002758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linux-ide@vger.kernel.org>; Sun, 22 Oct 2006 09:44:07 +0200 (CEST)
	(envelope-from kernel@nn7.de)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux-ide <linux-ide@vger.kernel.org>

Dear all,

do you think the issue below will be resolved in the near future ? If
not I would better buy a new sata stand-a-lone card which is known to
work flawlessly (including error corrections) - which one ??

I upgraded (1 month ago) to using 2 sata disks (both seagate drives
ST3400832AS and ST3750640AS) on this asus a7v8x on-board promise fastrak
376 (PDC20376) controller. 

However, as soon as I do a lot of io (cp some
G of files, or dd if=/dev/sdx of=/dev/null reads) I get swamped in 

ata1: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata1: status=0x51 { DriveReady SeekComplete Error }
ata1: error=0x0c { DriveStatusError }
ata2: translated ATA stat/err 0x51/0c to SCSI SK/ASC/ASCQ 0xb/00/00
ata2: status=0x51 { DriveReady SeekComplete Error }
ata2: error=0x0c { DriveStatusError }
...

messages. For that it is enough to do it on a single drive or copy from
drive to drive. This is on kernel 2.6.18.1.

Can anyone translate these dubious error messages to me ?

Here are more details about the system:

- the sata_promise driver version 1.04 is used

- relevant dmesg output:
libata version 2.00 loaded.
sata_promise 0000:00:08.0: version 1.04
ACPI: PCI Interrupt 0000:00:08.0[A] -> GSI 17 (level, low) -> IRQ 17
ata1: SATA max UDMA/133 cmd 0xF8820200 ctl 0xF8820238 bmdma 0x0 irq 17
ata2: SATA max UDMA/133 cmd 0xF8820280 ctl 0xF88202B8 bmdma 0x0 irq 17
scsi0 : sata_promise
ata1: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata1.00: ATA-7, max UDMA/133, 781422768 sectors: LBA48 NCQ (depth 0/32)
ata1.00: configured for UDMA/133
scsi1 : sata_promise
ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 300)
ata2.00: ATA-7, max UDMA/133, 1465149168 sectors: LBA48 NCQ (depth 0/32)
ata2.00: configured for UDMA/133
  Vendor: ATA       Model: ST3400832AS       Rev: 3.01
  Type:   Direct-Access                      ANSI SCSI revision: 05
  Vendor: ATA       Model: ST3750640AS       Rev: 3.AA
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: unknown partition table
sd 0:0:0:0: Attached scsi disk sda
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 1465149168 512-byte hdwr sectors (750156 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: unknown partition table
sd 1:0:0:0: Attached scsi disk sdb
sd 0:0:0:0: Attached scsi generic sg0 type 0
sd 1:0:0:0: Attached scsi generic sg1 type 0
ACPI: PCI Interrupt 0000:00:10.3[D] -> GSI 21 (level, low) -> IRQ 18
PCI: VIA IRQ fixup for 0000:00:10.3, from 0 to 2
ehci_hcd 0000:00:10.3: EHCI Host Controller
PCI: VIA IRQ fixup for 0000:00:10.1, from 0 to 2

# cat /proc/interrupts 
           CPU0       
  0:   54359380    IO-APIC-edge  timer
  1:        133    IO-APIC-edge  i8042
  4:       4917    IO-APIC-edge  lirc_serial
  8:          4    IO-APIC-edge  rtc
  9:          0   IO-APIC-level  acpi
 14:    1029875    IO-APIC-edge  ide0
 15:         39    IO-APIC-edge  ide1
 16:    1033039   IO-APIC-level  ide2
 17:     215000   IO-APIC-level  libata, ohci1394
 18:    5424882   IO-APIC-level  ehci_hcd:usb1, uhci_hcd:usb2, uhci_hcd:usb3, uhci_hcd:usb4
 19:    2288674   IO-APIC-level  fcpci, eth0
 20:   33358502   IO-APIC-level  saa7146 (0), saa7146 (1)
 21:          0   IO-APIC-level  VIA8233
NMI:   54359509 
LOC:   54356735 
ERR:          0
MIS:          0

# lspci
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8377 [KT400/KT600 AGP] Host Bridge
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8235 PCI Bridge
0000:00:07.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host Controller (rev 46)
0000:00:08.0 RAID bus controller: Promise Technology, Inc. PDC20376 (FastTrak 376) (rev 02)
0000:00:09.0 Ethernet controller: Broadcom Corporation BCM4401 100Base-T (rev 01)
0000:00:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:00:0b.0 Network controller: AVM Audiovisuelles MKTG & Computer System GmbH A1 ISDN [Fritz] (rev 02)
0000:00:0c.0 Ethernet controller: Intel Corp. 82541GI/PI Gigabit Ethernet Controller
0000:00:0f.0 Unknown mass storage controller: Triones Technologies, Inc. HPT366/368/370/370A/372 (rev 04)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:01:00.0 VGA compatible controller: ATI Technologies Inc RV280 [Radeon 9200] (rev 01)
0000:01:00.1 Display controller: ATI Technologies Inc RV280 [Radeon 9200] (Secondary) (rev 01)

Thanks in advance,
Soeren
