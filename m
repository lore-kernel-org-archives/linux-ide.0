From: akpm@linux-foundation.org
Subject: [patch 26/30] Support for Marvell 7042 Chip
Date: Tue, 06 Mar 2007 02:38:10 -0800
Message-ID: <200703061038.l26AcBaO019542@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp.osdl.org ([65.172.181.24]:34463 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934038AbXCFKiW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Mar 2007 05:38:22 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, tmorrison@empirix.com

From: "Morrison, Tom" <tmorrison@empirix.com>

Added Support for Marvell 7042 Chip - 7042 has same capabilities & behavior
as 6042.

Signed-off-by: Thomas A. Morrison <tmorrison@empirix.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/sata_mv.c |    3 +++
 1 file changed, 3 insertions(+)

diff -puN drivers/ata/sata_mv.c~support-for-marvell-7042-chip drivers/ata/sata_mv.c
--- a/drivers/ata/sata_mv.c~support-for-marvell-7042-chip
+++ a/drivers/ata/sata_mv.c
@@ -548,6 +548,9 @@ static const struct pci_device_id mv_pci
 
 	{ PCI_VDEVICE(TTI, 0x2310), chip_7042 },
 
+	/* add Marvell 7042 support */
+	{ PCI_VDEVICE(MARVELL, 0x7042), chip_7042 },
+
 	{ }			/* terminate list */
 };
 
_
