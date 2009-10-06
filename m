From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/4] pata_atp867x: add Power Management support
Date: Wed, 7 Oct 2009 00:27:25 +0200
Message-ID: <200910070027.25213.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f210.google.com ([209.85.218.210]:39857 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933549AbZJFW2M (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Oct 2009 18:28:12 -0400
Received: by bwz6 with SMTP id 6so3689926bwz.37
        for <linux-ide@vger.kernel.org>; Tue, 06 Oct 2009 15:27:34 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Jung-Ik Lee (John)" <jilee@google.com>, linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_atp867x: add Power Management support

Cc: Jung-Ik (John) Lee <jilee@google.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
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
