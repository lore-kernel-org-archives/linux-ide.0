From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: [PATCH] IDE: Don't powerdown Compaq Triflex IDE device on suspend
Date: Sun, 15 May 2011 22:32:29 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:53280 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753372Ab1EOUkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2011 16:40:18 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Don't powerdown Compaq Triflex IDE device on suspend

This fixes APM suspend on Compaq Armada 7400.
APM BIOS doesn't suspend if IDE is powered down when suspending.
The Triflex controller is found only on old Compaq boards,
so this patch will hopefully have no side effects.

This patch fixes a suspend regression introduced in 
feb22b7f8e62b1b987a3a1dbad95af767a1df832

Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>

---
 drivers/ide/triflex.c |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

Index: linux-2.6.39-rc7-fast/drivers/ide/triflex.c
===================================================================
--- linux-2.6.39-rc7-fast.orig/drivers/ide/triflex.c	2011-05-09 21:05:37.000000000 +0200
+++ linux-2.6.39-rc7-fast/drivers/ide/triflex.c	2011-05-15 14:06:14.000000000 +0200
@@ -113,12 +113,26 @@ static const struct pci_device_id trifle
 };
 MODULE_DEVICE_TABLE(pci, triflex_pci_tbl);
 
+#ifdef CONFIG_PM
+static int triflex_ide_pci_suspend(struct pci_dev *dev, pm_message_t state)
+{
+	/*
+	 * We must not disable or powerdown the device.
+	 * APM bios refuses to suspend if IDE is not accessible.
+	 */
+	pci_save_state(dev);
+	return 0;
+}
+#else
+#define triflex_ide_pci_suspend NULL
+#endif
+
 static struct pci_driver triflex_pci_driver = {
 	.name		= "TRIFLEX_IDE",
 	.id_table	= triflex_pci_tbl,
 	.probe		= triflex_init_one,
 	.remove		= ide_pci_remove,
-	.suspend	= ide_pci_suspend,
+	.suspend	= triflex_ide_pci_suspend,
 	.resume		= ide_pci_resume,
 };
 
