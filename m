From: Sander Eikelenboom <linux@eikelenboom.it>
Subject: [PATCH] LibATA: Fixup awkward whitespace in warning by removing line continuation.
Date: Sun, 20 Mar 2016 22:27:06 +0100
Message-ID: <1458509226-24080-1-git-send-email-linux@eikelenboom.it>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from server.eikelenboom.it ([91.121.67.170]:35263 "EHLO
	server.eikelenboom.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751020AbcCTVzY (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 20 Mar 2016 17:55:24 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: stripathi@apm.com, linux-ide@vger.kernel.org, Sander Eikelenboom <linux@eikelenboom.it>

Signed-off-by: Sander Eikelenboom <linux@eikelenboom.it>
---
 drivers/ata/libahci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3982054..e13ba72 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -2549,8 +2549,8 @@ int ahci_host_activate(struct ata_host *host, struct scsi_host_template *sht)
 
 	if (hpriv->flags & (AHCI_HFLAG_MULTI_MSI | AHCI_HFLAG_MULTI_MSIX)) {
 		if (hpriv->irq_handler)
-			dev_warn(host->dev, "both AHCI_HFLAG_MULTI_MSI flag set \
-				 and custom irq handler implemented\n");
+			dev_warn(host->dev,
+			         "both AHCI_HFLAG_MULTI_MSI flag set and custom irq handler implemented\n");
 
 		rc = ahci_host_activate_multi_irqs(host, sht);
 	} else {
-- 
2.1.4

