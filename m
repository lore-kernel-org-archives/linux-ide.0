From: Jan Sembera <fis@bofh.cz>
Subject: Regression between v3.5 and v3.6 in libata
Date: Tue, 26 Feb 2013 21:03:48 +0100
Message-ID: <20130226200348.GA25087@abydos.bofh.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from anise.cz ([81.0.246.76]:42384 "EHLO anise.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752852Ab3BZUO0 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 26 Feb 2013 15:14:26 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: mjg@redhat.com, holger@homac.de, ming.m.lin@intel.com, 1126766@bugs.launchpad.net

Hi,

	it looks like commit 30dcf76 (libata: migrate ACPI code over to new
bindings) introduced some regression in libata, which is causing my AMD E450
based system (Asus E45M1 motherboard) to fail on one of the connected disk
drives. It works fine in v3.5, it fails with v3.6 onwards (I've tested with
3.8 and it's also broken).

Basically, four SATA ports are connected to ahci driver and the fifth port
is somehow suspiciously connected to pata-atiixp controller (although it is
in fact SATA disk with SATA connection):

00:14.1 IDE interface: Advanced Micro Devices [AMD] nee ATI SB7x0/SB8x0/SB9x0 IDE Controller (rev 40)

This works with 3.5:

[    1.972785] pata_acpi 0000:03:00.1: enabling device (0000 -> 0001)
[    1.973265] Fixed MDIO Bus: probed
...
[    2.877438] scsi6 : pata_atiixp
[    2.881369] scsi7 : pata_atiixp
[    2.881678] ata7: PATA max UDMA/100 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[    2.881682] ata8: PATA max UDMA/100 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
...
[    3.046418] ata7.00: ATA-8: SAMSUNG HD204UI, 1AQ10001, max UDMA/133
[    3.046428] ata7.00: 3907029168 sectors, multi 16: LBA48 NCQ (depth 0/32)
[    3.046436] ata7.00: limited to UDMA/33 due to 40-wire cable
[    3.059262] ata7.00: configured for UDMA/33

But fails with later kernels:

[    2.391535] scsi6 : pata_acpi
[    2.391994] scsi7 : pata_acpi
[    2.392281] ata7: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xf100 irq 14
[    2.392371] ata8: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xf108 irq 15
[    2.392453] pata_acpi 0000:03:00.1: enabling device (0000 -> 0001)
[    2.393013] libphy: Fixed MDIO Bus: probed
[    2.393060] ata7: prereset failed (errno=-19)
[    2.393063] ata7: reset failed, giving up
...
[    2.924032] ata8: prereset failed (errno=-19)
[    2.924126] ata8: reset failed, giving up

Full dmesg outputs:
https://launchpadlibrarian.net/131361456/dmesg-3.4-ok.log
https://launchpadlibrarian.net/131361470/dmesg-3.7-bad.log

And the disk connected to that port remains undetected. I have bisected between
v3.5 and v3.6 and with clear reproduction case narrowed it down to
30dcf76acc695cbd2fa919e294670fe9552e16e7. I would like to try to revert it
on newer kernels to retest with 3.8 for example, but it's not easy to do right
away without knowing what I'm doing, as there are some patches stacked on top
of that.

I'm willing to do any testing necessary to resolve this.

Thanks,
Jan
