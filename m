From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atp867x: add Power Management support
Date: Sun, 20 Sep 2009 23:05:10 +0200
Message-ID: <200909202305.10118.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:43216 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751945AbZITVGg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Sep 2009 17:06:36 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: "John Lee (Jung-Ik)" <jilee@google.com>
Cc: Grant Grundler <grundler@google.com>, Gwendal Gringo <gwendal@google.com>, Jeff Garzik <jgarzik@redhat.com>, linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atp867x: add Power Management support

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
needs testing with the real hardware

 drivers/ata/pata_atp867x.c |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

Index: b/drivers/ata/pata_atp867x.c
===================================================================
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -507,6 +507,23 @@ err_out:
 	return rc;
 }
 
+#ifdef CONFIG_PM
+static int atp867x_reinit_one(struct pci_dev *pdev)
+{
+	struct ata_host *host = dev_get_drvdata(&pdev->dev);
+	int rc;
+
+	rc = ata_pci_device_do_resume(pdev);
+	if (rc)
+		return rc;
+
+	atp867x_fixup(host);
+
+	ata_host_resume(host);
+	return 0;
+}
+#endif
+
 static struct pci_device_id atp867x_pci_tbl[] = {
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867A),	0 },
 	{ PCI_VDEVICE(ARTOP, PCI_DEVICE_ID_ARTOP_ATP867B),	0 },
@@ -518,6 +535,10 @@ static struct pci_driver atp867x_driver 
 	.id_table 	= atp867x_pci_tbl,
 	.probe 		= atp867x_init_one,
 	.remove		= ata_pci_remove_one,
+#ifdef CONFIG_PM
+	.suspend	= ata_pci_device_suspend,
+	.resume		= atp867x_reinit_one,
+#endif
 };
 
 static int __init atp867x_init(void)
