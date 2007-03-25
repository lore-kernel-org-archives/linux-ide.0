From: =?ISO-8859-15?Q?R=FCdiger?= Otte <best-before-2007-07-01@gmx.net>
Subject: Problems with VIA VT8251 SATA and kernels above 2.6.18.x
Date: Mon, 26 Mar 2007 01:27:54 +0200
Message-ID: <20070326012754.598fa923@snoodles.holzweg.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:50769 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753024AbXCYX1u convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 25 Mar 2007 19:27:50 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

Dear Linux ATA people,

the SATA-Controller on Asus A8V-MX mainboard (VIA VT8251) doesn't
recognize an attached SATA-Harddisk (Western Digital WD3200AAKS in
my case) with kernels 2.6.19 and above. I get the error with 2.6.19,
2.6.20 and 2.6.21-rc4, but when switching back to 2.6.18.8 everything
works fine. Also there are several identical reports of this problem
on VIA arena and other sites, so maybe someone could fix this.
Appended is the kernel output of ahci-driver both with working and
with non working kernels.

Best regards,
R=FCdiger

-----
kernel >=3D 2.6.19
-----

ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl
SATA mode ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum
part ata1: SATA max UDMA/133 cmd 0xE0804D00 ctl 0x0 bmdma 0x0 irq 221
ata2: SATA max UDMA/133 cmd 0xE0804D80 ctl 0x0 bmdma 0x0 irq 221
ata3: SATA max UDMA/133 cmd 0xE0804E00 ctl 0x0 bmdma 0x0 irq 221
ata4: SATA max UDMA/133 cmd 0xE0804E80 ctl 0x0 bmdma 0x0 irq 221
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x104)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x104)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: qc timeout (cmd 0xec)
ata1.00: failed to IDENTIFY (I/O error, err_mask=3D0x104)
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)

----
kernel =3D 2.6.18.8
-----

ahci 0000:00:0f.0: AHCI 0001.0000 32 slots 4 ports 3 Gbps 0xf impl
SATA mode ahci 0000:00:0f.0: flags: 64bit ncq pm led clo pmp pio slum
part ata1: SATA max UDMA/133 cmd 0xE0804D00 ctl 0x0 bmdma 0x0 irq 201
ata2: SATA max UDMA/133 cmd 0xE0804D80 ctl 0x0 bmdma 0x0 irq 201
ata3: SATA max UDMA/133 cmd 0xE0804E00 ctl 0x0 bmdma 0x0 irq 201
ata4: SATA max UDMA/133 cmd 0xE0804E80 ctl 0x0 bmdma 0x0 irq 201
scsi0 : ahci
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth
0/32) ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
ata1: SATA link up 3.0 Gbps (SStatus 123 SControl 300)
ata1.00: ATA-7, max UDMA/133, 625142448 sectors: LBA48 NCQ (depth
0/32) ata1.00: ata1: dev 0 multi count 16
ata1.00: configured for UDMA/133
scsi1 : ahci
ata2: SATA link down (SStatus 0 SControl 300)
scsi2 : ahci
ata3: SATA link down (SStatus 0 SControl 300)
scsi3 : ahci
ata4: SATA link down (SStatus 0 SControl 300)
  Vendor: ATA       Model: WDC WD3200AAKS-0  Rev: 12.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 625142448 512-byte hdwr sectors (320073 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
 sda: sda1 sda2 < sda5 sda6 sda7 sda8 >
sd 0:0:0:0: Attached scsi disk sda
sd 0:0:0:0: Attached scsi generic sg0 type 0
