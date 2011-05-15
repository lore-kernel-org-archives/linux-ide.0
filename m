From: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: [PATCH] ATA: Don't powerdown Compaq Triflex IDE device on suspend
Date: Sun, 15 May 2011 22:33:19 +0200 (CEST)
Message-ID: <alpine.DEB.2.00.1105152232390.12411@artax.karlin.mff.cuni.cz>
References: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from artax.karlin.mff.cuni.cz ([195.113.26.195]:54196 "EHLO
	artax.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753195Ab1EOUkS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 15 May 2011 16:40:18 -0400
In-Reply-To: <alpine.DEB.2.00.1105152228530.12411@artax.karlin.mff.cuni.cz>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "David S. Miller" <davem@davemloft.net>, Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org

Don't powerdown Compaq Triflex IDE device on suspend

This fixes APM suspend on Compaq Armada 7400.
APM BIOS doesn't suspend if IDE is powered down when suspending.
The Triflex controller is found only on old Compaq boards,
so this patch will hopefully have no side effects.

Signed-off-by: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>

---
 drivers/ata/pata_triflex.c |   23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

Index: linux-2.6.39-rc7-libata/drivers/ata/pata_triflex.c
===================================================================
--- linux-2.6.39-rc7-libata.orig/drivers/ata/pata_triflex.c	2011-05-09 21:04:22.000000000 +0200
+++ linux-2.6.39-rc7-libata/drivers/ata/pata_triflex.c	2011-05-15 16:13:31.000000000 +0200
@@ -210,13 +210,34 @@ static const struct pci_device_id trifle
 	{ },
 };
 
+#ifdef CONFIG_PM
+static int triflex_ata_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc = 0;
+
+	rc = ata_host_suspend(host, mesg);
+	if (rc)
+		return rc;
+
+	/*
+	 * We must not disable or powerdown the device.
+	 * APM bios refuses to suspend if IDE is not accessible.
+	 */
+	pci_save_state(pdev);
+
+	return 0;
+}
+
+#endif
+
 static struct pci_driver triflex_pci_driver = {
 	.name 		= DRV_NAME,
 	.id_table	= triflex,
 	.probe 		= triflex_init_one,
 	.remove		= ata_pci_remove_one,
 #ifdef CONFIG_PM
-	.suspend	= ata_pci_device_suspend,
+	.suspend	= triflex_ata_pci_device_suspend,
 	.resume		= ata_pci_device_resume,
 #endif
 };

