From: Roman Valls <rvalls@escert.upc.edu>
Subject: sata_sx4: it's beta/experimental, but does it work ?
Date: Fri, 30 Jan 2009 10:07:51 +0100
Message-ID: <4982C367.60000@escert.upc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.escert.upc.edu ([147.83.152.5]:34774 "EHLO
	mail.escert.upc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754631AbZA3JQz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 30 Jan 2009 04:16:55 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello Jeff & linux-ide ppl,

I've tried to load this driver after installing openfiler distribution
(kernel 2.6.26.8-1.0.11.smp.gcc3.4.x86.i686), but it complains about
xfermode and does not export any drive to /dev.

I've tried JBOD and RAID5 on promise Ctrl-F boot utility so far. Which
mode should I enable on the controller to make it work even without
hardware acceleration, which I know it's unsupported right now.

Drop me a line if any of you wish to do some testing on it, this machine
is not in production right now.

Thanks !
Roman

PD: Here's the ticket I opened on openfiler, if you want further details:

https://project.openfiler.com/tracker/ticket/880

And here's a relevant dmesg output:

ACPI: PCI interrupt for device 0000:02:0c.0 disabled
libata version 3.00 loaded.
sata_sx4 0000:02:0c.0: version 0.12
ACPI: PCI Interrupt 0000:02:0c.0[A] -> GSI 20 (level, low) -> IRQ 20
Local DIMM ECC Enabled
scsi4 : sata_sx4
scsi5 : sata_sx4
scsi6 : sata_sx4
scsi7 : sata_sx4
ata1: SATA max UDMA/133 mmio m1048576@0xfea00000 dimm m32768@0xfe9f8000
port 0xfea00200 irq 20
ata2: SATA max UDMA/133 mmio m1048576@0xfea00000 dimm m32768@0xfe9f8000
port 0xfea00280 irq 20
ata3: SATA max UDMA/133 mmio m1048576@0xfea00000 dimm m32768@0xfe9f8000
port 0xfea00300 irq 20
ata4: SATA max UDMA/133 mmio m1048576@0xfea00000 dimm m32768@0xfe9f8000
port 0xfea00380 irq 20
ata1.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata1.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata1.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: limiting speed to UDMA/133:PIO3
ata1.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata1.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata1.00: qc timeout (cmd 0xef)
ata1.00: failed to set xfermode (err_mask=0x4)
ata1.00: disabled
ata2.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata2.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (err_mask=0x4)
ata2.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata2.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (err_mask=0x4)
ata2.00: limiting speed to UDMA/133:PIO3
ata2.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata2.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata2.00: qc timeout (cmd 0xef)
ata2.00: failed to set xfermode (err_mask=0x4)
ata2.00: disabled
ata3.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: qc timeout (cmd 0xef)
ata3.00: failed to set xfermode (err_mask=0x4)
ata3.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: qc timeout (cmd 0xef)
ata3.00: failed to set xfermode (err_mask=0x4)
ata3.00: limiting speed to UDMA/133:PIO3
ata3.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata3.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata3.00: qc timeout (cmd 0xef)
ata3.00: failed to set xfermode (err_mask=0x4)
ata3.00: disabled
ata4.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: qc timeout (cmd 0xef)
ata4.00: failed to set xfermode (err_mask=0x4)
ata4.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: qc timeout (cmd 0xef)
ata4.00: failed to set xfermode (err_mask=0x4)
ata4.00: limiting speed to UDMA/133:PIO3
ata4.00: ATA-7: ST3400832AS, 3.01, max UDMA/133
ata4.00: 781422768 sectors, multi 0: LBA48 NCQ (depth 0/32)
ata4.00: qc timeout (cmd 0xef)
ata4.00: failed to set xfermode (err_mask=0x4)
ata4.00: disabled
ACPI: PCI interrupt for device 0000:02:0c.0 disabled


# lspci
02:0c.0 RAID bus controller: Promise Technology, Inc. PDC20621 [SATA150
SX4] 4 Channel IDE RAID Controller (rev 01)


- --
PGP Key ID: 0x08F80CB5
esCERT-UPC - http://escert.upc.edu
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkmCw2YACgkQEqU4jwj4DLWfcgCfTfdHi2eVhi4xTg+QblwXdxuU
mfUAmgONPEyULISu5U3hdISn2BWDhsfN
=anvl
-----END PGP SIGNATURE-----
