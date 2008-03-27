From: akpm@linux-foundation.org
Subject: [patch for 2.6.25? 1/1] pata_sil680: only enable MMIO on Cell blades
Date: Thu, 27 Mar 2008 00:46:45 -0700
Message-ID: <200803270746.m2R7kjIL024193@imap1.linux-foundation.org>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37594 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754805AbYC0HrS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 27 Mar 2008 03:47:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, benh@ozlabs.org, alan@redhat.com, benh@kernel.crashing.org

From: Benjamin Herrenschmidt <benh@ozlabs.org>

There have been reported regressions of the SIL 680 driver when using MMIO, so
this makes it only try MMIO on Cell blades where it's known to be necessary
(the host bridge doesn't do PIO on these).

We'll try to find the root problem with MMIO separately.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Acked-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_sil680.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff -puN drivers/ata/pata_sil680.c~pata_sil680-only-enable-mmio-on-cell-blades drivers/ata/pata_sil680.c
--- a/drivers/ata/pata_sil680.c~pata_sil680-only-enable-mmio-on-cell-blades
+++ a/drivers/ata/pata_sil680.c
@@ -229,7 +229,11 @@ static u8 sil680_init_chip(struct pci_de
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
_
