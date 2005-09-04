From: Marc Bevand <mb@opensc.org>
Subject: =?utf-8?b?W3NhdGFfc2lsMjRd?= v0.10 works, v0.20 doesn't
Date: Sun, 4 Sep 2005 07:56:52 +0000 (UTC)
Message-ID: <loom.20050904T095233-120@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from main.gmane.org ([80.91.229.2]:43953 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751304AbVIDKBX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 4 Sep 2005 06:01:23 -0400
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1EBrIc-0005wz-Bt
	for linux-ide@vger.kernel.org; Sun, 04 Sep 2005 12:00:30 +0200
Received: from pool-71-105-101-137.lsanca.dsl-w.verizon.net ([71.105.101.137])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 12:00:30 +0200
Received: from mb by pool-71-105-101-137.lsanca.dsl-w.verizon.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-ide@vger.kernel.org>; Sun, 04 Sep 2005 12:00:30 +0200
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

I gave a try to the new sata_sil24.ko module that recently appeared in
the libata development tree.  I tested 3 branches which include 2 ver-
sions of this driver: sil24 as well as ALL (new 0.20 driver from Tejun
Heo) and sil24-original (old 0.10 driver from Silicon Image). I pulled
libata-dev.git on September 2nd.

The result is that only the v0.10 driver from Silicon Image is able to
identify disks plugged on a SiI3124 adapter while the new v0.20 driver
fails to do so. See below for details.

Tejun, or Jeff:  do you think the issue in the v0.20 driver is related
to these changes about making ata_bus_probe() an ops or not ?


--oOo-- branch sil24:

I plugged a disk on the 2nd port of the adapter (ata10):

  sata_sil24 version 0.20
  ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 185
  ata9: SATA max UDMA/100 cmd 0xFFFFC20000030000 ctl 0x0 bmdma 0x0 irq 185
  ata10: SATA max UDMA/100 cmd 0xFFFFC20000032000 ctl 0x0 bmdma 0x0 irq 185
  ata11: SATA max UDMA/100 cmd 0xFFFFC20000034000 ctl 0x0 bmdma 0x0 irq 185
  ata12: SATA max UDMA/100 cmd 0xFFFFC20000036000 ctl 0x0 bmdma 0x0 irq 185
  ata9: no device found (phy stat 00000000)
  scsi8 : sata_sil24
  ata10: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
  ata10: no dma/lba
  ata10: dev 0 not supported, ignoring
  scsi9 : sata_sil24
  ata11: no device found (phy stat 00000000)
  scsi10 : sata_sil24
  ata12: no device found (phy stat 00000000)
  scsi11 : sata_sil24

There is apparently an issue when trying to identify the device because
all words of the IDENTIFY reply contain NUL bytes  (especially word 49,
which leads to "no dma/lba" and then "dev 0 not supported, ignoring").


--oOo-- branch ALL:

Exactly the same result than branch sil24:

  sata_sil24 version 0.20
  ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 185
  ata9: SATA max UDMA/100 cmd 0xFFFFC20000030000 ctl 0x0 bmdma 0x0 irq 185
  ata10: SATA max UDMA/100 cmd 0xFFFFC20000032000 ctl 0x0 bmdma 0x0 irq 185
  ata11: SATA max UDMA/100 cmd 0xFFFFC20000034000 ctl 0x0 bmdma 0x0 irq 185
  ata12: SATA max UDMA/100 cmd 0xFFFFC20000036000 ctl 0x0 bmdma 0x0 irq 185
  ata9: no device found (phy stat 00000000)
  scsi8 : sata_sil24
  ata10: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
  ata10: no dma
  ata10: dev 0 not supported, ignoring
  scsi9 : sata_sil24
  ata11: no device found (phy stat 00000000)
  scsi10 : sata_sil24
  ata12: no device found (phy stat 00000000)
  scsi11 : sata_sil24


--oOo-- branch sil24-original:

This branch crashed my kernel. I understand that the driver contributed
by Silicon Image makes ata_bus_probe an ops, but it seems that not all
SATA drivers have been converted to use it. More particularly it happens
that I have to load sata_sil because I have other disks on another SATA
chip, and when loading it the kernel crashes in libata-core.c, function
ata_device_add(), on this line of code:

  rc = host_set->ops->bus_probe(ap);

When loading sata_sil, bus_probe is a NULL pointer. So I have had to
change this line to something like:

  if (host_set->ops->bus_probe)
    rc = host_set->ops->bus_probe(ap);
  else
    rc = ata_bus_probe(ap);

This way I was able to load both sata_sil and sata_sil24. The good news
is that the sil24-original driver is able to correctly identify my disk
(still ata10):

sata_sil24 version 0.10
ACPI: PCI Interrupt 0000:01:06.0[A] -> GSI 29 (level, low) -> IRQ 201
sata_sil24: mmio_base0=ffffc200000e6c00 base_len (hex)=80
sata_sil24: mmio_base=ffffc20000490000 base_len  (hex)=8000
sata_sil24: Found Port Ready
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff8100343fd000 physical=343fd000
ata9: SATA max UDMA/100 cmd 0xFFFFC20000490000 ctl 0xFFFFC2000049000A bmdma
0xFFFFC20000490000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff810033c05000 physical=33c05000
ata10: SATA max UDMA/100 cmd 0xFFFFC20000492000 ctl 0xFFFFC2000049200A bmdma
0xFFFFC20000490000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff81003397f000 physical=3397f000
ata11: SATA max UDMA/100 cmd 0xFFFFC20000494000 ctl 0xFFFFC2000049400A bmdma
0xFFFFC20000490000 irq 201
sata_sil24: sil_port_start allocating Scatter Table, PRBs hex=840
sata_sil24: sil_port_start virtual=ffff81003a6df000 physical=3a6df000
ata12: SATA max UDMA/100 cmd 0xFFFFC20000496000 ctl 0xFFFFC2000049600A bmdma
0xFFFFC20000490000 irq 201
ata9: no device found (phy stat 00000000)
scsi8 : sata_sil24
sata_sil24: bus_probe ap=ffff810035c81360 trying to identify dev=0
sata_sil24: sil_dev_identify speed=1
ata10: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:007f
ata10: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
sata_sil24: bus_probe FOUND DEVICE
ata10: dev 0 configured for UDMA/100
scsi9 : sata_sil24
ata11: no device found (phy stat 00000000)
scsi10 : sata_sil24
ata12: no device found (phy stat 00000000)
scsi11 : sata_sil24
  Vendor: ATA       Model: ST3160023AS       Rev: 3.18
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
SCSI device sdc: 312581808 512-byte hdwr sectors (160042 MB)
SCSI device sdc: drive cache: write back
 sdc: unknown partition table
Attached scsi disk sdc at scsi9, channel 0, id 0, lun 0
Attached scsi generic sg2 at scsi9, channel 0, id 0, lun 0,  type 0
sata_sil24: found 4 Ports

-- 
Marc Bevand

