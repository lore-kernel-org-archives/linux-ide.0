From: "George Spelvin" <linux@horizon.com>
Subject: 88SE9172 additional PCI ID: 1b4b:9172
Date: 27 May 2013 19:31:17 -0400
Message-ID: <20130527233117.30056.qmail@science.horizon.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:47534 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1756209Ab3E0XiA (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 27 May 2013 19:38:00 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, tj@kernel.org
Cc: linux@horizon.com

On a Gigabyte X79-UP4 motherboard, which is documented as having
3x 88SE9172, lspci -nn gives me:

05:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
06:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
07:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9172 SATA 6Gb/s Controller [1b4b:9172] (rev 11)
08:00.0 SATA controller [0106]: Marvell Technology Group Ltd. 88SE9123 PCIe SATA 6.0 Gb/s controller [1b4b:9123] (rev 11)

(The fourth is an expansion card I have pluggied into a PCIE x1 slot.)

drivers/ata/ahci.c lists:
	{ PCI_DEVICE(0x1b4b, 0x917a),
	  .driver_data = board_ahci_yes_fbs },	/* 88se9172 */
	{ PCI_DEVICE(0x1b4b, 0x9192),
	  .driver_data = board_ahci_yes_fbs },	/* 88se9172 on some Gigabyte */

Is that second one a typo, or do we need a third line for the 0x9172 PCI ID?
For now, I have added the third line and it's mostly working.

(If I enable VT-d and the IOMMU, the devices are recognized but not the
disks plugged into them, but I'm still working on figuring that out.)
