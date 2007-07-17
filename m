From: Alexey Dobriyan <adobriyan@gmail.com>
Subject: [PATCH] ahci.c: fix CONFIG_PM=n compilation
Date: Tue, 17 Jul 2007 23:48:48 +0400
Message-ID: <20070717194848.GA5824@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:2844 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765523AbXGQTsx (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 17 Jul 2007 15:48:53 -0400
Received: by ug-out-1314.google.com with SMTP id j3so201218ugf
        for <linux-ide@vger.kernel.org>; Tue, 17 Jul 2007 12:48:52 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org

Commit df69c9c5438b4e396a64d42608b2a6c48a3e7475 moved only prototype of
out of CONFIG_PM. Move function out as well. Box seems to boot fine.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/ata/ahci.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1519,6 +1519,14 @@ static void ahci_post_internal_cmd(struct ata_queued_cmd *qc)
 	}
 }
 
+static int ahci_port_resume(struct ata_port *ap)
+{
+	ahci_power_up(ap);
+	ahci_start_port(ap);
+
+	return 0;
+}
+
 #ifdef CONFIG_PM
 static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 {
@@ -1536,14 +1544,6 @@ static int ahci_port_suspend(struct ata_port *ap, pm_message_t mesg)
 	return rc;
 }
 
-static int ahci_port_resume(struct ata_port *ap)
-{
-	ahci_power_up(ap);
-	ahci_start_port(ap);
-
-	return 0;
-}
-
 static int ahci_pci_device_suspend(struct pci_dev *pdev, pm_message_t mesg)
 {
 	struct ata_host *host = dev_get_drvdata(&pdev->dev);

