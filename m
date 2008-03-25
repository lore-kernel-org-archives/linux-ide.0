From: Benjamin Herrenschmidt <benh@ozlabs.org>
Subject: [PATCH] pata_sil680: Only enable MMIO on Cell blades
Date: Wed, 26 Mar 2008 10:50:41 +1100
Message-ID: <20080325235112.C29CDDE1D9@ozlabs.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:51561 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755869AbYCYXxt (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 25 Mar 2008 19:53:49 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: Linux IDE <linux-ide@vger.kernel.org>, linux-kernel@vger.kernel.org

There have been reported regressions of the SIL 680 driver when
using MMIO, so this makes it only try MMIO on Cell blades where
it's known to be necessary (the host bridge doesn't do PIO on these).

We'll try to find the root problem with MMIO separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 drivers/ata/pata_sil680.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- linux-work.orig/drivers/ata/pata_sil680.c	2008-03-26 10:43:20.000000000 +1100
+++ linux-work/drivers/ata/pata_sil680.c	2008-03-26 10:43:34.000000000 +1100
@@ -269,7 +269,11 @@ static u8 sil680_init_chip(struct pci_de
 	dev_dbg(&pdev->dev, "sil680: BA5_EN = %d clock = %02X\n",
 		tmpbyte & 1, tmpbyte & 0x30);
 
-	*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
+	*try_mmio = 0;
+#ifdef CONFIG_PPC
+	if (machine_is(cell))
+		*try_mmio = (tmpbyte & 1) || pci_resource_start(pdev, 5);
+#endif
 
 	switch(tmpbyte & 0x30) {
 		case 0x00:
